package es.uji.daal.easyrent.utils;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.stereotype.Component;
import org.springframework.ui.velocity.VelocityEngineUtils;

import java.util.Map;

/**
 * Created by Alberto on 18/06/2016.
 */


public class VelocityNode {
    private String templateName;
    private Map<String, Object> model;
    private VelocityNode child;
    private boolean leaf;

    public VelocityNode(String templateName, Map<String, Object> model) {
        this.templateName = templateName;
        this.model = model;
        this.leaf = true;
    }

    public VelocityNode(String templateName, Map<String, Object> model, VelocityNode child) {
        this.templateName = templateName;
        this.model = model;
        this.child = child;
        this.leaf = false;
    }

    public String render(VelocityEngine engine) {
        if (!leaf) {
            String innerTemplate = child.render(engine);
            model.put("template" , innerTemplate);
        }
        return VelocityEngineUtils.mergeTemplateIntoString(
                engine, templateName, "UTF8", model
        );
    }
}
