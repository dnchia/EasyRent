package es.uji.daal.easyrent.tags;

import com.fasterxml.jackson.databind.ObjectMapper;
import es.uji.daal.easyrent.model.AvailabilityPeriod;
import es.uji.daal.easyrent.view_models.AvailabilityForm;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

/**
 * Created by Alberto on 07/06/2016.
 */
public class AvailabilitiesToJson extends SimpleTagSupport {

    private List<AvailabilityForm> periods;
    private String var;

    public void setPeriods(Iterable<AvailabilityPeriod> periods) {
        List<AvailabilityForm> p = new LinkedList<>();
        for (AvailabilityPeriod period : periods) {
            p.add(new AvailabilityForm().fillUp(period));
        }
        this.periods = p;
    }

    public void setVar(String var) {
        this.var = var;
    }

    @Override
    public void doTag() throws JspException, IOException {
        ObjectMapper om = new ObjectMapper();
        if (var != null) {
            getJspContext().setAttribute(var, om.writeValueAsString(periods));
        } else {
            getJspContext().getOut().write(om.writeValueAsString(periods));
        }
    }
}
