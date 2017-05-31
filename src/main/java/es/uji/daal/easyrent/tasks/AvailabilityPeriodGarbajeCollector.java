package es.uji.daal.easyrent.tasks;

import es.uji.daal.easyrent.repository.AvailabilityPeriodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.logging.Logger;

/**
 * Created by Alberto on 17/06/2016.
 */
@Component
public class AvailabilityPeriodGarbajeCollector {

    @Autowired
    private AvailabilityPeriodRepository periodRepository;

    @Scheduled(cron = "00 10 0 * * *")
    public void rejectInfeasibleProposals() {
        int removeCount = periodRepository.removeOutdatedPeriods();

        Logger.getAnonymousLogger().info(String.format("Removed %d outdated availability periods", removeCount));
    }
}
