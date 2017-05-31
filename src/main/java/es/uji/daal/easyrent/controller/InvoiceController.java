package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.Invoice;
import es.uji.daal.easyrent.repository.InvoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.UUID;

/**
 * Created by daniel on 15/05/16.
 */
@Controller
@RequestMapping("/invoice")
public class InvoiceController {
    @Autowired
    private InvoiceRepository invoiceRepository;

    @RequestMapping("/show/{id}")
    public String access(Model model, @PathVariable("id") String id) {
        Invoice invoice = invoiceRepository.findOne(UUID.fromString(id));

        model.addAttribute("invoice", invoice);
        return "invoicePdf";
    }
}
