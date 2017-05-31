package es.uji.daal.easyrent.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 * Created by Alberto on 07/06/2016.
 */
public class TimeConfig extends SimpleTagSupport {

    public static final String MOMENT_FORMAT = "DD/MM/YYYY";
    public static final String DATEPICKER_FORMAT = MOMENT_FORMAT.toLowerCase();

    private String type;
    private String var;

    public void setType(String type) {
        this.type = type;
    }

    public void setVar(String var) {
        this.var = var;
    }

    @Override
    public void doTag() throws JspException, IOException {
        TimeAgent timeAgent = TimeAgent.valueOf(type.toUpperCase());
        if (var != null) {
            getJspContext().setAttribute(var, timeAgent.getFormat());
        } else {
            getJspContext().getOut().write(timeAgent.getFormat());
        }
    }

    private enum TimeAgent {
        MOMENT(MOMENT_FORMAT),
        DATEPICKER(DATEPICKER_FORMAT);

        private String format;

        TimeAgent(String format) {
            this.format = format;
        }

        public String getFormat() {
            return format;
        }
    }
}
