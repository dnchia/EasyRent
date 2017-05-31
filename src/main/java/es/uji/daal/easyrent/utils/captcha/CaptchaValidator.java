package es.uji.daal.easyrent.utils.captcha;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Alberto on 04/07/2016.
 */
public interface CaptchaValidator {
    boolean validateCaptcha(String captcha, HttpServletRequest request) throws IOException;
}
