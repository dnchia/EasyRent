package es.uji.daal.easyrent.utils;

import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;

import java.util.ArrayList;

/**
 * Created by Alberto on 10/05/2016.
 */
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private UserRepository userRepository;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        String password = (String) authentication.getCredentials();

        if (!userRepository.existsByUsername(username)) {
            throw new BadCredentialsException("wrong-username");
        }

        if (!userRepository.authenticate(username, password)) {
            throw new BadCredentialsException("wrong-password");
        }

        User user = userRepository.findByUsernameIgnoreCase(username);

        if (!user.isActive() && user.getDeactivatedSince() == null) {
            throw new BadCredentialsException("unconfirmed-account");
        }

        if (!user.isActive() && user.getDeactivatedSince() != null) {
            throw new BadCredentialsException("banned-account");
        }

        ArrayList<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new GrantedAuthorityImpl(user.getRole().toString()));

        return new UsernamePasswordAuthenticationToken(user, password, authorities);
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }

    private class GrantedAuthorityImpl implements GrantedAuthority {

        private String role;

        public GrantedAuthorityImpl(String role) {
            this.role = role;
        }

        @Override
        public String getAuthority() {
            return role;
        }
    }
}
