package es.uji.daal.easyrent.model;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by daniel on 27/02/16.
 */

@Entity
@Table(name = "booking_proposals")
public class BookingProposal extends DomainModel {

    @ManyToOne(optional = false)
    private Property property;

    @ManyToOne(optional = false)
    private User tenant;

    @Column(nullable = false)
    private Date startDate;

    @Column(nullable = false)
    private Date endDate;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private ProposalStatus status;

    private String paymentReference;

    @Column(nullable = false)
    private float totalAmount;

    @Column(nullable = false)
    private int numberOfTenants;

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateOfCreation;

    private Date dateOfUpdate;

    @OneToOne(mappedBy = "proposal", cascade = CascadeType.ALL)
    private Invoice invoice;

    /**
     * ======
     * Methods
     * ======
     */

    protected BookingProposal() {
    }

    public BookingProposal(Property property, User tenant) {
        this.property = property;
        this.tenant = tenant;
        status = ProposalStatus.PENDING;
        dateOfCreation = new Date();
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public ProposalStatus getStatus() {
        return status;
    }

    public void setStatus(ProposalStatus status) {
        this.status = status;
    }

    public String getPaymentReference() {
        return paymentReference;
    }

    public void setPaymentReference(String paymentReference) {
        this.paymentReference = paymentReference;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getNumberOfTenants() {
        return numberOfTenants;
    }

    public void setNumberOfTenants(int numberOfTenants) {
        this.numberOfTenants = numberOfTenants;
    }

    public Date getDateOfCreation() {
        return dateOfCreation;
    }

    public void setDateOfCreation(Date dateOfCreation) {
        this.dateOfCreation = dateOfCreation;
    }

    public Date getDateOfUpdate() {
        return dateOfUpdate;
    }

    public void setDateOfUpdate(Date dateOfUpdate) {
        this.dateOfUpdate = dateOfUpdate;
    }

    /**
     * ======
     * Extra
     * ======
     */

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public User getTenant() {
        return tenant;
    }

    public void setTenant(User tenant) {
        this.tenant = tenant;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public Invoice createInvoice() {
        Invoice invoice = new Invoice(this);
        this.invoice = invoice;
        return invoice;
    }

    public BookingProposal accept() {
        status = ProposalStatus.ACCEPTED;
        dateOfUpdate = new Date();
        return this;
    }

    public BookingProposal reject() {
        status = ProposalStatus.REJECTED;
        dateOfUpdate = new Date();
        return this;
    }
}