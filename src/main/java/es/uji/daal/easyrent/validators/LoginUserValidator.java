package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.model.User;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by daniel on 30/04/16.
 */
public class LoginUserValidator implements Validator {
    @Override
    public boolean supports(Class<?> cls) {
        return User.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        User user = (User)obj;

        if (user.getUsername().equals("")) {
            errors.rejectValue("username", "invalid", "You must introduce an username.");
        }

        if (user.getPassword().equals("")) {
            errors.rejectValue("password", "invalid", "You must introduce a password.");
        }
    }
}
