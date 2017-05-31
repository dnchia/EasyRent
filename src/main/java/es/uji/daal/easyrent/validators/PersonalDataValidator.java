package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.view_models.PersonalDataForm;
import es.uji.daal.easyrent.view_models.SignupForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by daniel on 30/04/16.
 */
public class PersonalDataValidator implements Validator {
    @Override
    public boolean supports(Class<?> cls) {
        return PersonalDataForm.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        PersonalDataForm form = (PersonalDataForm) obj;

        if (form.getName().equals("")) {
            errors.rejectValue("name", "invalid", "Please, introduce your name.");
        }

        if (form.getSurnames().equals("")) {
            errors.rejectValue("surnames", "invalid", "Please, introduce your surname/s");
        }

        if (!form.getDni().matches("[0-9]{8}[A-Z]")) {
            errors.rejectValue("dni", "invalid", "Invalid NID. Format XXXXXXXXx. X are digits, x is an upper case letter");
        }

        if (form.getCountryPrefix().equals("") && !form.getPhoneNumber().equals("")) {
            errors.rejectValue("countryPrefix", "invalid", "You must introduce a country prefix.");
        }

        if (form.getPhoneNumber().equals("") && !form.getCountryPrefix().equals("")) {
            errors.rejectValue("phoneNumber", "invalid", "You must introduce a phoneNumber.");
        }

        if (!form.getCountryPrefix().equals("") && !form.getCountryPrefix().matches("\\+[0-9]{2}")) {
            errors.rejectValue("countryPrefix", "invalid", "The prefix must follow +XX format.");
        }

        if (!form.getPhoneNumber().equals("") && !form.getPhoneNumber().matches("[0-9]{9}")) {
            errors.rejectValue("phoneNumber", "invalid", "Invalid phone number.");
        }
    }
}
