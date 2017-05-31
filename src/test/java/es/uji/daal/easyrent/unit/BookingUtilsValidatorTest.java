package es.uji.daal.easyrent.unit;

import es.uji.daal.easyrent.model.AvailabilityPeriod;
import es.uji.daal.easyrent.utils.BookingUtils;
import es.uji.daal.easyrent.utils.DateUtils;
import es.uji.daal.easyrent.view_models.BookingForm;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.assertEquals;

/**
 * Created by Alberto on 15/06/2016.
 */
@RunWith(Parameterized.class)
public class BookingUtilsValidatorTest {

    private final Date startDate;
    private final Date endDate;
    private final boolean expected;
    private final String error;

    public BookingUtilsValidatorTest(Date startDate, Date endDate, boolean expected, String error) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.expected = expected;
        this.error = error;
    }

    @Parameters
    public static Collection<Object[]> datos() {
        return Arrays.asList(new Object[][] {
                {createDate(20, 6, 2016), createDate(20, 6, 2016), true, "Should be able to pick one day from one one-day period"},
                {createDate(15, 6, 2016), createDate(18, 6, 2016), true, "Should be able to pick a whole period"},
                {createDate(30, 6, 2016), createDate(3, 7, 2016), true, "Should be able to pick days from and endless period"},
                {createDate(22, 6, 2016), createDate(25, 6, 2016), true, "Should be able to pick days among multiple period"},
                {createDate(15, 6, 2016), createDate(20, 6, 2016), false, "Should not be able to pick days between finite periods"},
                {createDate(26, 6, 2016), createDate(29, 6, 2016), false, "Should not be able to pick days between non finite periods"},
        });
    }

    static List getAvailabilityPeriods() {
        AvailabilityPeriod availabilityPeriod1 = new AvailabilityPeriod(null);
        availabilityPeriod1.setStartDate(createDate(15, 6, 2016));
        availabilityPeriod1.setEndDate(createDate(18, 6, 2016));

        AvailabilityPeriod availabilityPeriod2 = new AvailabilityPeriod(null);
        availabilityPeriod2.setStartDate(createDate(20, 6, 2016));
        availabilityPeriod2.setEndDate(createDate(20, 6, 2016));

        AvailabilityPeriod availabilityPeriod3 = new AvailabilityPeriod(null);
        availabilityPeriod3.setStartDate(createDate(22, 6, 2016));
        availabilityPeriod3.setEndDate(createDate(22, 6, 2016));

        AvailabilityPeriod availabilityPeriod4 = new AvailabilityPeriod(null);
        availabilityPeriod4.setStartDate(createDate(23, 6, 2016));
        availabilityPeriod4.setEndDate(createDate(24, 6, 2016));

        AvailabilityPeriod availabilityPeriod5 = new AvailabilityPeriod(null);
        availabilityPeriod5.setStartDate(createDate(25, 6, 2016));
        availabilityPeriod5.setEndDate(createDate(25, 6, 2016));

        AvailabilityPeriod availabilityPeriod6 = new AvailabilityPeriod(null);
        availabilityPeriod6.setStartDate(createDate(29, 6, 2016));
        availabilityPeriod6.setEndDate(null);

        AvailabilityPeriod[] periods = {
                availabilityPeriod1,
                availabilityPeriod2,
                availabilityPeriod3,
                availabilityPeriod4,
                availabilityPeriod5,
                availabilityPeriod6
        };
        return Arrays.asList(periods);
    }

    private static Date createDate(int day, int month, int year) {
        return DateUtils.createDate(day, month, year);
    }

    @Test
    public void isDatePeriodAvailable() throws Exception {
        BookingForm form = new BookingForm();
        form.setStartDate(startDate);
        form.setEndDate(endDate);

        assertEquals(error, expected, BookingUtils.isDatePeriodAvailable(form, getAvailabilityPeriods()));
    }

}