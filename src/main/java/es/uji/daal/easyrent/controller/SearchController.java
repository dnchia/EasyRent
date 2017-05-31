package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.repository.PropertyRepository;
import es.uji.daal.easyrent.view_models.SearchParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

/**
 * Created by Alberto on 15/05/2016.
 */
@Controller
public class SearchController {

    @Autowired
    PropertyRepository repository;

    @RequestMapping("/search")
    public String search(Model model, Pageable pageable,
                         @RequestParam(value = "q") String query,
                         @RequestParam(value = "s") Date start,
                         @RequestParam(value = "e") Date end) {

        if ("".equals(query.trim())) {
            return "redirect:index.html";
        }
        SearchParams params = new SearchParams()
                .setQuery(query)
                .setStartDate(start)
                .setEndDate(end);

        Page<Property> properties = repository.searchBy(params, pageable);

        model.addAttribute("properties", properties.getContent());
        model.addAttribute("totalPages", properties.getTotalPages());
        model.addAttribute("currentPage", properties.getNumber());
        return "search";
    }
}
