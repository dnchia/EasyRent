package es.uji.daal.easyrent.utils;

import es.uji.daal.easyrent.model.AvailabilityPeriod;
import es.uji.daal.easyrent.model.BookingProposal;
import es.uji.daal.easyrent.model.ProposalStatus;
import es.uji.daal.easyrent.view_models.AvailabilityForm;
import es.uji.daal.easyrent.view_models.BookingForm;

import java.util.*;

/**
 * Created by Alberto on 15/06/2016.
 */
public class BookingUtils {

    public static boolean isPeriodCollidingWithProposals(AvailabilityForm form, Collection<BookingProposal> proposals) {

        for (BookingProposal proposal : proposals) {
            if (proposal.getStatus() != ProposalStatus.REJECTED) {
                if (form.getStartDate().compareTo(proposal.getStartDate()) >= 0 &&
                        form.getStartDate().compareTo(proposal.getEndDate()) <= 0) {
                    return true;
                }

                if (!form.isEndless() && form.getEndDate().compareTo(proposal.getStartDate()) >= 0 &&
                        form.getEndDate().compareTo(proposal.getEndDate()) <= 0) {
                    return true;
                }

                if (form.getStartDate().compareTo(proposal.getStartDate()) <= 0) {
                    if (form.isEndless() || form.getEndDate().compareTo(proposal.getEndDate()) >= 0) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public static boolean isDatePeriodAvailable(BookingForm form, Collection<AvailabilityPeriod> periods) {
        Set<AvailabilityPeriod> orderedPeriods = new TreeSet<>((o1, o2) -> o1.getStartDate().compareTo(o2.getStartDate()));
        orderedPeriods.addAll(periods);

        boolean interPeriod = false;
        Date endDateLastInterPeriod = null;
        Iterator<AvailabilityPeriod> it = orderedPeriods.iterator();
        while (it.hasNext()) {
            AvailabilityPeriod period = it.next();
            if (isInsidePeriod(form, period)) {
                return true;
            }

            if (isStartingInPeriod(form, period)) {
                interPeriod = true;
                endDateLastInterPeriod = period.getEndDate();
            } else if (interPeriod) {
                if (DateUtils.daysBetweenDates(endDateLastInterPeriod, period.getStartDate()) > 1) {
                    return false;
                }

                if (isEndingInPeriod(form, period)) {
                    return true;
                } else if (!isOverlapingPeriod(form, period)) {
                    return false;
                }
                endDateLastInterPeriod = period.getEndDate();
            }
        }
        return false;
    }

    public static AvailabilityChanges getChanges(BookingForm form, Collection<AvailabilityPeriod> periods) {
        List<AvailabilityPeriod> affectedPeriods = getAffectedPeriods(form, periods);

        List<AvailabilityPeriod> toBeSaved = new LinkedList<>();
        List<AvailabilityPeriod> toBeRemoved = new LinkedList<>();

        if (affectedPeriods.size() == 1) {
            AvailabilityPeriod period = affectedPeriods.get(0);
            if (form.getStartDate().equals(period.getStartDate())) {
                if (form.getEndDate().equals(period.getEndDate())) {
                    toBeRemoved.add(period);
                } else {
                    period.setStartDate(DateUtils.getDatePlusDays(form.getEndDate(), 1));
                    toBeSaved.add(period);
                }
            } else {
                if (form.getEndDate().equals(period.getEndDate())) {
                    period.setEndDate(DateUtils.getDateMinusDays(form.getStartDate(), 1));
                    toBeSaved.add(period);
                } else {
                    AvailabilityPeriod endPeriod = new AvailabilityPeriod(period.getProperty());
                    endPeriod.setStartDate(DateUtils.getDatePlusDays(form.getEndDate(), 1));
                    endPeriod.setEndDate(period.getEndDate());
                    toBeSaved.add(endPeriod);

                    period.setEndDate(DateUtils.getDateMinusDays(form.getStartDate(), 1));
                    toBeSaved.add(period);
                }
            }
        } else {
            int LAST_POSITION = affectedPeriods.size() - 1;
            for (int i = 1; i < LAST_POSITION; i++) {
                toBeRemoved.add(affectedPeriods.get(i));
            }

            AvailabilityPeriod firstPeriod = affectedPeriods.get(0);
            if (form.getStartDate().equals(firstPeriod.getStartDate())) {
                toBeRemoved.add(firstPeriod);
            } else {
                firstPeriod.setEndDate(DateUtils.getDateMinusDays(form.getStartDate(), 1));
                toBeSaved.add(firstPeriod);
            }

            AvailabilityPeriod lastPeriod = affectedPeriods.get(LAST_POSITION);
            if (form.getEndDate().equals(lastPeriod.getEndDate())) {
                toBeRemoved.add(lastPeriod);
            } else {
                lastPeriod.setStartDate(DateUtils.getDatePlusDays(form.getEndDate(), 1));
                toBeSaved.add(lastPeriod);
            }
        }

        return new AvailabilityChanges(toBeSaved, toBeRemoved);
    }

    public static List getAffectedPeriods(BookingForm form, Collection<AvailabilityPeriod> periods) {
        Set<AvailabilityPeriod> orderedPeriods = new TreeSet<>((o1, o2) -> o1.getStartDate().compareTo(o2.getStartDate()));
        orderedPeriods.addAll(periods);

        List<AvailabilityPeriod> affectedPeriods = new ArrayList<>();

        boolean interPeriod = false;
        Iterator<AvailabilityPeriod> it = orderedPeriods.iterator();
        while (it.hasNext()) {
            AvailabilityPeriod period = it.next();
            if (isInsidePeriod(form, period)) {
                affectedPeriods.add(period);
                break;
            }

            if (isStartingInPeriod(form, period)) {
                interPeriod = true;
                affectedPeriods.add(period);
            } else if (interPeriod) {
                affectedPeriods.add(period);
                if (isEndingInPeriod(form, period)) {
                    break;
                }
            }
        }

        return affectedPeriods;
    }

    private static boolean isInsidePeriod(BookingForm form, AvailabilityPeriod period) {
        if (compareStartDates(form, period) >= 0) {
            if (period.getEndDate() == null) {
                return true;
            }
            if (compareEndDates(form, period) <= 0) {
                return true;
            }
        }
        return false;
    }

    private static boolean isStartingInPeriod(BookingForm form, AvailabilityPeriod period) {
        if (compareStartDates(form, period) >= 0 && compareStartAndEndDates(form, period) <= 0) {
            if (compareEndDates(form, period) > 0) {
                return true;
            }
        }
        return false;
    }

    private static boolean isEndingInPeriod(BookingForm form, AvailabilityPeriod period) {
        if (compareStartDates(form, period) < 0) {
            if (period.getEndDate() == null) {
                return true;
            }
            if (compareEndDates(form, period) <= 0) {
                return true;
            }
        }
        return false;
    }

    private static boolean isOverlapingPeriod(BookingForm form, AvailabilityPeriod period) {
        return compareStartDates(form, period) < 0 && compareEndDates(form, period) > 0;
    }

    private static int compareEndDates(BookingForm form, AvailabilityPeriod period) {
        return form.getEndDate().compareTo(period.getEndDate());
    }

    private static int compareStartDates(BookingForm form, AvailabilityPeriod period) {
        return form.getStartDate().compareTo(period.getStartDate());
    }

    private static int compareStartAndEndDates(BookingForm form, AvailabilityPeriod period) {
        return form.getStartDate().compareTo(period.getEndDate());
    }
}
