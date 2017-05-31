package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.handler.BookingProposalEmailBroker;
import es.uji.daal.easyrent.model.BookingProposal;
import es.uji.daal.easyrent.repository.BookingProposalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.UUID;

/**
 * Created by Alberto on 18/06/2016.
 */
@Controller
@RequestMapping("/test")
public class TestController {

    @Autowired
    private BookingProposalRepository repository;

    @Autowired
    private BookingProposalEmailBroker emailBroker;

    @ResponseBody
    @RequestMapping("/mail")
    public String  sendTestEmail() {
        BookingProposal proposal = repository.findOne(UUID.fromString("15cff28a-818e-4687-8112-a74759e5915c"));
        emailBroker.setProposal(proposal).sendExpirationOwnerEmail();
        return "OK";
    }
}
