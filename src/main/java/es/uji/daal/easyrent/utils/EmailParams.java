package es.uji.daal.easyrent.utils;

import org.springframework.core.io.InputStreamSource;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.internet.ContentType;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by Alberto on 18/06/2016.
 */
public class EmailParams {
    private String to;
    private String from;
    private String subject;
    private String text;
    private List<EmailAttachment> attachments = new LinkedList<>();

    public EmailParams setTo(String to) {
        this.to = to;
        return this;
    }

    public EmailParams setFrom(String from) {
        this.from = from;
        return this;
    }

    public EmailParams setSubject(String subject) {
        this.subject = subject;
        return this;
    }

    public EmailParams setText(String text) {
        this.text = text;
        return this;
    }

    public EmailParams addAttachment(String filename, InputStreamSource source) {
        attachments.add(new EmailAttachment(filename, source));
        return this;
    }

    public void fillMessageBody(MimeMessageHelper message) throws Exception {
        if (notNull(to)) {
            message.setTo(to);
        }
        if (notNull(from)) {
            message.setFrom(from);
        }
        if (notNull(subject)) {
            message.setSubject(subject);
        }
        if (notNull(text)) {
            message.setText(text, true);
        }
        for (EmailAttachment attachment : attachments) {
            message.addAttachment(attachment.filename, attachment.streamSource);
        }
    }

    public boolean undefinedFrom() {
        return from == null;
    }

    public boolean needsMultimart() {
        return !attachments.isEmpty();
    }

    private boolean notNull(Object o) {
        return o != null;
    }

    private class EmailAttachment {
        public String filename;
        public InputStreamSource streamSource;

        public EmailAttachment(String filename, InputStreamSource streamSource) {
            this.filename = filename;
            this.streamSource = streamSource;
        }
    }
}
