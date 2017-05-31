package es.uji.daal.easyrent.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import java.util.UUID;

/**
 * Created by Alberto on 18/03/2016.
 */
@MappedSuperclass
public abstract class DomainModel {
    @Id
    @GenericGenerator(name = "uuid-gen", strategy = "uuid2")
    @GeneratedValue(generator = "uuid-gen")
    @Type(type = "pg-uuid")
    private UUID id = null;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (isNew() || isNull(obj)|| !equalsClass(obj)) {
            return false;
        }

        return this.id.equals(((DomainModel) obj).id);
    }

    @Override
    public int hashCode() {
        return isNew() ? 0 : id.hashCode();
    }

    /**
     * =============
     * FUNCTIONALITY
     * =============
     */


    private boolean isNew() {
        return isNull(id);
    }
    private boolean isNull(Object obj) {
        return obj == null;
    }
    private boolean equalsClass(Object obj) {
        return this.getClass().equals(obj.getClass());
    }
}
