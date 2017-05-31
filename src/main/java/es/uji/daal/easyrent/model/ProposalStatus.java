package es.uji.daal.easyrent.model;

/**
 * Created by Alberto on 17/03/2016.
 */
public enum ProposalStatus {
    PENDING,
    ACCEPTED,
    REJECTED;

    public String getValue() {
        return this.toString();
    }

    public String getLabel() {
        return this.toString().substring(0, 1) + this.toString().substring(1).toLowerCase();
    }

    public static ProposalStatus obtainStatusFor(String serializedStatus) throws StatusNotFoundException {
        ProposalStatus status = findSuitableStatus(serializedStatus);
        if (status == null) {
            throw new StatusNotFoundException(serializedStatus);
        } else {
            return status;
        }
    }

    private static ProposalStatus findSuitableStatus(String serializedStatus) {
        ProposalStatus suitableStatus = null;
        for (ProposalStatus status : ProposalStatus.values()) {
            suitableStatus = status.getStatusIfSuitable(serializedStatus);
            if (suitableStatus != null) {
                break;
            }
        }
        return suitableStatus;
    }

    private ProposalStatus getStatusIfSuitable(String serializedStatus) {
        if (isSuitableStatus(serializedStatus)) {
            return this;
        }
        return null;
    }

    private boolean isSuitableStatus(String serializedStatus) {
        return this.toString().equals(serializedStatus);
    }
}
