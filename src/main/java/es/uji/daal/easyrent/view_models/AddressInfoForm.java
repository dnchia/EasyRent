package es.uji.daal.easyrent.view_models;

import es.uji.daal.easyrent.model.User;

/**
 * Created by Alberto on 12/05/2016.
 */
public class AddressInfoForm implements ViewModel<User> {
    private String address;
    private String country;
    private int postCode;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getPostCode() {
        return postCode;
    }

    public void setPostCode(int postCode) {
        this.postCode = postCode;
    }

    @Override
    public AddressInfoForm fillUp(User model) {
        setAddress(model.getPostalAddress());
        setCountry(model.getCountry());
        setPostCode(model.getPostCode());
        return this;
    }

    @Override
    public User update(User model) {
        model.setPostalAddress(getAddress());
        model.setCountry(getCountry());
        model.setPostCode(getPostCode());
        return null;
    }
}
