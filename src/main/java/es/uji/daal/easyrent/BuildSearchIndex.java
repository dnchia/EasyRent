package es.uji.daal.easyrent;

import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.Search;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * Created by Alberto on 15/05/2016.
 */

@Component
public class BuildSearchIndex implements ApplicationListener<ContextRefreshedEvent> {

    @PersistenceContext
    EntityManager em;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        try {
            FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(em);
            fullTextEntityManager.createIndexer().startAndWait();
        } catch (InterruptedException e) {
            System.out.println("An error occurred trying to build the search index: " + e.toString());
        }
    }
}
