package es.uji.daal.easyrent.validators;

import es.uji.daal.easyrent.model.AvailabilityPeriod;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.utils.BookingUtils;
import es.uji.daal.easyrent.view_models.BookingForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.Collection;

/**
 * Created by daniel on 30/04/16.
 */
public class BookingValidator implements Validator {

    private final Collection<AvailabilityPeriod> periods;
    private final boolean firstStage;

    public BookingValidator(Collection<AvailabilityPeriod> periods) {
        this.periods = periods;
        this.firstStage = true;
    }

    public BookingValidator(Collection<AvailabilityPeriod> periods, boolean firstStage) {
        this.periods = periods;
        this.firstStage = firstStage;
    }

    @Override
    public boolean supports(Class<?> cls) {
        return BookingForm.class.isAssignableFrom(cls);
    }
    @Override
    public void validate(Object obj, Errors errors) {
        BookingForm form = (BookingForm)obj;

        if (form.getStartDate() == null) {
            errors.rejectValue("startDate", "invalid", "Start date cannot be empty.");
        }

        if (form.getEndDate() == null) {
            errors.rejectValue("startDate", "invalid", "End date cannot be empty.");
        }

        if (form.getStartDate() != null && form.getEndDate() != null && !BookingUtils.isDatePeriodAvailable(form, periods)) {
            if (firstStage) {
                errors.rejectValue("startDate", "invalid", "The chosen period is not available.");
            } else {
                errors.rejectValue("startDate", "invalid", "The chosen period is no longer available. Apologies.");
            }
        }

        if (!firstStage && (form.getPaymentReference() == null || "".equals(form.getPaymentReference()))) {
            errors.rejectValue("startDate", "invalid", "You must pay first.");
        }
    }
}
