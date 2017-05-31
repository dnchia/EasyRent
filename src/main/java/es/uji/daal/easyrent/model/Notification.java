package es.uji.daal.easyrent.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;
import java.util.UUID;

/**
 * Created by Alberto on 29/06/2016.
 */
@Entity
@Table(name = "notifications")
public class Notification extends DomainModel {

    @ManyToOne
    private User user;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private NotificationType type;

    @Column(nullable = false)
    @Type(type = "pg-uuid")
    private UUID targetId;

    @Column(nullable = false)
    private Date creationDate;

    private String thumbnail;
    private String source;
    private String destination;

    /**
     * ======
     * Methods
     * ======
     */

    protected Notification() {
    }

    public Notification(User user, NotificationType type) {
        this.user = user;
        this.type = type;
        creationDate = new Date();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public NotificationType getType() {
        return type;
    }

    public void setType(NotificationType type) {
        this.type = type;
    }

    public UUID getTargetId() {
        return targetId;
    }

    public void setTargetId(UUID relatedId) {
        this.targetId = relatedId;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumnail) {
        this.thumbnail = thumnail;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }
}