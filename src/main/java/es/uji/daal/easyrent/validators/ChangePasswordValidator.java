package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.view_models.ChangePasswordForm;
import es.uji.daal.easyrent.view_models.SignupForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by daniel on 30/04/16.
 */
public class ChangePasswordValidator implements Validator {
    @Override
    public boolean supports(Class<?> cls) {
        return ChangePasswordForm.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        ChangePasswordForm form = (ChangePasswordForm) obj;

        if (form.getOldPassword().equals("")) {
            errors.rejectValue("oldPassword", "invalid", "You must introduce your old password.");
        }

        if (form.getNewPassword().equals("")) {
            errors.rejectValue("newPassword", "invalid", "You must introduce a password.");
        }

        if (form.getRepeatPassword().equals("")) {
            errors.rejectValue("repeatPassword", "invalid", "You must introduce a password.");
        }

        if (!form.getNewPassword().equals(form.getRepeatPassword())) {
            errors.rejectValue("newPassword", "invalid", "Passwords don't match.");
            errors.rejectValue("repeatPassword", "invalid", "Passwords don't match.");
        }
    }
}
