package com.controller;

import javax.servlet.http.HttpServletRequest;

import com.myTool.MyTokenTool;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController extends BaseController {

    private static final String ADMIN_DASHBOARD_PAGE = "admin/dashboard";
    private static final String USER_DASHBOARD_PAGE = "user/dashboard";

    @GetMapping("/admin/dashboard")
    public String toAdminDashboardPage(HttpServletRequest request) {
        if (MyTokenTool.checkToken("admin", request)) {
            return ADMIN_DASHBOARD_PAGE;
        }
        return "redirect:/admin/login";
    }

    @GetMapping("/user/dashboard")
    public String toUserDashboardPage(HttpServletRequest request) {
        if (MyTokenTool.checkToken("user", request)) {
            return USER_DASHBOARD_PAGE;
        }
        return "redirect:/user/login";
    }
}
