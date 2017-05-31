package es.uji.daal.easyrent.view_models;

/**
 * Created by alberto on 11/05/16.
 */
public interface ViewModel<T> {
    T update(T model);
    ViewModel fillUp(T model);
}
