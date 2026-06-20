package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserPortalController extends BaseController {

    @GetMapping("/user/profile")
    public String toProfilePage() {
        return "user/profile";
    }

    @GetMapping("/user/messages")
    public String toMessagesPage() {
        return "user/messages";
    }

    @GetMapping("/user/settings")
    public String toSettingsPage() {
        return "user/settings";
    }
}
