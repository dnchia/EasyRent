package es.uji.daal.easyrent.tasks;

import es.uji.daal.easyrent.handler.BookingProposalEmailBroker;
import es.uji.daal.easyrent.model.*;
import es.uji.daal.easyrent.repository.AvailabilityPeriodRepository;
import es.uji.daal.easyrent.repository.BookingProposalRepository;
import es.uji.daal.easyrent.repository.NotificationRepository;
import es.uji.daal.easyrent.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Created by Alberto on 17/06/2016.
 */
@Component
public class BookingProposalRejector {

    @Autowired
    private BookingProposalRepository proposalRepository;

    @Autowired
    private AvailabilityPeriodRepository periodRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private BookingProposalEmailBroker emailBroker;

    @Scheduled(cron = "01 00 00 * * *")
    public void rejectInfeasibleProposals() {
        List<BookingProposal> proposals = proposalRepository.findInfeasibleProposalsFrom(
                DateUtils.getDateMinusDays(new Date(), 1));

        Logger.getAnonymousLogger().info(String.format("Rejecting %d proposals because of its infeasibility",
                proposals.size()));

        List<AvailabilityPeriod> periods = proposals.stream().map(proposal -> {
            proposal.reject();

            AvailabilityPeriod period = proposal.getProperty().createAvailabilityPeriod();
            period.setStartDate(proposal.getStartDate());
            period.setEndDate(proposal.getEndDate());
            return period;
        }).collect(Collectors.toList());

        proposalRepository.save(proposals);
        periodRepository.save(periods);

        proposals.forEach(bookingProposal -> {

            User owner = bookingProposal.getProperty().getOwner();
            User tenant = bookingProposal.getTenant();

            Notification bookingExpiredTenant = bookingProposal.getTenant()
                    .createNotification(NotificationType.BOOKING_EXPIRED);
            bookingExpiredTenant.setTargetId(bookingProposal.getId());
            bookingExpiredTenant.setSource(owner.getUsername());
            bookingExpiredTenant.setDestination(bookingProposal.getProperty().getTitle());
            if (owner.getPhoto() != null) {
                bookingExpiredTenant.setThumbnail(owner.getPhoto().getFilename());
            }

            Notification bookingExpiredOwner = bookingProposal.getProperty().getOwner()
                    .createNotification(NotificationType.BOOKING_EXPIRED);
            bookingExpiredOwner.setTargetId(bookingProposal.getId());
            bookingExpiredOwner.setSource(tenant.getUsername());
            bookingExpiredOwner.setDestination(bookingProposal.getProperty().getTitle());
            if (tenant.getPhoto() != null) {
                bookingExpiredOwner.setThumbnail(tenant.getPhoto().getFilename());
            }

            notificationRepository.save(Arrays.asList(bookingExpiredTenant, bookingExpiredOwner));

            emailBroker
                    .setProposal(bookingProposal)
                    .sendExpirationOwnerEmail()
                    .sendExpirationTenantEmail();
        });
    }
}
