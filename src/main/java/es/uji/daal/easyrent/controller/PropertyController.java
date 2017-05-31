package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.handler.ConversationEmailBroker;
import es.uji.daal.easyrent.model.*;

import es.uji.daal.easyrent.repository.*;
import es.uji.daal.easyrent.utils.AddressGeocoder;
import es.uji.daal.easyrent.utils.DateUtils;
import es.uji.daal.easyrent.utils.FileUploader;
import es.uji.daal.easyrent.validators.AddressInfoValidator;
import es.uji.daal.easyrent.validators.BookingValidator;
import es.uji.daal.easyrent.validators.PersonalDataValidator;
import es.uji.daal.easyrent.validators.PropertyValidator;
import es.uji.daal.easyrent.view_models.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.*;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Created by daniel on 23/04/16.
 */

@Controller
@RequestMapping("/property")
public class PropertyController {
    @Autowired
    private PropertyRepository repository;

    @Autowired
    private FileUploader fileUploader;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private GeographicLocationRepository locationRepository;

    @Autowired
    private ConversationRepository conversationRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private AddressGeocoder geocoder;

    @Autowired
    private ConversationEmailBroker emailBroker;

    @RequestMapping("/show/{id}")
    public String show(Model model, @PathVariable("id") String id) {
        Property property = repository.findOne(UUID.fromString(id));
        model.addAttribute("property", property);
        return "property/show";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String update(Model model, @PathVariable(value = "id") String id) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Property property = repository.findOne(UUID.fromString(id));

        if (!loggedUser.equals(property.getOwner())) {
            return "redirect:../show/" + id + ".html";
        }

        model.addAttribute("propertyForm", new PropertyForm().fillUp(property));
        fillEditPage(model, property);
        return "property/edit";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String processUpdateSubmit(@ModelAttribute("propertyForm") PropertyForm propertyForm,
                                      BindingResult bindingResult,
                                      @PathVariable("id") String id,
                                      Model model) {
        PropertyValidator validator = new PropertyValidator();
        validator.validate(propertyForm, bindingResult);

        Property property = repository.findOne(UUID.fromString(id));
        fillEditPage(model, property);
        if (bindingResult.hasErrors()) {
            return "property/edit";
        }

        GeographicLocation location = locationRepository.findByFullAddress(propertyForm.getLocation());
        if (location == null) {
            try {
                location = geocoder.geocode(propertyForm.getLocation());
            } catch (IOException e) {
                Logger.getAnonymousLogger().severe("Unable to geolocate the specified address: " + propertyForm.getLocation());
            }
        }
        property.setGeographicLocation(location);
        locationRepository.save(location);


        repository.save(propertyForm.update(property));
        return "redirect:" + id + ".html?success=t";
    }

    private void fillEditPage(Model model, Property property) {
        model.addAttribute("property", property);
        model.addAttribute("availabilityForm", new AvailabilityForm());
    }

    @RequestMapping(value = "/delete/{id}")
    public String processDelete(@PathVariable(value = "id") String id) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        UUID propertyId = UUID.fromString(id);
        if (repository.exists(propertyId)) {
            Property property = repository.findOne(propertyId);
            if (!loggedUser.equals(property.getOwner())) {
                return "redirect:../show/" + id + ".html#owner";
            }
            if (property.getBookingProposals().size() > 0) {
                return "redirect:../../index.html?error=dp#owner-properties";
            }
            repository.delete(propertyId);
            return "redirect:../../index.html?success=pd#owner";
        }
        return "redirect:../../index.html#owner";
    }

    @ResponseBody
    @RequestMapping(value = "/{propertyId}/upload-photos", method = RequestMethod.POST)
    public String add(@RequestParam(value = "type", defaultValue = "storage") String type,
                      @RequestParam("file") MultipartFile file,
                      HttpSession session, @PathVariable("propertyId") String propertyId) {
        UploadType requestType = UploadType.valueOf(type.toUpperCase());
        if (requestType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            if (addProperty != null) {
                Set<String> propertyPhotos = (Set<String>) addProperty.get("propertyPhotos");
                String filename = fileUploader.upload("property-pics", file);
                if (filename != null) {
                    propertyPhotos.add(filename);
                    return filename;
                }
                return "none";
            }
            return "none";
        } else {
            Property property = repository.findOne(UUID.fromString(propertyId));
            String filename = fileUploader.upload("property-pics", file);
            if (filename != null) {
                Photo photo = property.createPhoto(filename);
                photoRepository.save(photo);
                return filename;
            }
            return "none";
        }
    }

    @RequestMapping(value = "/{propertyId}/start-conversation", method = RequestMethod.POST)
    public String startConversation(@RequestParam("message") String message,
                                    @PathVariable("propertyId") String propertyId) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Property property = repository.findOne(UUID.fromString(propertyId));

        if (property.getOwner().equals(loggedUser)) {
            return "redirect:../show/"+propertyId+".html";
        }

        Conversation conversation = property.createConversation(loggedUser);
        ConversationMessage conversationMessage = conversation.createMessage(loggedUser);
        conversationMessage.setMessage(message);
        conversationRepository.save(conversation);

        Notification conversationStarted = property.getOwner().createNotification(NotificationType.CONVERSATION_STARTED);
        conversationStarted.setTargetId(conversation.getId());
        conversationStarted.setSource(conversation.getTenant().getUsername());
        conversationStarted.setDestination(property.getTitle());
        if (conversation.getTenant().getPhoto() != null) {
            conversationStarted.setThumbnail(conversation.getTenant().getPhoto().getFilename());
        }
        notificationRepository.save(conversationStarted);

        emailBroker.setMessage(conversationMessage).sendNotificationEmail();

        return "redirect:../show/"+propertyId+".html?success=ms";
    }
}
