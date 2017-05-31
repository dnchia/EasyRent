package es.uji.daal.easyrent.unit;

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

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.CoreMatchers.*;

/**
 * Created by Alberto on 15/06/2016.
 */
@RunWith(Parameterized.class)
public class BookingUtilsAffectedTest {

    private final Date startDate;
    private final Date endDate;
    private final int expected;

    public BookingUtilsAffectedTest(Date startDate, Date endDate, int expected) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.expected = expected;
    }

    @Parameters
    public static Collection<Object[]> datos() {
        return Arrays.asList(new Object[][] {
                {createDate(20, 6, 2016), createDate(20, 6, 2016), 1},
                {createDate(15, 6, 2016), createDate(18, 6, 2016), 1},
                {createDate(30, 6, 2016), createDate(3, 7, 2016), 1},
                {createDate(22, 6, 2016), createDate(25, 6, 2016), 3},
        });
    }

    private static List getAvailabilityPeriods() {
        return BookingUtilsValidatorTest.getAvailabilityPeriods();
    }

    private static Date createDate(int day, int month, int year) {
        return DateUtils.createDate(day, month, year);
    }

    @Test
    public void isDatePeriodAvailable() throws Exception {
        BookingForm form = new BookingForm();
        form.setStartDate(startDate);
        form.setEndDate(endDate);

        assertThat(BookingUtils.getAffectedPeriods(form, getAvailabilityPeriods()).size(), is(expected));
    }

}