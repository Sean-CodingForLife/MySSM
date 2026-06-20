package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.message.Message;
import com.myTool.MyTokenTool;
import com.po.AdminUser;
import com.po.User;
import com.service.AdminUserService;
import com.service.UserService;

@Controller
public class LoginController extends BaseController {

	@Autowired
	private AdminUserService adminUserService;

	@Autowired
	private UserService userService;

	private final static String adminLoginPageUrl = "/admin/login";
	private final static String userLoginPageUrl = "/user/login";

	@GetMapping("/admin/login")
	public String toAdminLoginPage() {
		return LoginController.adminLoginPageUrl;
	}

	@GetMapping("/user/login")
	public String toUserLoginPage() {
		return LoginController.userLoginPageUrl;
	}

	@PostMapping("/api/user/session")
	@ResponseBody
	public Message login(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		Message message = userService.login(user);
		if (message.getFlag()) {
			request.getSession().setAttribute("userAccount", user.getAccount());
			MyTokenTool.addToken("user", request, response);
		}
		return message;
	}

	@PostMapping("/api/admin/session")
	@ResponseBody
	public Message login(@RequestBody AdminUser adminUser, HttpServletRequest request, HttpServletResponse response) {

		Message message = adminUserService.login(adminUser);
		if (message.getFlag()) {
			request.getSession().setAttribute("adminUserAccount", adminUser.getAccount());
			MyTokenTool.addToken("admin", request, response);
		}
		return message;
	}

	@DeleteMapping("/api/admin/session")
	@ResponseBody
	public Message logoutAdmin(HttpServletRequest request, HttpServletResponse response) {
		MyTokenTool.removeToken("admin", request, response);
		return Message.success;
	}

	@DeleteMapping("/api/user/session")
	@ResponseBody
	public Message logoutUser(HttpServletRequest request, HttpServletResponse response) {
		MyTokenTool.removeToken("user", request, response);
		return Message.success;
	}

}
