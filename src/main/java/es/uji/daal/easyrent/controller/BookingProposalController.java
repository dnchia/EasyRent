package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.handler.BookingProposalEmailBroker;
import es.uji.daal.easyrent.model.*;
import es.uji.daal.easyrent.repository.AvailabilityPeriodRepository;
import es.uji.daal.easyrent.repository.BookingProposalRepository;
import es.uji.daal.easyrent.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

/**
 * Created by Alberto on 17/05/2016.
 */

@Controller
@RequestMapping("/booking-proposal")
public class BookingProposalController {

    @Autowired
    private BookingProposalRepository repository;

    @Autowired
    private AvailabilityPeriodRepository periodRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private BookingProposalEmailBroker emailBroker;

    @RequestMapping("/show/{id}")
    public String show(Model model, @PathVariable("id") String id) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        BookingProposal proposal = repository.findOne(UUID.fromString(id));
        if (loggedUser.equals(proposal.getTenant()) || loggedUser.equals(proposal.getProperty().getOwner())) {
            model.addAttribute("bookingProposal", proposal);
            return "bookingProposal/show";
        }
        return "redirect:../../index.html";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(Model model, @PathVariable("id") String id) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        BookingProposal proposal = repository.findOne(UUID.fromString(id));
        if (loggedUser.equals(proposal.getTenant()) && proposal.getStatus() == ProposalStatus.PENDING) {
            model.addAttribute("numberOfTenants", proposal.getNumberOfTenants());
            model.addAttribute("bookingProposal", proposal);
            return "bookingProposal/edit";
        }
        return "redirect:../../index.html";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String processEdit(@RequestParam("numberOfTenants") String numberOfTenants,
                              @PathVariable("id") String id) {
        BookingProposal proposal = repository.findOne(UUID.fromString(id));
        proposal.setNumberOfTenants(Integer.parseInt(numberOfTenants));
        repository.save(proposal);
        return "redirect:../edit/" + id + ".html?success=be";
    }

    @RequestMapping("/reject/{id}")
    public String reject(@PathVariable("id") String id) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        BookingProposal proposal = repository.findOne(UUID.fromString(id));
        if (loggedUser.equals(proposal.getProperty().getOwner()) && proposal.getStatus() == ProposalStatus.PENDING) {
            proposal.reject();
            repository.save(proposal);

            AvailabilityPeriod period = proposal.getProperty().createAvailabilityPeriod();
            period.setStartDate(proposal.getStartDate());
            period.setEndDate(proposal.getEndDate());
            periodRepository.save(period);

            User owner = proposal.getProperty().getOwner();
            Notification bookingRejected = proposal.getTenant().createNotification(NotificationType.BOOKING_REJECTED);
            bookingRejected.setTargetId(proposal.getId());
            bookingRejected.setSource(proposal.getProperty().getOwner().getUsername());
            bookingRejected.setDestination(proposal.getProperty().getTitle());
            if (owner.getPhoto() != null) {
                bookingRejected.setThumbnail(owner.getPhoto().getFilename());
            }
            notificationRepository.save(bookingRejected);

            emailBroker
                    .setProposal(proposal)
                    .sendTenantRejectionEmail();

            return "redirect:../../index.html?success=bpr#owner-proposals";
        }
        return "redirect:../../index.html";
    }

    @RequestMapping("/accept/{id}")
    public String accept(@PathVariable("id") String id) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        BookingProposal proposal = repository.findOne(UUID.fromString(id));
        if (loggedUser.equals(proposal.getProperty().getOwner()) && proposal.getStatus() == ProposalStatus.PENDING) {
            proposal.accept();
            Invoice invoice = proposal.createInvoice();

            User tenant = proposal.getTenant();
            invoice.setAddress(tenant.getPostalAddress());
            invoice.setCountry(tenant.getCountry());
            invoice.setPostCode(tenant.getPostCode());

            repository.save(proposal);

            User owner = proposal.getProperty().getOwner();
            Notification bookingAccepted = proposal.getTenant().createNotification(NotificationType.BOOKING_ACCEPTED);
            bookingAccepted.setTargetId(proposal.getId());
            bookingAccepted.setSource(owner.getUsername());
            bookingAccepted.setDestination(proposal.getProperty().getTitle());
            if (owner.getPhoto() != null) {
                bookingAccepted.setThumbnail(owner.getPhoto().getFilename());
            }
            notificationRepository.save(bookingAccepted);

            emailBroker
                    .setProposal(proposal)
                    .sendTenantAcceptationEmail();
            return "redirect:../../index.html?success=bpa#owner-proposals";
        }
        return "redirect:../../index.html";
    }
}
