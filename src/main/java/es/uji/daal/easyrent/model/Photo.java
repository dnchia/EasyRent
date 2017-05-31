package es.uji.daal.easyrent.model;

import javax.persistence.*;
import java.util.Date;
import java.util.UUID;

/**
 * Created by alberto on 17/03/16.
 */

@Entity
@Table(name = "photos")
public class Photo extends DomainModel {

    @ManyToOne
    private Property property;

    @OneToOne
    private User user;

    @Column(nullable = false)
    private String filename;

    @Column(nullable = false)
    private Date uploadDate;

    /**
     * ======
     * Methods
     * ======
     */

    protected Photo() {
    }

    public Photo(User user, String filename) {
        this.user = user;
        user.setPhoto(this);
        this.filename = filename;
        uploadDate = new Date();
    }

    public Photo(Property property, String filename) {
        this.property = property;
        this.filename = filename;
        uploadDate = new Date(new java.util.Date().getTime());
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
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
        if (user != null && property != null) {
            throw new IllegalStateException("A photo can only belong to a property or a user at once");
        }
        this.property = property;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        if (property != null && user != null) {
            throw new IllegalStateException("A photo can only belong to a property or a user at once");
        }
        this.user = user;
    }

    @PreRemove
    void preRemove() {
        setUser(null);
        setProperty(null);
    }
}
