package es.uji.daal.easyrent.model;

/**
 * Created by Alberto on 17/03/2016.
 */
public enum PropertyType {
    FLAT,
    STUDY,
    PENTHOUSE,
    HOUSE,
    DETACHED_HOUSE,
    COTTAGE,
    CHALET,
    APARTMENT;

    public String getLabel() {
        return this.toString().substring(0,1) + this.toString().substring(1).toLowerCase().replace("_", " ");
    }

    public String getValue() {
        return this.toString();
    }

    public static PropertyType obtainTypeFor(String serializedType) throws TypeNotFoundException {
        PropertyType type = findSuitableType(serializedType);
        if (type == null) {
            throw new TypeNotFoundException(serializedType);
        } else {
            return type;
        }
    }

    private static PropertyType findSuitableType(String serializedType) {
        PropertyType suitableType = null;
        for (PropertyType type : PropertyType.values()) {
            suitableType = type.getTypeIfSuitable(serializedType);
            if (suitableType != null) {
                break;
            }
        }
        return suitableType;
    }

    private PropertyType getTypeIfSuitable(String serializedType) {
        if (isSuitableType(serializedType)) {
            return this;
        }
        return null;
    }

    private boolean isSuitableType(String serializedType) {
        return this.toString().equals(serializedType);
    }
}
