package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.view_models.AddressInfoForm;
import es.uji.daal.easyrent.view_models.PersonalDataForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by daniel on 30/04/16.
 */
public class AddressInfoValidator implements Validator {
    @Override
    public boolean supports(Class<?> cls) {
        return AddressInfoForm.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        AddressInfoForm form = (AddressInfoForm) obj;

        if (form.getAddress().equals("")) {
            errors.rejectValue("address", "invalid", "Address needed.");
        }

        if (form.getCountry().equals("")) {
            errors.rejectValue("country", "invalid", "Country needed.");
        }

        if (form.getPostCode() == 0) {
            errors.rejectValue("postCode", "invalid", "Post code needed.");
        }
    }
}
