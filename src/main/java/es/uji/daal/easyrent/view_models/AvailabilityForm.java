package es.uji.daal.easyrent.view_models;

import es.uji.daal.easyrent.model.AvailabilityPeriod;

import java.util.Date;

/**
 * Created by Alberto on 07/06/2016.
 */
public class AvailabilityForm implements ViewModel<AvailabilityPeriod> {

    private Date startDate;
    private Date endDate;
    private boolean endless = false;

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isEndless() {
        return endless;
    }

    public void setEndless(boolean endless) {
        this.endless = endless;
    }

    @Override
    public AvailabilityForm fillUp(AvailabilityPeriod availabilityPeriod) {
        setStartDate(availabilityPeriod.getStartDate());
        setEndDate(availabilityPeriod.getEndDate());
        if (availabilityPeriod.getEndDate() == null) {
            setEndless(true);
            setEndDate(availabilityPeriod.getStartDate());
        }
        return this;
    }

    @Override
    public AvailabilityPeriod update(AvailabilityPeriod model) {
        model.setStartDate(getStartDate());
        if (!endless) {
            model.setEndDate(getEndDate());
        }
        return model;
    }
}
