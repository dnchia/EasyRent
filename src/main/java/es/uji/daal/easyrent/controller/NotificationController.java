package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.Notification;
import es.uji.daal.easyrent.model.User;
import es.uji.daal.easyrent.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.Set;
import java.util.UUID;

/**
 * Created by Alberto on 29/06/2016.
 */
@Controller
@RequestMapping("/notification")
public class NotificationController {

    @Autowired
    private NotificationRepository repository;

    @RequestMapping("/show/{id}")
    public String show(@PathVariable("id") String id, HttpSession session) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Notification notification = repository.findOne(UUID.fromString(id));
        if (!loggedUser.equals(notification.getUser())) {
            return "redirect:../index.html";
        }
        Set<Notification> notifications = (Set<Notification>) session.getAttribute("notifications");
        notifications.remove(notification);
        repository.delete(notification);
        switch (notification.getType()) {
            case BOOKING_RECEIVED:
            case BOOKING_ACCEPTED:
            case BOOKING_REJECTED:
            case BOOKING_EXPIRED:
                return "redirect:../../booking-proposal/show/" + notification.getTargetId() + ".html";
            case CONVERSATION_STARTED:
            case MESSAGE_RECEIVED:
                return "redirect:../../conversation/show/" + notification.getTargetId() + ".html";
            default:
                return "redirect:../../index.html";
        }
    }

    @RequestMapping(value = "/dismiss/{id}", method = RequestMethod.POST)
    public String dismiss(@PathVariable("id") String id, HttpSession session) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Notification notification = repository.findOne(UUID.fromString(id));
        if (!loggedUser.equals(notification.getUser())) {
            return "redirect:../../index.html";
        }
        Set<Notification> notifications = (Set<Notification>) session.getAttribute("notifications");
        notifications.remove(notification);
        repository.delete(notification);
        return "redirect:../../user/profile/"+ loggedUser.getId() +".html#notifications";
    }

    @RequestMapping(value = "/clear-all", method = RequestMethod.POST)
    public String clearAll(HttpSession session) {
        User loggedUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Set<Notification> notifications = (Set<Notification>) session.getAttribute("notifications");
        notifications.clear();
        repository.deleteByUser(loggedUser);
        return "redirect:../user/profile/"+ loggedUser.getId() +".html#notifications";
    }
}
