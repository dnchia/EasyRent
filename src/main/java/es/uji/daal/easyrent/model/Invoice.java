package es.uji.daal.easyrent.model;

import es.uji.daal.easyrent.tags.InvoiceTools;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by daniel on 27/02/16.
 */
@Entity
@Table(name = "invoices")
public class Invoice extends DomainModel {

    @Column(columnDefinition = "serial", unique = true, nullable = false, insertable = false, updatable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long number;

    @OneToOne(optional = false)
    private BookingProposal proposal;

    @Column(nullable = false)
    private float vat;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String country;

    @Column(nullable = false)
    private int postCode;

    @Column(nullable = false)
    private Date expeditionDate;

    /**
     * ======
     * Methods
     * ======
     */

    protected Invoice() {
    }

    public Invoice(BookingProposal proposal) {
        expeditionDate = new Date();
        this.proposal = proposal;
        vat = InvoiceTools.VAT;
    }

    public long getNumber() {
        return number;
    }

    public float getVat() {
        return vat;
    }

    public void setVat(float vat) {
        this.vat = vat;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getExpeditionDate() {
        return expeditionDate;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getPostCode() {
        return postCode;
    }

    public void setPostCode(int postCode) {
        this.postCode = postCode;
    }

    public void setExpeditionDate(Date expeditionDate) {
        this.expeditionDate = expeditionDate;
    }

    /**
     * ======
     * Extra
     * ======
     */

    public BookingProposal getProposal() {
        return proposal;
    }
}
