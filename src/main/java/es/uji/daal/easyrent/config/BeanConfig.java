package es.uji.daal.easyrent.config;

import es.uji.daal.easyrent.utils.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;

/**
 * Created by Alberto on 08/05/2016.
 */

@Configuration
public class BeanConfig {

    @Bean
    public PasswordEncryptor passwordEncryptor() {
        return new BCryptPasswordEncryptor();
    }

    @Bean
    FileUploader fileUploader() {
        return new FileUploaderFS();
    }

    @Bean
    FileLoader fileLoader() {
        return new FileLoaderFS();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        return new CustomAuthenticationProvider();
    }
}
