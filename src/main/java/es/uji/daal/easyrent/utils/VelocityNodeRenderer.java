package es.uji.daal.easyrent.utils;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by Alberto on 18/06/2016.
 */
@Component
public class VelocityNodeRenderer {
    @Autowired
    private VelocityEngine velocityEngine;

    public String renderViewTree(VelocityNode node) {
        return node.render(velocityEngine);
    }
}
