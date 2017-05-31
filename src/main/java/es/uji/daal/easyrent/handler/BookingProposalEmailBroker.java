package es.uji.daal.easyrent.handler;


import es.uji.daal.easyrent.model.BookingProposal;
import es.uji.daal.easyrent.pdf_view.InvoiceView;
import es.uji.daal.easyrent.tags.InvoiceTools;
import es.uji.daal.easyrent.utils.EmailParams;
import es.uji.daal.easyrent.utils.VelocityNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Alberto on 18/06/2016.
 */
@Component
public class BookingProposalEmailBroker extends EmailBroker {

    @Autowired
    private InvoiceView invoiceView;

    private BookingProposal proposal;

    public BookingProposalEmailBroker setProposal(BookingProposal proposal) {
        this.proposal = proposal;
        return this;
    }

    public BookingProposalEmailBroker sendTenantCreationEmail() {
        sendProposalEmail("bp-create-tenant",
                proposal.getTenant().getEmail(),
                "[EasyRent] Your book has been processed correctly for #" + proposal.getProperty().getTitle());
        return this;
    }

    public BookingProposalEmailBroker sendOwnerCreationEmail() {
        sendProposalEmail("bp-create-owner",
                proposal.getProperty().getOwner().getEmail(),
                "[EasyRent] Someone is interested in booking your property #" + proposal.getProperty().getTitle());
        return this;
    }

    public BookingProposalEmailBroker sendTenantRejectionEmail() {
        sendProposalEmail("bp-rejection",
                proposal.getTenant().getEmail(),
                "[EasyRent] Proposal not accepted for property #" + proposal.getProperty().getTitle());
        return this;
    }

    public BookingProposalEmailBroker sendTenantAcceptationEmail() {
        Map<String, Object> model = new HashMap<>();
        fillMachineDetails(model);
        fillModelDetails(model);

        VelocityNode proposalTemplate = new VelocityNode("mail/booking-proposal.vm", model);
        VelocityNode createTenantTemplate = new VelocityNode("mail/bp-acceptation.vm", model, proposalTemplate);
        VelocityNode base = new VelocityNode("mail/boilerplate.vm", model, createTenantTemplate);

        Map<String, Object> invoiceModel = new HashMap<>();
        invoiceModel.put("invoice", proposal.getInvoice());


        ByteArrayResource pdfFile = null;
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            invoiceView.compileTemplate(invoiceModel, baos, null, null);
            pdfFile = new ByteArrayResource(baos.toByteArray());
        } catch (Exception e) {
            e.printStackTrace();
        }

        EmailParams emailParams = new EmailParams()
                .setTo(proposal.getTenant().getEmail())
                .setSubject("[EasyRent] Congratulations! Your proposal has been accepted #" + proposal.getProperty().getTitle());

        if (pdfFile != null) {
            emailParams.addAttachment("invoice.pdf", pdfFile);
        }

        sendEmail(emailParams, base);
        return this;
    }

    public BookingProposalEmailBroker sendExpirationTenantEmail() {
        sendProposalEmail("bp-expiration-tenant",
                proposal.getTenant().getEmail(),
                "[EasyRent] Proposal has expired for property #" + proposal.getProperty().getTitle());
        return this;
    }

    public BookingProposalEmailBroker sendExpirationOwnerEmail() {
        sendProposalEmail("bp-expiration-owner",
                proposal.getProperty().getOwner().getEmail(),
                "[EasyRent] Proposal has expired for property #" + proposal.getProperty().getTitle());
        return this;
    }

    private void sendProposalEmail(String middleTemplate, String email, String subject) {
        Map<String, Object> model = new HashMap<>();
        fillMachineDetails(model);
        fillModelDetails(model);

        VelocityNode proposalTemplate = new VelocityNode("mail/booking-proposal.vm", model);
        VelocityNode createTenantTemplate = new VelocityNode("mail/"+middleTemplate+".vm", model, proposalTemplate);
        VelocityNode base = new VelocityNode("mail/boilerplate.vm", model, createTenantTemplate);

        EmailParams emailParams = new EmailParams()
                .setTo(email)
                .setSubject(subject);

        sendEmail(emailParams, base);
    }

    private void fillModelDetails(Map<String, Object> model) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat sdfTimestamp = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        model.put("bookingProposal", proposal);
        model.put("vat", InvoiceTools.VAT);
        model.put("startDate", sdf.format(proposal.getStartDate()));
        model.put("endDate", sdf.format(proposal.getEndDate()));
        model.put("dateOfCreation", sdfTimestamp.format(proposal.getDateOfCreation()));
        model.put("totalAmount", String.format("%.02f%s", proposal.getTotalAmount() * (1+InvoiceTools.VAT), CURRENCY));
        model.put("pricePerDay", String.format("%.02f%s", proposal.getProperty().getPricePerDay() * (1+InvoiceTools.VAT), CURRENCY));
    }
}
