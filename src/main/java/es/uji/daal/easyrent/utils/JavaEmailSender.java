package es.uji.daal.easyrent.utils;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import javax.mail.internet.MimeMessage;
import java.util.Map;

/**
 * Created by Alberto on 18/06/2016.
 */
@Component
public class JavaEmailSender implements EmailSender {

    @Value("${spring.mail.username}")
    protected String fromEmail;

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void sendEmail(EmailParams params) {

        if (params.undefinedFrom()) {
            params.setFrom(fromEmail);
        }

        MimeMessagePreparator preparator = prepareMessage(params);
        mailSender.send(preparator);
    }

    private MimeMessagePreparator prepareMessage(final EmailParams params) {
        return new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                MimeMessageHelper message = params.needsMultimart() ?
                        new MimeMessageHelper(mimeMessage, true) : new MimeMessageHelper(mimeMessage);
                params.fillMessageBody(message);
            }
        };
    }
}
