package es.uji.daal.easyrent.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.search.annotations.ContainedIn;
import org.hibernate.search.annotations.Field;

import javax.persistence.*;
import java.util.Date;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

/**
 * Created by alberto on 17/03/16.
 */
@Entity
@Table(name = "services")
public class Service extends DomainModel {

    @Column(nullable = false)
    @Field
    private String name;

    @Column(nullable = false, unique = true)
    private String value;

    @JsonIgnore
    @ManyToOne
    private User user;

    @JsonIgnore
    @Column(nullable = false)
    private boolean active;

    @Column(nullable = false)
    private Date creationDate;

    @JsonIgnore
    private Date activeSince;

    @JsonIgnore
    private int serviceProposals;

    @JsonIgnore
    @ManyToMany(mappedBy = "services", cascade = CascadeType.ALL)
    @ContainedIn
    private List<Property> properties;

    /**
     * ======
     * Methods
     * ======
     */


    public Service(User user) {
        initService(user);
        active = true;
        activeSince = new Date();
    }

    public Service(User user, boolean active) {
        initService(user);
        this.active = active;
        if (active)
            this.activeSince = new Date();
    }

    private void initService(User user) {
        this.user = user;
        serviceProposals = 0;
        creationDate = new Date();
    }

    protected Service() {
    }

    public Service(Service service) {
        name = service.getName();
        value = service.getValue();
        setId(service.getId());
        user = service.getUser();
        active = service.getActive();
        creationDate = service.getCreationDate();
        activeSince = service.getActiveSince();
        serviceProposals = service.getServiceProposals();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getActiveSince() {
        return activeSince;
    }

    public void setActiveSince(Date activeSince) {
        this.activeSince = activeSince;
    }

    public int getServiceProposals() {
        return serviceProposals;
    }

    public void setServiceProposals(int serviceProposals) {
        this.serviceProposals = serviceProposals;
    }

    /**
     * ======
     * Extra
     * ======
     */

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Service activate() {
        active = true;
        activeSince = new Date();
        return this;
    }

    public List<Property> getProperties() {
        return properties;
    }

    public void addProperty(Property property) {
        properties.add(property);
    }

    public void addProperties(Collection<Property> properties) {
        this.properties.addAll(properties);
    }

    public void removeProperty(Property property) {
        properties.remove(property);
    }

    public void removeProperties(Collection<Property> properties) {
        this.properties.removeAll(properties);
    }
}
