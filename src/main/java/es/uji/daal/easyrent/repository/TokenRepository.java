package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.Token;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface TokenRepository extends CrudRepository<Token, UUID> {

}
