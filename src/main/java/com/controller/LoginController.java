package com.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.message.Message;
import com.myTool.MyTokenTool;
import com.po.User;
import com.service.UserService;

@Controller
public class LoginController extends BaseController {

	@Autowired
	private UserService userService;

	@PostMapping("/api/session")
	@ResponseBody
	public Message login(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		User loginUser = userService.login(user);
		if (loginUser == null) {
			if (userService.accountExists(user.getAccount())) {
				return Message.loginFail_Password;
			}
			return Message.loginFail_Account;
		}
		request.getSession().setAttribute("loginRole", loginUser.getRole());
		request.getSession().setAttribute("loginAccount", loginUser.getAccount());
		MyTokenTool.addToken(request, response);
		return Message.loginSuccess;
	}

	@DeleteMapping("/api/session")
	@ResponseBody
	public Message logout(HttpServletRequest request, HttpServletResponse response) {
		MyTokenTool.removeToken(request, response);
		request.getSession().removeAttribute("loginRole");
		request.getSession().removeAttribute("loginAccount");
		return Message.success;
	}

}
