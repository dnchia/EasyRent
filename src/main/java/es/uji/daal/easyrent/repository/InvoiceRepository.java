package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.Invoice;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface InvoiceRepository extends CrudRepository<Invoice, UUID> {
    List<Invoice> findByProposal_Tenant_IdOrderByExpeditionDateDesc(UUID tenant);

    @Query("select i from Invoice i where i.number = :number")
    List<Invoice> findByNumber(@Param("number") int number);

    @Query("select i from Invoice i where i.vat = :vat")
    List<Invoice> findByVAT(@Param("vat") float vat);

    @Query("select i from Invoice i where lower(i.address) like lower(concat('%', :address, '%') ) ")
    List<Invoice> findByAddressContainedInSearchedAddress(@Param("address") String address);

    List<Invoice> findByExpeditionDateBetween(Date expeditionDateInitial, Date expeditionDateFinal);

    @Query("select i from Invoice i where i.proposal.totalAmount = :totalAmount")
    List<Invoice> findByTotalAmount(@Param("totalAmount") float totalAmount);
}
