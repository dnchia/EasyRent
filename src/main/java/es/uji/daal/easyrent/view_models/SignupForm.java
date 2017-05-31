package es.uji.daal.easyrent.view_models;

import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.utils.PasswordEncryptor;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by alberto on 11/05/16.
 */
public class SignupForm implements ViewModel<User>{

    private String username;
    private String password;
    private String repeatPassword;
    private String email;
    private String repeatEmail;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRepeatPassword() {
        return repeatPassword;
    }

    public void setRepeatPassword(String repeatPassword) {
        this.repeatPassword = repeatPassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRepeatEmail() {
        return repeatEmail;
    }

    public void setRepeatEmail(String repeatEmail) {
        this.repeatEmail = repeatEmail;
    }

    @Override
    public SignupForm fillUp(User model) {
        setUsername(model.getUsername());
        setEmail(model.getEmail());
        return this;
    }

    @Override
    public User update(User model) {
        model.setUsername(getUsername());
        model.setPassword(getPassword());
        model.setEmail(getEmail());
        return model;
    }
}
