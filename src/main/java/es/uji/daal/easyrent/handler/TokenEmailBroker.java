package es.uji.daal.easyrent.handler;

import es.uji.daal.easyrent.model.Token;
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
public class TokenEmailBroker extends EmailBroker {

    private Token token;

    public TokenEmailBroker setToken(Token token) {
        this.token = token;
        return this;
    }

    public TokenEmailBroker sendActivationEmail() {
        Map<String, Object> model = new HashMap<>();
        model.put("activationToken", token);
        fillMachineDetails(model);

        VelocityNode contactTemplate = new VelocityNode("mail/activation.vm", model);
        VelocityNode base = new VelocityNode("mail/boilerplate.vm", model, contactTemplate);

        EmailParams emailParams = new EmailParams()
                .setTo(token.getUser().getEmail())
                .setSubject("[EasyRent] Activate your account");

        sendEmail(emailParams, base);
        return this;
    }
}
