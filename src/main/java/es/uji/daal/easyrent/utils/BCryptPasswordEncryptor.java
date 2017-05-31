package es.uji.daal.easyrent.utils;

import org.springframework.security.crypto.bcrypt.BCrypt;

/**
 * Created by Alberto on 08/05/2016.
 */
public class BCryptPasswordEncryptor implements PasswordEncryptor {

    @Override
    public String generateHash(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    @Override
    public boolean validatePassword(String plainPassword, String hashPassword) {
        return BCrypt.checkpw(plainPassword, hashPassword);
    }
}
