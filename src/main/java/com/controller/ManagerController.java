package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.myTool.MyTokenTool;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager")
public class ManagerController extends BaseController {

	private final static String adminManagerPageUrl = "admin/manager";
	private final static String userManagerPageUrl = "user/manager";

	@GetMapping
	public String toManagerPage(HttpServletRequest request, HttpServletResponse response) {
		if (MyTokenTool.checkToken("user", request)) {
			return ManagerController.userManagerPageUrl;
		} else if (MyTokenTool.checkToken("admin", request)) {
			return ManagerController.adminManagerPageUrl;
		} else {
			return "redirect:/" + BaseController.ErorrPage;
		}
	}
}
