package es.uji.daal.easyrent.tags;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 * Created by Alberto on 17/06/2016.
 */
@Component
public class InvoiceTools extends SimpleTagSupport {

    public static float VAT;

    @Value("${easyrent.invoices.vat}")
    public void setVat(String vat) {
        VAT = Float.parseFloat(vat);
    }

    private float value;
    private String var;

    public void setValue(float value) {
        this.value = value;
    }

    public void setVar(String var) {
        this.var = var;
    }

    @Override
    public void doTag() throws JspException, IOException {
        if (var != null) {
            getJspContext().setAttribute(var, value*(1.0f+VAT));
        } else {
            getJspContext().getOut().write(Float.toString(value*VAT));
        }
    }
}
