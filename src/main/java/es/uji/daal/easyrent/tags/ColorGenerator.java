package es.uji.daal.easyrent.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 * Created by Alberto on 12/06/2016.
 */
public class ColorGenerator extends SimpleTagSupport {
    private long number;
    private String var;

    public void setNumber(long number) {
        this.number = number;
    }

    public void setVar(String var) {
        this.var = var;
    }

    @Override
    public void doTag() throws JspException, IOException {
        String[] colors = {"primary", "success", "info", "warning", "danger"};
        String color = colors[(int) (number % colors.length)];
        if (var != null) {
            getJspContext().setAttribute(var, color);
        } else {
            getJspContext().getOut().write(color);
        }
    }
}
