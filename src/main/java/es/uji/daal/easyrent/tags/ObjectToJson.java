package es.uji.daal.easyrent.tags;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 * Created by Alberto on 07/06/2016.
 */
public class ObjectToJson extends SimpleTagSupport {

    private Object object;
    private String var;

    public void setObject(Object object) {
        this.object = object;
    }

    public void setVar(String var) {
        this.var = var;
    }

    @Override
    public void doTag() throws JspException, IOException {
        ObjectMapper om = new ObjectMapper();
        if (var != null) {
            getJspContext().setAttribute(var, om.writeValueAsString(object));
        } else {
            getJspContext().getOut().write(om.writeValueAsString(object));
        }
    }
}
