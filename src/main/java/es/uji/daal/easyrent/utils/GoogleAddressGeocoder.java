package es.uji.daal.easyrent.utils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import es.uji.daal.easyrent.model.GeographicLocation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.math.BigDecimal;

/**
 * Created by Alberto on 26/06/2016.
 */
@Component
public class GoogleAddressGeocoder implements AddressGeocoder {
    private static final String URL = "https://maps.googleapis.com/maps/api/geocode/json";
    private String API_KEY;

    @Value("${easyrent.google.apikey}")
    public GoogleAddressGeocoder setApiKey(String apiKey) {
        this.API_KEY = apiKey;
        return this;
    }

    @Override
    public GeographicLocation geocode(String address) throws IOException {
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(URL)
                .queryParam("address", address)
                .queryParam("key", API_KEY);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(builder.build().encode().toUri(), String.class);

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(response.getBody());
        JsonNode location = root.get("results").get(0).get("geometry").get("location");

        GeographicLocation geographicLocation = new GeographicLocation();
        geographicLocation.setFullAddress(address);
        geographicLocation.setLatitude(BigDecimal.valueOf(location.get("lat").asDouble()));
        geographicLocation.setLongitude(BigDecimal.valueOf(location.get("lng").asDouble()));

        return geographicLocation;
    }
}
