package es.uji.daal.easyrent.utils;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * Created by Alberto on 17/05/2016.
 */
public class DateUtils {
    public static int daysBetweenDates(Date date1, Date date2) {
        return (int) (date2.getTime()-date1.getTime()) / (1000*60*60*24);
    }

    public static Date createDate(int day, int month, int year) {
        return toDate(LocalDate.of(year, month, day));
    }

    public static Date getDatePlusDays(Date date, int days) {
        return toDate(toLocalDate(date).plusDays(days));
    }

    public static Date getDateMinusDays(Date date, int days) {
        return toDate(toLocalDate(date).minusDays(days));
    }

    private static Date toDate(LocalDate date) {
        return java.sql.Date.valueOf(date);
    }

    private static LocalDate toLocalDate(Date date) {
        Instant instant = Instant.ofEpochMilli(date.getTime());
        return LocalDateTime.ofInstant(instant, ZoneId.systemDefault()).toLocalDate();
    }
}
