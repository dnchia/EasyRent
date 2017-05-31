package es.uji.daal.easyrent.pdf_view;

import com.itextpdf.text.pdf.*;
import es.uji.daal.easyrent.model.BookingProposal;
import es.uji.daal.easyrent.model.Invoice;
import es.uji.daal.easyrent.utils.DateUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Map;

/**
 * Created by Alberto on 18/06/2016.
 */
@Component
public class InvoiceView extends AbstractITextPdfView{

    private static final String TEMPLATE_SRC = "pdf/en_template.pdf";
    private static String DATE_FORMAT;
    private static String CURRENCY = "€";

    @Value("${spring.mvc.date-format}")
    public void setDateFormat(String format) {
        DATE_FORMAT = format;
    }

    @Override
    public void compileTemplate(Map<String, Object> model, ByteArrayOutputStream outputStream, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ClassLoader loader = getClass().getClassLoader();
        PdfReader template = new PdfReader(loader.getResourceAsStream(TEMPLATE_SRC));

        Invoice invoice = (Invoice) model.get("invoice");
        BookingProposal proposal = invoice.getProposal();

        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);

        PdfStamper compiled = new PdfStamper(template, outputStream);
        AcroFields form = compiled.getAcroFields();
        form.setGenerateAppearances(true);

        int numberOfDays = DateUtils.daysBetweenDates(proposal.getStartDate(), proposal.getEndDate()) + 1;

        form.setField("invoiceNumber", String.format("%05d", invoice.getNumber()));
        form.setField("expeditionDate", sdf.format(invoice.getExpeditionDate()));
        form.setField("totalAmount", String.format("%.02f%s", proposal.getTotalAmount(), CURRENCY));
        form.setField("tenantName", String.format("%s %s", proposal.getTenant().getName(), proposal.getTenant().getSurnames()));
        form.setField("tenantNid", proposal.getTenant().getDni());
        form.setField("address", invoice.getAddress());
        form.setField("country", invoice.getCountry());
        form.setField("postCode", String.valueOf(invoice.getPostCode()));
        form.setField("numberOfDays", String.valueOf(numberOfDays));
        form.setField("numberOfTenants", String.valueOf(proposal.getNumberOfTenants()));
        form.setField("daysDescription", String.format("Property rental from %s to %s",
                sdf.format(proposal.getStartDate()), sdf.format(proposal.getEndDate())));
        form.setField("tenantsDescription", String.format("Tenants that rented the property #B%s", proposal.getId()));
        form.setField("pricePerDay", String.format("%.02f%s", proposal.getTotalAmount() / ((float) numberOfDays), CURRENCY));
        form.setField("pricePerTenant", String.format("%.02f%s", 0.0f, CURRENCY));
        form.setField("daysTotal", String.format("%.02f%s", proposal.getTotalAmount(), CURRENCY));
        form.setField("tenantsTotal", String.format("%.02f%s", 0.0f, CURRENCY));
        form.setField("netTotal", String.format("%.02f%s", proposal.getTotalAmount(), CURRENCY));
        form.setField("totalVat", String.format("%.0f%%", invoice.getVat()*100));
        form.setField("totalAmount", String.format("%.02f%s", proposal.getTotalAmount() * (invoice.getVat()+1), CURRENCY));

        compiled.setFormFlattening(true);
        compiled.close();
    }


}
