package es.uji.daal.easyrent.integration;

import es.uji.daal.easyrent.Application;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.model.UserRole;
import es.uji.daal.easyrent.repository.UserRepository;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Date;
import java.util.List;
import java.util.UUID;

import static org.junit.Assert.*;

/**
 * Created by alberto on 21/03/16.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
public class UserDAOTest {

    @Autowired
    private UserRepository repository;

    @Test
    public void testFindAllRecords() throws Exception {
        final List<User> users = (List<User>) repository.findAll();
        assertFalse(users.isEmpty());
    }

    @Test
    public void testFullStorageCycle() throws Exception {
        // Test case
        User user = new User();
        user.setUsername("testuser");
        user.setPassword("XXXXXXXXX");
        user.setEmail("testuser@example.com");

        // Store user
        user = repository.save(user);
        final UUID userID = user.getId();
        assertNotNull(userID);

        // Find user
        final User dbUser = repository.findOne(userID);
        assertEquals(user.getUsername(), dbUser.getUsername());

        // Update user
        final String newAddress = "Fake street, 456";
        user.setPostalAddress(newAddress);
        repository.save(user);
        assertEquals(user.getPostalAddress(), newAddress);

        // Destroy user
        repository.delete(user);
        boolean exists = repository.exists(userID);
        assertFalse(exists);
    }

    @After
    public void tearDown() throws Exception {
        repository = null;
    }
}