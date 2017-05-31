package es.uji.daal.easyrent.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Alberto on 11/05/2016.
 */
public class YearTag extends SimpleTagSupport {
    @Override
    public void doTag() throws JspException, IOException {
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY");
        Date date = new Date();
        String year = sdf.format(date);
        getJspContext().getOut().write(year);
    }
}
