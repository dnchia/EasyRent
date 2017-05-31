package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.AvailabilityPeriod;
import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.repository.AvailabilityPeriodRepository;
import es.uji.daal.easyrent.repository.PropertyRepository;
import es.uji.daal.easyrent.utils.BookingUtils;
import es.uji.daal.easyrent.view_models.AvailabilityForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by daniel on 3/05/16.
 */
@Controller
@RequestMapping("/property/availability-period") //FIXME me he cargado algo, creo que no lo usábamos ya
public class AvailabilityPeriodController {
    @Autowired
    AvailabilityPeriodRepository repository;

    @Autowired
    PropertyRepository propertyRepository;

    @RequestMapping(value = "/{propertyId}/add", method = RequestMethod.POST)
    public String add(@RequestParam(value = "type", defaultValue = "storage") String type,
                      @ModelAttribute AvailabilityForm availabilityForm,
                      BindingResult bindingResult,
                      HttpSession session, @PathVariable("propertyId") String propertyId) {
        UploadType requestType = UploadType.valueOf(type.toUpperCase());
        if (requestType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            List<AvailabilityForm> availabilities = (List<AvailabilityForm>) addProperty.get("availabilityPeriods");
            if (!bindingResult.hasErrors()) {
                availabilities.add(availabilityForm);
            }
            return "redirect:../../add.html?step=3";
        } else {
            Property property = propertyRepository.findOne(UUID.fromString(propertyId));
            if (!bindingResult.hasErrors()) {
                if (BookingUtils.isPeriodCollidingWithProposals(availabilityForm, property.getBookingProposals())) {
                    return "redirect:../../edit/" + property.getId() + ".html?error=ap#edit-availability-dates";
                }
                AvailabilityPeriod period = property.createAvailabilityPeriod();
                repository.save(availabilityForm.update(period));
            }
            return "redirect:../../edit/" + property.getId() + ".html#edit-availability-dates";
        }
    }

    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    public String update(@RequestParam(value = "type", defaultValue = "storage") String type,
                         @PathVariable("id") String id,
                         @ModelAttribute AvailabilityForm availabilityForm,
                         BindingResult bindingResult,
                         HttpSession session) {
        UploadType requestType = UploadType.valueOf(type.toUpperCase());
        if (requestType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            List<AvailabilityForm> availabilities = (List<AvailabilityForm>) addProperty.get("availabilityPeriods");
            if (!bindingResult.hasErrors()) {
                int index = Integer.parseInt(id);
                availabilities.set(index, availabilityForm);
            }
            return "redirect:../../add.html?step=3";
        } else {
            AvailabilityPeriod period = repository.findOne(UUID.fromString(id));
            if (!bindingResult.hasErrors()) {
                if (BookingUtils.isPeriodCollidingWithProposals(availabilityForm, period.getProperty().getBookingProposals())) {
                    return "redirect:../../edit/" + period.getProperty().getId() + ".html?error=ap#edit-availability-dates";
                }
                repository.save(availabilityForm.update(period));
            }
            return "redirect:../../edit/" + period.getProperty().getId() + ".html#edit-availability-dates";
        }
    }

    @RequestMapping(value = "/delete/{id}")
    public String delete(@RequestParam(value = "type", defaultValue = "storage") String type,
                         @PathVariable("id") String id,
                         HttpSession session) {
        UploadType requestType = UploadType.valueOf(type.toUpperCase());
        if (requestType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            List<AvailabilityForm> availabilities = (List<AvailabilityForm>) addProperty.get("availabilityPeriods");
            int index = Integer.parseInt(id);
            availabilities.remove(index);
            return "redirect:../../add.html?step=3";
        } else {
            AvailabilityPeriod period = repository.findOne(UUID.fromString(id));
            User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (!loggedUser.equals(period.getProperty().getOwner())) {
                return "redirect:../../show/" + period.getProperty().getId() + ".html";
            }
            repository.delete(period);
            return "redirect:../../edit/" + period.getProperty().getId() + ".html#edit-availability-dates";
        }
    }
}
