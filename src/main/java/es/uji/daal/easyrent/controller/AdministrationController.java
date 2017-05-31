package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.Service;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.model.UserRole;
import es.uji.daal.easyrent.repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by daniel on 14/05/16.
 */
@Controller
@RequestMapping("/administration")
public class AdministrationController {

    @Autowired
    ServiceRepository repository;

    @RequestMapping(value = { "/", "", "/users"})
    public String users() {

        if (userIsAdmin())
            return "administration/users";

        return "index";
    }

    @RequestMapping("/properties")
    public String properties() {
        if (userIsAdmin())
            return "administration/properties";

        return "index";
    }

    @RequestMapping("/booking_proposals")
    public String bookingProposals() {

        if (userIsAdmin())
            return "administration/booking_proposals";

        return "index";
    }

    @RequestMapping("/invoices")
    public String invoices() {

        if (userIsAdmin())
            return "administration/invoices";

        return "index";
    }

    @RequestMapping("/services")
    public String services(Model model) {

        if (userIsAdmin()) {
            List<Service> mostDemandedServices;
            mostDemandedServices = repository.findTop5MostDemandedServices(new PageRequest(0, 5));
            model.addAttribute("mostDemandedServices", mostDemandedServices);
            return "administration/services";
        }

        return "index";
    }

    @ModelAttribute("numberOfServicesNotActive")
    public int numberOfServicesNotActive() {
        return repository.findNumberOfServicesNotActive();
    }

    public static boolean userIsAdmin() {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return loggedUser.getRole().equals(UserRole.ADMINISTRATOR);
    }
}
