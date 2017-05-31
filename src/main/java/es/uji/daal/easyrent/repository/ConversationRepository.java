package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.Conversation;
import es.uji.daal.easyrent.model.Token;
import es.uji.daal.easyrent.model.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Set;
import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface ConversationRepository extends CrudRepository<Conversation, UUID> {

    @Query("select c from Conversation c where c.tenant = :user or c.property.owner = :user order by c.updateDate desc ")
    Set<Conversation> findForUser(@Param("user") User user);
}
