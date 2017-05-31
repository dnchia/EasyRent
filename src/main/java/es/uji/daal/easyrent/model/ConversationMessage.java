package es.uji.daal.easyrent.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by Alberto on 30/06/2016.
 */
@Entity
@Table(name = "conversation_messages")
public class ConversationMessage extends DomainModel {
    @ManyToOne(optional = false)
    private Conversation conversation;

    @ManyToOne(optional = false)
    private User user;

    @Column(nullable = false)
    private String message;

    @Column(nullable = false)
    private Date sendDate;

    protected ConversationMessage() {
    }

    public ConversationMessage(Conversation conversation, User user) {
        this.conversation = conversation;
        this.user = user;
        sendDate = new Date();
    }

    public Conversation getConversation() {
        return conversation;
    }

    public void setConversation(Conversation conversation) {
        this.conversation = conversation;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getSendDate() {
        return sendDate;
    }

    public void setSendDate(Date sendDate) {
        this.sendDate = sendDate;
    }
}
