package com.suse.manager.webui.controllers.autoinstallation.handlers;

import static com.suse.manager.webui.utils.SparkApplicationHelper.json;
import static com.suse.manager.webui.utils.SparkApplicationHelper.withUser;
import static spark.Spark.post;

import com.redhat.rhn.domain.user.User;

import com.suse.manager.webui.utils.gson.ResultJson;

import spark.Request;
import spark.Response;

public class ProfileApiController {

    /** Init routes for Autoinstallation Profiles Api.*/
    public static void initRoutes() {
        post("/manager/autoinstallation/api/profiles",
                withUser(ProfileApiController::createProfile));
    }

    public static String createProfile(Request request, Response response, User user) {
        ResultJson result = new ResultJson();

        return json(response, result);
    }
}
