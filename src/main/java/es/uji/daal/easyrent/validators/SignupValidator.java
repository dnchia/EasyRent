package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.view_models.SignupForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by daniel on 30/04/16.
 */
public class SignupValidator implements Validator {
    @Override
    public boolean supports(Class<?> cls) {
        return SignupForm.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        SignupForm form = (SignupForm)obj;

        if (form.getUsername().equals("")) {
            errors.rejectValue("username", "invalid", "You must introduce an username.");
        }

        if (form.getPassword().equals("")) {
            errors.rejectValue("password", "invalid", "You must introduce a password.");
        }

        if (form.getRepeatPassword().equals("")) {
            errors.rejectValue("repeatPassword", "invalid", "You must introduce a password.");
        }

        if (form.getEmail().equals("")) {
            errors.rejectValue("email", "invalid", "You must introduce an email.");
        }

        if (form.getRepeatEmail().equals("")) {
            errors.rejectValue("repeatEmail", "invalid", "You must introduce an email.");
        }

        if (!form.getPassword().equals(form.getRepeatPassword())) {
            errors.rejectValue("password", "invalid", "Passwords don't match.");
            errors.rejectValue("repeatPassword", "invalid", "Passwords don't match.");
        }

        if (!form.getEmail().equals(form.getRepeatEmail())) {
            errors.rejectValue("email", "invalid", "Emails don't match.");
            errors.rejectValue("repeatEmail", "invalid", "Email don't match.");
        }
    }
}
