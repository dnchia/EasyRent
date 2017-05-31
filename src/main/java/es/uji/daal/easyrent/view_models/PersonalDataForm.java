package es.uji.daal.easyrent.view_models;

import es.uji.daal.easyrent.model.User;

/**
 * Created by Alberto on 12/05/2016.
 */
public class PersonalDataForm implements ViewModel<User>{

    private static final int PREFIX = 0;
    private static final int NUMBER = 1;

    private String name;
    private String surnames;
    private String dni;
    private String countryPrefix;
    private String phoneNumber;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurnames() {
        return surnames;
    }

    public void setSurnames(String surnames) {
        this.surnames = surnames;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getCountryPrefix() {
        return countryPrefix;
    }

    public void setCountryPrefix(String countryPrefix) {
        this.countryPrefix = countryPrefix;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public PersonalDataForm fillUp(User model) {
        setName(model.getName());
        setSurnames(model.getSurnames());
        setDni(model.getDni());
        if (model.getPhoneNumber() != null && model.getPhoneNumber().matches("\\S+ \\S+")) {
            String[] phoneData = model.getPhoneNumber().split(" ");
            setCountryPrefix(phoneData[PREFIX]);
            setPhoneNumber(phoneData[NUMBER]);
        }
        return this;
    }

    @Override
    public User update(User model) {
        model.setName(getName());
        model.setSurnames(getSurnames());
        model.setDni(getDni());
        model.setPhoneNumber(getCountryPrefix() + " " + getPhoneNumber());
        return model;
    }
}
