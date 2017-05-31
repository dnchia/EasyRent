package es.uji.daal.easyrent.handler;

import es.uji.daal.easyrent.utils.EmailParams;
import es.uji.daal.easyrent.utils.EmailSender;
import es.uji.daal.easyrent.utils.VelocityNode;
import es.uji.daal.easyrent.utils.VelocityNodeRenderer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by Alberto on 18/06/2016.
 */
@Component
public abstract class EmailBroker {
    @Autowired
    private EmailSender emailSender;

    @Value("${easyrent.http.host}")
    protected String host;

    @Value("${easyrent.http.port}")
    protected String port;

    protected String CURRENCY = "€";

    @Autowired
    private VelocityNodeRenderer nodeRenderer;

    @Async
    protected void sendEmail(EmailParams params, VelocityNode rootNode) {
        String body = nodeRenderer.renderViewTree(rootNode);
        params.setText(body);
        emailSender.sendEmail(params);
    }

    protected void fillMachineDetails(Map<String, Object> model) {
        model.put("host", host);
        model.put("port", port);
    }
}
