package com.controller;

import javax.servlet.http.HttpServletRequest;

import com.myTool.MyTokenTool;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController extends BaseController {

    private static final String DASHBOARD_PAGE = "dashboard";

    @GetMapping("/dashboard")
    public String toDashboardPage(HttpServletRequest request) {
        if (MyTokenTool.checkToken(request)) {
            request.setAttribute("loginRole", request.getSession().getAttribute("loginRole"));
            request.setAttribute("loginAccount", request.getSession().getAttribute("loginAccount"));
            return DASHBOARD_PAGE;
        }

        return "redirect:/";
    }
}
