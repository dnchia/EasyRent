package es.uji.daal.easyrent.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * Created by alberto on 17/03/16.
 */
@Entity
@Table(name = "tokens")
public class Token extends DomainModel {

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private TokenType type;

    @ManyToOne
    private User user;

    @Column(nullable = false)
    private Date creationDate;

    /**
     * ======
     * Methods
     * ======
     */


    public Token(User user) {
        this.user = user;
        creationDate = new Date();
    }

    protected Token() {
    }

    public TokenType getType() {
        return type;
    }

    public void setType(TokenType type) {
        this.type = type;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    /**
     * ======
     * Extra
     * ======
     */
}
