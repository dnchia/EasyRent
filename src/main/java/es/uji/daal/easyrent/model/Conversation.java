package es.uji.daal.easyrent.model;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alberto on 30/06/2016.
 */
@Entity
@Table(name = "conversations")
public class Conversation extends DomainModel {
    @ManyToOne(optional = false)
    private Property property;

    @ManyToOne(optional = false)
    private User tenant;

    @Column(nullable = false)
    private Date creationDate;

    @Column(nullable = false)
    private Date updateDate;

    @OneToMany(mappedBy = "conversation", cascade = CascadeType.ALL)
    @OrderBy("sendDate asc")
    private Set<ConversationMessage> messages;

    protected Conversation() {
    }

    public Conversation(Property property, User tenant) {
        this.property = property;
        this.tenant = tenant;
        creationDate = new Date();
        updateDate = new Date();
    }

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

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Set<ConversationMessage> getMessages() {
        return messages;
    }

    public void setMessages(Set<ConversationMessage> messages) {
        this.messages = messages;
    }

    public ConversationMessage createMessage(User user) {
        updateDate = new Date();
        ConversationMessage message = new ConversationMessage(this, user);
        if (getMessages() == null) {
            setMessages(new HashSet<>());
        }
        getMessages().add(message);
        return message;
    }
}
