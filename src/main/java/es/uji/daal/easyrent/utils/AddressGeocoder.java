package es.uji.daal.easyrent.utils;

import es.uji.daal.easyrent.model.GeographicLocation;

import java.io.IOException;

/**
 * Created by Alberto on 26/06/2016.
 */
public interface AddressGeocoder {
    GeographicLocation geocode(String address) throws IOException;
}
