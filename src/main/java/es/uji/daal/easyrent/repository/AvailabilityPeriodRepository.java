package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.AvailabilityPeriod;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface AvailabilityPeriodRepository extends CrudRepository<AvailabilityPeriod, UUID> {

    @Modifying
    @Transactional
    @Query("delete from AvailabilityPeriod ap where ap.endDate < current_date")
    int removeOutdatedPeriods();
}
