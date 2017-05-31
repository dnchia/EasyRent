package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.GeographicLocation;
import es.uji.daal.easyrent.model.Token;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface GeographicLocationRepository extends CrudRepository<GeographicLocation, UUID> {

    GeographicLocation findByFullAddress(String fullAddress);

}
