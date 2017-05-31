package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.User;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by Alberto on 07/05/2016.
 */
public interface UserRepository extends CrudRepository<User, UUID>, UserRepositoryCustom {

    User findByUsernameIgnoreCase(String username);

    @Query("select count(e)>0 from User e where lower(e.email) = lower(:email)")
    boolean existsByEmail(@Param("email") String email);

    @Query("select count(e)>0 from User e where lower(e.username) = lower(:username)")
    boolean existsByUsername(@Param("username") String username);

    @Query("select count(e)>0 from User e where lower(e.Dni) = lower(:dni)")
    boolean existsByDni(@Param("dni") String dni);

    @Query("select e from User e where lower(e.username) like lower( concat('%', :username, '%') )")
    List<User> findByUsernameContainedInSearchedName(@Param("username") String username);

    @Query("select e from User e where lower(e.Dni) like lower( concat('%', :Dni, '%') )")
    List<User> findByNIDContainedInSearchedNID(@Param("Dni") String Dni);

    @Query("select e from User e where lower(e.role) like lower( concat('%', :role, '%') ) ")
    List<User> findByRoleContainedInSearchedRole(@Param("role") String role);

    @Query("select e from User e where lower(e.name) like lower( concat('%', :name, '%') )")
    List<User> findByNameContainedInSearchedName(@Param("name") String name);

    @Query("select e from User e where lower(e.surnames) like lower( concat('%', :surnames, '%') )")
    List<User> findBySurnamesContainedInSearchedSurnames(@Param("surnames") String surnames);

    @Query("select e from User e where lower(e.email) like lower(concat('%', :email, '%') ) ")
    List<User> findByEmailContainedInSearchedEmails(@Param("email") String email);

    //TODO: Test
    @Query("select e from User e where e.phoneNumber = :phoneNumber")
    List<User> findByPhone(@Param("phoneNumber") int phoneNumber);

    @Query("select e from User e where lower(e.postalAddress) like lower(concat('%', :address, '%') ) ")
    List<User> findByAddressContainedInSearchedAddress(@Param("address") String address);

    @Query("select e from User e where lower(e.country) like lower(concat('%', :country, '%') ) ")
    List<User> findByCountryContainedInSearchedCountry(@Param("country") String country);

    //TODO: Test
    @Query("select e from User e where e.postCode = :postCode")
    List<User> findByPostCode(@Param("postCode") int postCode);

    List<User> findBySignUpDateBetween(Date signUpDateInitial, Date signUpDateFinal);

    //TODO: Test
    @Query("select e from User e where e.active = :active")
    List<User> findByActiveAccount(@Param("active") boolean active);

    List<User> findByDeactivatedSinceBetween(Date deactivatedSinceInitial, Date deactivatedSinceFinal);
}
