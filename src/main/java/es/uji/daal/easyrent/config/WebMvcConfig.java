package es.uji.daal.easyrent.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.ResourceBundleViewResolver;

/**
 * Created by Alberto on 18/06/2016.
 */
@Configuration
public class WebMvcConfig {

    @Bean
    ResourceBundleViewResolver resourceBundleViewResolver() {
        ResourceBundleViewResolver resolver = new ResourceBundleViewResolver();
        resolver.setOrder(0);
        resolver.setBasename("views");
        return resolver;
    }
}
