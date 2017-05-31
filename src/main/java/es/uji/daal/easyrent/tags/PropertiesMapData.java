package es.uji.daal.easyrent.tags;

import com.fasterxml.jackson.databind.ObjectMapper;
import es.uji.daal.easyrent.model.GeographicLocation;
import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.view_models.AvailabilityForm;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Alberto on 07/06/2016.
 */
public class PropertiesMapData extends SimpleTagSupport {

    private List<Map> properties;
    private String var;

    public void setProperties(Iterable<Property> properties) {
        List<Map> mapData = new LinkedList<>();
        for (Property property: properties) {
            Map<String, Object> propertyData = new HashMap<>();
            propertyData.put("id", property.getId());
            propertyData.put("title", property.getTitle());
            GeographicLocation geographicLocation = property.getGeographicLocation();
            propertyData.put("address", geographicLocation.getFullAddress());
            propertyData.put("latitude", geographicLocation.getLatitude());
            propertyData.put("longitude", geographicLocation.getLongitude());
            mapData.add(propertyData);
        }
        this.properties = mapData;
    }

    public void setVar(String var) {
        this.var = var;
    }

    @Override
    public void doTag() throws JspException, IOException {
        ObjectMapper om = new ObjectMapper();
        if (var != null) {
            getJspContext().setAttribute(var, om.writeValueAsString(properties));
        } else {
            getJspContext().getOut().write(om.writeValueAsString(properties));
        }
    }
}
