package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.Service;
import es.uji.daal.easyrent.repository.ServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

/**
 * Created by daniel on 13/06/16.
 */

@Controller
@RequestMapping("/administration/services")
public class AdministrationServicesSearchController {

    @Autowired
    ServiceRepository repository;

    @RequestMapping("/searchFor")
    public String searchFor(@RequestParam String searchedFor, @RequestParam String selectedServiceAttribute, Model model) {

        if (AdministrationController.userIsAdmin()) {
            List<Service> searchResult = new LinkedList<>();

            switch (selectedServiceAttribute) {

                case "name":
                    searchResult = repository.searchByNameContainedInSearchedName(searchedFor);
                    break;

                case "proposedByUser":
                    searchResult = repository.searchByUserContainedInSearchedUser(searchedFor);
                    break;

                case "active":
                    Boolean active;
                    try {
                        active = Boolean.valueOf(searchedFor);
                        searchResult = repository.findActive(active);
                    }
                    catch (NumberFormatException e) {

                    }
                    break;

                case "creationDate":
                    Date creationDate;
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        creationDate = formatter.parse(searchedFor);
                        long day = creationDate.getTime();
                        searchResult = repository.findByCreationDateBetween(new Date(day), new Date(day + 86399999));
                    }
                    catch (ParseException e) {

                    }
                    break;

                case "activeSince":
                    Date activeSince;
                    formatter = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        activeSince = formatter.parse(searchedFor);
                        long day = activeSince.getTime();
                        searchResult = repository.findByActiveSinceBetween(new Date(day), new Date(day + 86399999));
                    }
                    catch (ParseException e) {

                    }
                    break;

                case "serviceProposals":
                    Integer proposals;
                    try {
                        proposals = Integer.parseInt(searchedFor);
                        searchResult = repository.findByServiceProposals(proposals);
                    }
                    catch (NumberFormatException e) {

                    }
                    break;
            }

            model.addAttribute("services", searchResult);
            mostDemandedServices(model);

            return "administration/services";
        }

        return "index";
    }

    //TODO: Funcional, pero seguramente mejorable computacionalmente
    private void mostDemandedServices(Model model) {
        List<Service> mostDemandedServices;
        mostDemandedServices = repository.findTop5MostDemandedServices(new PageRequest(0, 5));
        model.addAttribute("mostDemandedServices", mostDemandedServices);
    }

    @RequestMapping("/changeState/{id}")
    public String processChangeState(@ModelAttribute("service") Service service, @PathVariable(value = "id") String id, Model model) {

        if (AdministrationController.userIsAdmin()) {
            Service changedService;
            UUID serviceID = UUID.fromString(id);

            if (repository.exists(serviceID)) {
                changedService = new Service(repository.findOne(serviceID));

                if (!changedService.getActive()) {
                    changedService.setActive(true);
                    if (changedService.getActiveSince() == null)
                        changedService.setActiveSince(new java.sql.Date(System.currentTimeMillis()));
                }
                else
                    changedService.setActive(false);

                repository.save(changedService);
            }
            mostDemandedServices(model);
            return "redirect:../";
        }

        return "index";
    }

    @RequestMapping("/delete/{id}")
    public String processDelete(@PathVariable(value = "id") String id) {

        if (AdministrationController.userIsAdmin()) {
            UUID serviceID = UUID.fromString(id);
            if (repository.exists(serviceID))
                repository.delete(serviceID);

            return "redirect:../";
        }

        return "index";
    }
}
