package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.view_models.SearchParams;
import org.apache.lucene.document.DateTools;
import org.apache.lucene.search.Query;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.FullTextQuery;
import org.hibernate.search.jpa.Search;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * Created by Alberto on 15/05/2016.
 */
@Repository
public class PropertyRepositoryImpl implements PropertyRepositoryCustom {

    @PersistenceContext
    private EntityManager em;

    @Transactional(readOnly = true)
    @Override
    public Page<Property> searchBy(SearchParams params, Pageable pageable) {
        FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(em);

        QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory()
                .buildQueryBuilder().forEntity(Property.class).get();


        Query q = queryBuilder
                .bool()
                .must(queryBuilder
                        .keyword()
                        .fuzzy()
                        .withThreshold(0.8f)
                        .onFields("title", "location", "description", "services.name")
                        .andField("type").ignoreFieldBridge()
                        .matching(params.getQuery())
                        .createQuery())
                .must(queryBuilder
                        .range()
                        .onField("availabilityPeriods.startDate")
                        .below(params.getStartDate())
                        .createQuery())
                .must(queryBuilder
                        .range()
                        .onField("availabilityPeriods.endDate")
                        .above(params.getEndDate())
                        .createQuery())
                .createQuery();

        FullTextQuery jpaQuery = fullTextEntityManager.createFullTextQuery(q, Property.class);
        int totalCount = jpaQuery.getResultSize();

        jpaQuery.setFirstResult(pageable.getPageNumber() * pageable.getPageSize())
                .setMaxResults(pageable.getPageSize());

        @SuppressWarnings("unchecked")
        List<Property> results = jpaQuery.getResultList();

        return new PageImpl<Property>(results, pageable, totalCount);
    }
}
