package es.uji.daal.easyrent.repository;

/**
 * Created by Alberto on 08/05/2016.
 */
public interface UserRepositoryCustom {

    boolean authenticate(String username, String password);
}
