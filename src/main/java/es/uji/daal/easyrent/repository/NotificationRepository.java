package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.Notification;
import es.uji.daal.easyrent.model.Token;
import es.uji.daal.easyrent.model.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface NotificationRepository extends CrudRepository<Notification, UUID> {

    @Modifying
    @Transactional
    int deleteByUser(User user);
}
