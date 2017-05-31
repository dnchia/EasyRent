package es.uji.daal.easyrent.view_models;

import java.util.Date;

/**
 * Created by Alberto on 02/07/2016.
 */
public class SearchParams {
    private String query;
    private Date startDate;
    private Date endDate;

    public String getQuery() {
        return query;
    }

    public SearchParams setQuery(String query) {
        this.query = query;
        return this;
    }

    public Date getStartDate() {
        return startDate;
    }

    public SearchParams setStartDate(Date startDate) {
        this.startDate = startDate;
        return this;
    }

    public Date getEndDate() {
        return endDate;
    }

    public SearchParams setEndDate(Date endDate) {
        this.endDate = endDate;
        return this;
    }
}
