package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.handler.TokenEmailBroker;
import es.uji.daal.easyrent.model.Token;
import es.uji.daal.easyrent.model.TokenType;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.model.UserRole;
import es.uji.daal.easyrent.repository.TokenRepository;
import es.uji.daal.easyrent.repository.UserRepository;
import es.uji.daal.easyrent.utils.PasswordEncryptor;
import es.uji.daal.easyrent.validators.SignupValidator;
import es.uji.daal.easyrent.view_models.SignupForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

/**
 * Created by daniel on 30/04/16.
 */

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TokenRepository tokenRepository;

    @Autowired
    private PasswordEncryptor passwordEncryptor;

    @Autowired
    private TokenEmailBroker emailBroker;


    @RequestMapping("/login")
    public String login() {
        if (!(SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof String)) {
            return "redirect:index.html";
        }

        return "auth/login";
    }

    @RequestMapping("/signup")
    public String signup(Model model) {
        if (!(SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof String)) {
            return "redirect:index.html";
        }

        SignupForm signupForm = new SignupForm();
        model.addAttribute("form", signupForm);
        return "auth/signup";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String processSignup(@ModelAttribute("form") SignupForm form,
                                BindingResult bindingResult) {
        new SignupValidator().validate(form, bindingResult);
        if (userRepository.existsByUsername(form.getUsername())) {
            bindingResult.rejectValue("username", "exists", "That username already exists");
        }
        if (userRepository.existsByEmail(form.getEmail())) {
            bindingResult.rejectValue("email", "exists", "There is an account with that email");
        }
        if (bindingResult.hasErrors()) {
            return "auth/signup";
        }

        form.setPassword(passwordEncryptor.generateHash(form.getPassword()));
        User user = form.update(new User());

        if (userRepository.count() == 0) {
            user.setRole(UserRole.ADMINISTRATOR);
        }

        Token activationToken = user.createActivationToken();

        userRepository.save(user);
        tokenRepository.save(activationToken);

        emailBroker.setToken(activationToken).sendActivationEmail();

        return "redirect:index.html?success=su";
    }

    @RequestMapping("/user/activate")
    public String activateUser(@RequestParam("t") String tokenId) {
        if (!(SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof String)) {
            return "redirect:../index.html";
        }

        if (!tokenRepository.exists(UUID.fromString(tokenId))) {
            return "redirect:../login.html";
        } else {
            Token activationToken = tokenRepository.findOne(UUID.fromString(tokenId));
            if (activationToken.getType() != TokenType.ACTIVATION) {
                return "redirect:../login.html";
            }

            User user = activationToken.getUser();
            user.activate();

            userRepository.save(user);
            tokenRepository.delete(activationToken);
            return "redirect:../login.html?success=ac";
        }
    }
}
