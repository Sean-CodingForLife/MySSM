package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.message.Message;
import com.myTool.MyTokenTool;
import com.po.AdminUser;
import com.po.User;
import com.service.AdminUserService;
import com.service.UserService;

@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

	@Autowired
	private AdminUserService adminUserService;

	@Autowired
	private UserService userService;

	private final static String adminLoginPageUrl = "/admin/login";
	private final static String userLoginPageUrl = "/user/login";

	@GetMapping("/{type}")
	public String toLoginPage(@PathVariable String type) {

		if (type.equals("admin")) {
			return LoginController.adminLoginPageUrl;
		} else if (type.equals("user")) {
			return LoginController.userLoginPageUrl;
		}
		return "redirect:/error.jsp";
	}

	@PostMapping(value = "/user", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String login(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		Message message = userService.login(user);
		if (message.getFlag()) {
			MyTokenTool.addToken("user", request, response);
		}
		return message.toJson();
	}

	@PostMapping(value = "/admin", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String login(@RequestBody AdminUser adminUser, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Message message = adminUserService.login(adminUser);
		if (message.getFlag()) {
			request.getSession().setAttribute("adminUserAccount", adminUser.getAccount());
			MyTokenTool.addToken("admin", request, response);
		}
		return message.toJson();
	}

}
