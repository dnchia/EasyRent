package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.Service;
import javafx.scene.control.Pagination;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface ServiceRepository extends CrudRepository<Service, UUID> {

    @Modifying
    @Transactional
    @Query("update Service s set s.serviceProposals = coalesce(s.serviceProposals, 0)+1 where s.id = :service")
    void incrementServiceProposalsByOne(@Param("service") UUID service);

    Service findByValue(String value);

    @Query("select s from Service s where lower(s.name) like lower(concat('%', :name, '%') ) ")
    List<Service> searchByNameContainedInSearchedName(@Param("name") String name);

    @Query("select s from Service s where lower(s.user.username) like lower(concat('%', :username, '%') ) ")
    List<Service> searchByUserContainedInSearchedUser(@Param("username") String username);

    List<Service> findByCreationDateBetween(Date creationDateInitial, Date creationDateFinal);

    @Query("select s from Service s where s.active = :active")
    List<Service> findActive(@Param("active") boolean active);

    List<Service> findByActiveSinceBetween(Date activeSinceInitial, Date activeSinceFinal);

    @Query("select s from Service s where s.serviceProposals = :serviceProposals")
    List<Service> findByServiceProposals(@Param("serviceProposals") int serviceProposals);

    @Query("select s from Service s where s.active = false order by s.serviceProposals desc")
    List<Service> findTop5MostDemandedServices(Pageable pagination);

    @Query("select count(s) from Service s where s.active = false")
    int findNumberOfServicesNotActive();
}
