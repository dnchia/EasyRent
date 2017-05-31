package es.uji.daal.easyrent.unit;

import es.uji.daal.easyrent.model.GeographicLocation;
import es.uji.daal.easyrent.utils.AddressGeocoder;
import es.uji.daal.easyrent.utils.GoogleAddressGeocoder;
import org.junit.*;

import java.math.BigDecimal;

import static org.junit.Assert.*;

/**
 * Created by Alberto on 26/06/2016.
 */
public class GoogleAddressGeocoderTest {

    private static AddressGeocoder geocoder;

    @BeforeClass
    public static void setUp() throws Exception {
        geocoder = new GoogleAddressGeocoder().setApiKey("AIzaSyBgdY3HUkzl_P9ggErdG89QJmh0tDZUcPs");
    }

    @AfterClass
    public static void tearDown() throws Exception {
        geocoder = null;
    }

    @Test
    public void geocode() throws Exception {
        String address = "Calle Cristóbal Maurat Marco, Castellón de la Plana, España";
        GeographicLocation location = geocoder.geocode(address);
        assertEquals(location.getLatitude(), BigDecimal.valueOf(39.9980209));
        assertEquals(location.getLongitude(), BigDecimal.valueOf(-0.0342087));
        assertEquals(location.getFullAddress(), address);
    }

}