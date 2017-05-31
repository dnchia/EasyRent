package es.uji.daal.easyrent.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.model.Service;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.repository.PropertyRepository;
import es.uji.daal.easyrent.repository.ServiceRepository;
import es.uji.daal.easyrent.utils.Strings;
import es.uji.daal.easyrent.validators.ServiceValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * Created by daniel on 11/05/16.
 */
@Controller
@RequestMapping("/service")
public class ServiceController {
    @Autowired
    private ServiceRepository repository;

    @Autowired
    private PropertyRepository propertyRepository;

    @ResponseBody
    @RequestMapping(value = "/property/{propertyId}/list")
    public String processAddSubmit(@RequestParam(value = "type", defaultValue = "storage") String type,
                                   @PathVariable("propertyId") String propertyId,
                                   HttpSession session) {
        UploadType uploadType = UploadType.valueOf(type.toUpperCase());
        ObjectMapper om = new ObjectMapper();

        if (uploadType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            if (addProperty == null) {
                return "ERROR";
            }
            List<Service> services = (List<Service>) addProperty.get("services");
            try {
                return om.writeValueAsString(services);
            } catch (JsonProcessingException e) {
                return "[]";
            }
        } else {
            Property property = propertyRepository.findOne(UUID.fromString(propertyId));
            try {
                return om.writeValueAsString(property.getServices());
            } catch (JsonProcessingException e) {
                return "[]";
            }
        }
    }

    @ResponseBody
    @RequestMapping(value = "/property/{propertyId}/add", method = RequestMethod.POST)
    public String processAddSubmit(@RequestParam("name") String name,
                                   @RequestParam(value = "type", defaultValue = "storage") String type,
                                   @PathVariable("propertyId") String propertyId,
                                   HttpSession session) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String value = Strings.underscore(name);
        Service service = repository.findByValue(value);
        if (service == null) {
            service = new Service(loggedUser);
            service.setName(name);
            service.setValue(value);
        }

        UploadType uploadType = UploadType.valueOf(type.toUpperCase());

        if (uploadType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            if (addProperty == null) {
                return "ERROR";
            }
            List<Service> services = (List<Service>) addProperty.get("services");
            for (Service s : services) {
                if (service.getValue().equals(s.getValue())) {
                    return "ERROR";
                }
            }
            services.add(service);
        } else {
            Property property = propertyRepository.findOne(UUID.fromString(propertyId));
            property.addService(service);
            repository.save(service);
        }

        return "OK";
    }

    @ResponseBody
    @RequestMapping(value = "/property/{propertyId}/remove/{id}", method = RequestMethod.POST)
    public String processRemoveSubmit(@RequestParam(value = "type", defaultValue = "storage") String type,
                                      @PathVariable("propertyId") String propertyId, @PathVariable("id") String id,
                                      HttpSession session) {
        UploadType uploadType = UploadType.valueOf(type.toUpperCase());

        if (uploadType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            if (addProperty == null) {
                return "ERROR";
            }
            List<Service> services = (List<Service>) addProperty.get("services");
            int index = Integer.parseInt(id);
            services.remove(index);
        } else {
            Service service = repository.findOne(UUID.fromString(id));
            Property property = propertyRepository.findOne(UUID.fromString(propertyId));
            property.removeService(service);
            repository.save(service);
        }

        return "OK";
    }
}
