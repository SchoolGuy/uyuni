package com.suse.manager.webui.controllers.autoinstallation;

import com.suse.manager.webui.controllers.autoinstallation.handlers.ProfileApiController;
import org.apache.log4j.Logger;

public class AutoinstallationApiController {

    private static Logger log = Logger.getLogger(AutoinstallationApiController.class);

    private AutoinstallationApiController() {}

    /** Invoked from Router. Init routes for ContentManagement Api.*/
    public static void initRoutes() {
        ProfileApiController.initRoutes();
    }
}
