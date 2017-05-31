package es.uji.daal.easyrent.handler;

import es.uji.daal.easyrent.model.ConversationMessage;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.utils.EmailParams;
import es.uji.daal.easyrent.utils.VelocityNode;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Alberto on 18/06/2016.
 */
@Component
public class ConversationEmailBroker extends EmailBroker {

    private ConversationMessage message;

    public ConversationEmailBroker setMessage(ConversationMessage message) {
        this.message = message;
        return this;
    }

    public ConversationEmailBroker sendNotificationEmail() {
        Map<String, Object> model = new HashMap<>();
        model.put("message", message);
        fillMachineDetails(model);

        VelocityNode contactTemplate = new VelocityNode("mail/message.vm", model);
        VelocityNode base = new VelocityNode("mail/boilerplate.vm", model, contactTemplate);

        User user = message.getConversation().getTenant();
        if (message.getUser().equals(user)) {
            user = message.getConversation().getProperty().getOwner();
        }

        EmailParams emailParams = new EmailParams()
                .setTo(user.getEmail())
                .setSubject("[EasyRent] New message from " + message.getUser().getUsername());

        sendEmail(emailParams, base);
        return this;
    }
}
