package es.uji.daal.easyrent.utils;

import es.uji.daal.easyrent.model.AvailabilityPeriod;

import java.util.List;

/**
 * Created by Alberto on 15/06/2016.
 */
public class AvailabilityChanges {
    private final List<AvailabilityPeriod> toBeSaved;
    private final List<AvailabilityPeriod> toBeRemoved;

    public AvailabilityChanges(List<AvailabilityPeriod> toBeSaved, List<AvailabilityPeriod> toBeRemoved) {
        this.toBeSaved = toBeSaved;
        this.toBeRemoved = toBeRemoved;
    }

    public List<AvailabilityPeriod> getToBeSaved() {
        return toBeSaved;
    }

    public List<AvailabilityPeriod> getToBeRemoved() {
        return toBeRemoved;
    }
}
