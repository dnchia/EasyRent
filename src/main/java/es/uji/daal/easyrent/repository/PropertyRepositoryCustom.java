package es.uji.daal.easyrent.repository;

import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.view_models.SearchParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Created by Alberto on 15/05/2016.
 */
public interface PropertyRepositoryCustom {
    Page<Property> searchBy(SearchParams params, Pageable pageable);
}
