package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.model.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by daniel on 11/05/16.
 */
public class ServiceValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return Service.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        Service service = (Service)o;

        if (service.getName().equals(""))
            errors.rejectValue("name", "required", "It's necessary to introduce a name.");

        //TODO: Introducir gestión de valores
        if (service.getValue().equals(""))
            errors.rejectValue("value", "required", "It's necessary to introduce a value.");
    }
}
