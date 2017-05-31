package es.uji.daal.easyrent.view_models;

import es.uji.daal.easyrent.model.User;

/**
 * Created by Alberto on 12/05/2016.
 */
public class ChangePasswordForm implements ViewModel<User> {
    private String oldPassword;
    private String newPassword;
    private String repeatPassword;

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getRepeatPassword() {
        return repeatPassword;
    }

    public void setRepeatPassword(String repeatPassword) {
        this.repeatPassword = repeatPassword;
    }

    @Override
    public ChangePasswordForm fillUp(User model) {
        setOldPassword(model.getPassword());
        return this;
    }

    @Override
    public User update(User model) {
        model.setPassword(getNewPassword());
        return model;
    }
}
