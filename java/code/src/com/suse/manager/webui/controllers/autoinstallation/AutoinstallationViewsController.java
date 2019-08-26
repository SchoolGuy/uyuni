package com.suse.manager.webui.controllers.autoinstallation;

import static com.suse.manager.webui.utils.SparkApplicationHelper.withCsrfToken;
import static com.suse.manager.webui.utils.SparkApplicationHelper.withUser;
import static spark.Spark.get;

import com.redhat.rhn.domain.user.User;

import java.util.HashMap;
import java.util.Map;

import spark.ModelAndView;
import spark.Request;
import spark.Response;
import spark.template.jade.JadeTemplateEngine;

public class AutoinstallationViewsController {
    /**
     * @param jade JadeTemplateEngine
     * Invoked from Router. Init routes for Autoinstallation.
     */
    public static void initRoutes(JadeTemplateEngine jade) {
        get("/manager/autoinstallation/profiles/createAdvanced",
                withCsrfToken(withUser(AutoinstallationViewsController::createProfileAdvanced)), jade);
    }

    /**
     * Handler for the advanced profile create page.
     *
     * @param req the request object
     * @param res the response object
     * @param user the current user
     * @return the ModelAndView object to render the page
     */
    public static ModelAndView createProfileAdvanced(Request req, Response res, User user) {
        Map<String, Object> data = new HashMap<>();
        return new ModelAndView(data, "controllers/autoinstallation/templates/create-profile.jade");
    }
}
