package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.model.AvailabilityPeriod;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by daniel on 23/04/16.
 */
public class AvailabilityPeriodValidator implements Validator {

    String introduceADateError = "It's necessary to introduce the date.";

    @Override
    public boolean supports(Class<?> aClass) {
        return AvailabilityPeriod.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        AvailabilityPeriod availabilityPeriod = (AvailabilityPeriod)o;

        //TODO: Revisar validez
        if (availabilityPeriod.getStartDate().toString().equals("")) {
            errors.rejectValue("startDate", "required", introduceADateError);
        }

        //TODO: Revisar validez
        if (availabilityPeriod.getEndDate().toString().equals("")) {
            errors.rejectValue("endDate", "required", introduceADateError);
        }

        if (availabilityPeriod.getStartDate().before(availabilityPeriod.getEndDate())) {
            errors.rejectValue("startDate", "required", "The end date must be later than the start date.");
        }
    }
}
