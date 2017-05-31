package es.uji.daal.easyrent.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

/**
 * Created by alberto on 17/03/16.
 */
@Entity
@Table(name = "geographic_locations")
public class GeographicLocation extends DomainModel {

    @OneToMany(mappedBy = "geographicLocation")
    private Set<Property> properties;

    @Column(nullable = false, precision = 14, scale = 10)
    private BigDecimal latitude;

    @Column(nullable = false, precision = 14, scale = 10)
    private BigDecimal longitude;

    @Column(nullable = false)
    private String  fullAddress;

    public GeographicLocation() {
    }

    /**
     * ======
     * Methods
     * ======
     */

    public Set<Property> getProperties() {
        return properties;
    }

    public void setProperties(Set<Property> properties) {
        this.properties = properties;
    }

    public BigDecimal getLatitude() {
        return latitude;
    }

    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }

    public BigDecimal getLongitude() {
        return longitude;
    }

    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }
}
