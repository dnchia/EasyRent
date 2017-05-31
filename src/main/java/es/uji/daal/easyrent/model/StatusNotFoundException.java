package es.uji.daal.easyrent.model;

/**
 * Created by Alberto on 17/03/2016.
 */
public class StatusNotFoundException extends Exception {
    public StatusNotFoundException(String serializedStatus) {
        super("No status was found for: " + serializedStatus);
    }
}