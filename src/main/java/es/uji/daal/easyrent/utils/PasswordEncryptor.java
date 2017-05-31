package es.uji.daal.easyrent.utils;

/**
 * Created by Alberto on 08/05/2016.
 */
public interface PasswordEncryptor {

    public String generateHash(String plainPassword);

    public boolean validatePassword(String plainPassword, String hashPassword);
}
