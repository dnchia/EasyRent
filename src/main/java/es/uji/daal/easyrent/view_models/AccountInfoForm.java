package es.uji.daal.easyrent.view_models;

import es.uji.daal.easyrent.model.User;

/**
 * Created by Alberto on 12/05/2016.
 */
public class AccountInfoForm implements ViewModel<User> {

    private String username;
    private String email;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public AccountInfoForm fillUp(User model) {
        setUsername(model.getUsername());
        setEmail(model.getEmail());
        return this;
    }

    @Override
    public User update(User model) {
        model.setUsername(getUsername());
        model.setEmail(getEmail());
        return model;
    }
}
