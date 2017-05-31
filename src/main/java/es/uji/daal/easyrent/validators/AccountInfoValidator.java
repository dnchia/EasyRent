package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.view_models.AccountInfoForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by Alberto on 12/05/2016.
 */
public class AccountInfoValidator implements Validator {
    @Override
    public boolean supports(Class<?> cls) {
        return AccountInfoForm.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        AccountInfoForm user = (AccountInfoForm) obj;

        if (user.getUsername().equals("")) {
            errors.rejectValue("username", "invalid", "You must introduce an username.");
        }

        if (user.getEmail().equals("")) {
            errors.rejectValue("email", "invalid", "You must introduce an email.");
        }
    }
}
