package es.uji.daal.easyrent.utils.captcha;

import es.uji.daal.easyrent.utils.network.RequestTools;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Alberto on 04/07/2016.
 */
@Component
public class ReCaptchaValidator implements CaptchaValidator{
    private static final String URL = "https://www.google.com/recaptcha/api/siteverify";
    private String SECRET;

    @Value("${easyrent.recaptcha.secret}")
    public void setSecret(String secret) {
        this.SECRET = secret;
    }

    @Override
    public boolean validateCaptcha(String captcha, HttpServletRequest request) throws IOException {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("secret", SECRET);
        params.add("response", captcha);
        params.add("remoteip", RequestTools.getClientIpAddress(request));

        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(URL);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(builder.build().encode().toUriString(), params, String.class);

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(response.getBody());
        return root.get("success").asBoolean();
    }
}
