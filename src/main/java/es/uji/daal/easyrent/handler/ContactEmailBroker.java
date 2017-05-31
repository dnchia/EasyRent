package es.uji.daal.easyrent.handler;

import es.uji.daal.easyrent.utils.EmailParams;
import es.uji.daal.easyrent.utils.VelocityNode;
import es.uji.daal.easyrent.view_models.ContactForm;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Alberto on 18/06/2016.
 */
@Component
public class ContactEmailBroker extends EmailBroker {

    private ContactForm form;

    public ContactEmailBroker setForm(ContactForm form) {
        this.form = form;
        return this;
    }

    public ContactEmailBroker sendContactEmail() {
        Map<String, Object> model = new HashMap<>();
        model.put("contactForm", form);
        fillMachineDetails(model);

        VelocityNode contactTemplate = new VelocityNode("mail/contact.vm", model);
        VelocityNode base = new VelocityNode("mail/boilerplate.vm", model, contactTemplate);

        EmailParams emailParams = new EmailParams()
                .setTo("al286290@uji.es")
                .setSubject("[EasyRent] Message received from #" + form.getName());

        sendEmail(emailParams, base);
        return this;
    }
}
