package es.uji.daal.easyrent.utils.search;

import org.hibernate.search.annotations.Resolution;
import org.hibernate.search.bridge.builtin.DateBridge;

import java.util.Date;

/**
 * Created by Alberto on 02/07/2016.
 */
public class NullableDateBridge extends DateBridge {

    private static final Date INFINITY = new Date(Long.MAX_VALUE);

    public NullableDateBridge() {
        super(Resolution.DAY);
    }

    @Override
    public String objectToString(Object object) {
        if (object != null) {
            return super.objectToString(object);
        } else {
            return super.objectToString(INFINITY);
        }
    }

    @Override
    public Object stringToObject(String stringValue) {
        Object date = super.stringToObject(stringValue);
        if (INFINITY.equals(date)) {
            return null;
        }
        return date;
    }
}
