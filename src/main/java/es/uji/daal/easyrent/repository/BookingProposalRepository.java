package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.BookingProposal;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Temporal;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import javax.persistence.TemporalType;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface BookingProposalRepository extends CrudRepository<BookingProposal, UUID> {
    List<BookingProposal> findByTenant_Id(UUID tenantID);
    List<BookingProposal> findByProperty_Owner_IdOrderByDateOfCreationDesc(UUID owner);

    @Query("select bp from BookingProposal bp where (bp.startDate < current_date or bp.dateOfCreation <= :date) and lower(bp.status) = 'pending'")
    List<BookingProposal> findInfeasibleProposalsFrom(@Param("date") Date date);

    @Query("select b from BookingProposal b where lower(b.property.title) like lower(concat('%', :title, '%') ) ")
    List<BookingProposal> findByPropertyTitleContainedInSearchedPropertyTitle(@Param("title") String title);

    @Query("select b from BookingProposal b where lower(b.tenant.username) like lower(concat('%', :username, '%') ) ")
    List<BookingProposal> findByTenantUsernameContainedInSearchedTenantUsername(@Param("username") String username);

    List<BookingProposal> findByStartDateBetween(Date initialStartDate, Date finalStartDate);

    List<BookingProposal> findByEndDateBetween(Date initialEndDate, Date finalEndDate);

    @Query("select b from BookingProposal b where lower(b.status) like lower(:status) ")
    List<BookingProposal> findByStatus(@Param("status") String status);

    @Query("select b from BookingProposal b where lower(b.paymentReference) like lower(concat('%', :paymentReference, '%') ) ")
    List<BookingProposal> findByPaymentReferenceContainedInSearchedPaymentReference(@Param("paymentReference") String paymentReference);

    @Query("select b from BookingProposal b where b.totalAmount = :totalAmount")
    List<BookingProposal> findByTotalAmount(@Param("totalAmount") float totalAmount);

    @Query("select b from BookingProposal b where b.numberOfTenants = :numberOfTenants")
    List<BookingProposal> findByNumberOfTenants(@Param("numberOfTenants") int numberOfTenants);

    List<BookingProposal> findByDateOfCreationBetween(Date initialDateOfCreation, Date finalDateOfCreation);

    List<BookingProposal> findByDateOfUpdateBetween(Date initialDateOfUpdate, Date finalDateOfUpdate);

    @Query("select b from BookingProposal b where b.invoice.number = :number")
    List<BookingProposal> findByInvoiceNumber(@Param("number") int number);
}
