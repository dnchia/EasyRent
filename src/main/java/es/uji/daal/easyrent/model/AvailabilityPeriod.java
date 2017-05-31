package es.uji.daal.easyrent.model;

import es.uji.daal.easyrent.utils.search.NullableDateBridge;
import org.hibernate.search.annotations.*;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by alberto on 17/03/16.
 */
@Entity
@Table(name = "availability_periods")
public class AvailabilityPeriod extends DomainModel {

    @ManyToOne(optional = false)
    @ContainedIn
    private Property property;

    @Column(nullable = false)
    @Field
    @DateBridge(resolution = Resolution.DAY)
    private Date startDate;

    @Field
    @FieldBridge(impl = NullableDateBridge.class)
    private Date endDate;

    /**
     * ======
     * Methods
     * ======
     */

    protected AvailabilityPeriod() {
    }

    public AvailabilityPeriod(Property property) {
        this.property = property;
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
}
