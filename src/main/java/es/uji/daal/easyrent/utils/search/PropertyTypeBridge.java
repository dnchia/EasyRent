package es.uji.daal.easyrent.utils.search;

import es.uji.daal.easyrent.model.PropertyType;
import org.hibernate.search.bridge.StringBridge;

/**
 * Created by Alberto on 02/07/2016.
 */
public class PropertyTypeBridge implements StringBridge {
    @Override
    public String objectToString(Object o) {
        PropertyType type = (PropertyType) o;
        return type.getLabel();
    }
}
