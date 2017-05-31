package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.BookingProposal;
import es.uji.daal.easyrent.repository.BookingProposalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

/**
 * Created by daniel on 12/06/16.
 */

@Controller
@RequestMapping("/administration/booking_proposals")
public class AdministrationBookingProposalsSearchController {

    @Autowired
    BookingProposalRepository repository;

    @RequestMapping("/searchFor")
    public String searchFor(@RequestParam String searchedFor, @RequestParam String selectedBookingProposalsAttribute, Model model) {

        if (AdministrationController.userIsAdmin()) {
            List<BookingProposal> searchResult = new LinkedList<>();

            switch (selectedBookingProposalsAttribute) {
                case "propertyTitle":
                    searchResult = repository.findByPropertyTitleContainedInSearchedPropertyTitle(searchedFor);
                    break;

                case "tenantUsername":
                    searchResult = repository.findByTenantUsernameContainedInSearchedTenantUsername(searchedFor);
                    break;

                case "startDate":
                    Date startDate;
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        startDate = formatter.parse(searchedFor);
                        long day = startDate.getTime();
                        searchResult = repository.findByStartDateBetween(new Date(day), new Date(day + 86399999));
                    }
                    catch (ParseException e) {

                    }

                    break;

                case "endDate":
                    Date endDate;
                    formatter = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        endDate = formatter.parse(searchedFor);
                        long day = endDate.getTime();
                        searchResult = repository.findByEndDateBetween(new Date(day), new Date(day + 86399999));
                    }
                    catch (ParseException e) {

                    }

                    break;

                case "status":
                    searchResult = repository.findByStatus(searchedFor);
                    break;

                case "paymentReference":
                    searchResult = repository.findByPaymentReferenceContainedInSearchedPaymentReference(searchedFor);
                    break;

                case "totalAmount":
                    Float totalAmount;
                    try {
                        totalAmount = Float.parseFloat(searchedFor);
                    }
                    catch (NumberFormatException e) {
                        totalAmount = -1f;
                    }
                    searchResult = repository.findByTotalAmount(totalAmount);
                    break;

                case "numberOfTenants":
                    Integer numberOfTenants;
                    try {
                        numberOfTenants = Integer.parseInt(searchedFor);
                    }
                    catch(NumberFormatException e) {
                        numberOfTenants = -1;
                    }
                    searchResult = repository.findByNumberOfTenants(numberOfTenants);
                    break;

                case "dateOfCreation":
                    Date dateOfCreation;
                    formatter = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        dateOfCreation = formatter.parse(searchedFor);
                        long day = dateOfCreation.getTime();
                        searchResult = repository.findByDateOfCreationBetween(new Date(day), new Date(day + 86399999));
                    }
                    catch (ParseException e) {

                    }

                    break;

                case "dateOfAcceptance":
                    Date dateOfAcceptance;
                    formatter = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        dateOfAcceptance = formatter.parse(searchedFor);
                        long day = dateOfAcceptance.getTime();
                        searchResult = repository.findByDateOfUpdateBetween(new Date(day), new Date(day + 86399999));
                    }
                    catch (ParseException e) {

                    }

                    break;

                case "invoiceNumber":
                    Integer number;
                    try {
                        number = Integer.parseInt(searchedFor);
                    }
                    catch (NumberFormatException e) {
                        number = -1;
                    }
                    searchResult = repository.findByInvoiceNumber(number);
                    break;
            }

            model.addAttribute("bookingProposals", searchResult);

            return "administration/booking_proposals";
        }

        return "index";
    }

    @RequestMapping("/delete/{id}")
    public String processDelete(@PathVariable(value = "id") String id) {

        if (AdministrationController.userIsAdmin()) {
            UUID bookingProposalID = UUID.fromString(id);
            if (repository.exists(bookingProposalID))
                repository.delete(bookingProposalID);

            return "redirect:../";
        }

        return "index";
    }
}
