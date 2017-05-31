package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.view_models.AccountInfoForm;
import es.uji.daal.easyrent.view_models.ContactForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by Alberto on 12/05/2016.
 */
public class ContactFormValidator implements Validator {
    private final boolean validCaptcha;

    public ContactFormValidator(boolean validCaptcha) {

        this.validCaptcha = validCaptcha;
    }

    @Override
    public boolean supports(Class<?> cls) {
        return ContactForm.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        ContactForm form = (ContactForm) obj;

        if (!validCaptcha) {
            errors.rejectValue("captcha", "invalid", "Please, captcha validation is required");
        }

        if (form.getName().equals("")) {
            errors.rejectValue("name", "invalid", "A man needs a name.");
        }

        if (form.getEmail().equals("")) {
            errors.rejectValue("email", "invalid", "An email is needed so we can reply you");
        }

        if (form.getSubject().equals("")) {
            errors.rejectValue("subject", "invalid", "Please, tell us why are you contacting us.");
        }

        if (form.getMessage().equals("")) {
            errors.rejectValue("message", "invalid", "Introduce the content of your message");
        }
    }
}
