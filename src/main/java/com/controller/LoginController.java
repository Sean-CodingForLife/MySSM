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
import com.po.LoginLog;
import com.service.SystemService;
import com.service.UserService;
import com.wf.captcha.utils.CaptchaUtil;

@Controller
public class LoginController extends BaseController {

	@Autowired
	private UserService userService;

	@Autowired
	private SystemService systemService;

	@PostMapping("/api/session")
	@ResponseBody
	public Message login(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		if (!CaptchaUtil.ver(user.getCaptcha(), request)) {
			CaptchaUtil.clear(request);
			saveLoginLog(user.getAccount(), "FAIL", request.getRemoteAddr(), "Captcha verification failed.");
			return Message.captchaFail;
		}
		CaptchaUtil.clear(request);

		User loginUser = userService.login(user);
		if (loginUser == null) {
			if (userService.accountExists(user.getAccount())) {
				saveLoginLog(user.getAccount(), "FAIL", request.getRemoteAddr(), "Incorrect password.");
				return Message.loginFail_Password;
			}
			saveLoginLog(user.getAccount(), "FAIL", request.getRemoteAddr(), "Account not found.");
			return Message.loginFail_Account;
		}
		request.getSession().setAttribute("loginRole", loginUser.getRole());
		request.getSession().setAttribute("loginAccount", loginUser.getAccount());
		request.getSession().setAttribute("loginUserId", loginUser.getId());
		request.getSession().setAttribute("loginMenus", systemService.queryMenusByUserId(loginUser.getId()));
		request.getSession().setAttribute("loginPermissions", systemService.queryPermissionsByUserId(loginUser.getId()));
		saveLoginLog(loginUser.getAccount(), "SUCCESS", request.getRemoteAddr(), "Login succeeded.");
		MyTokenTool.addToken(request, response);
		return Message.loginSuccess;
	}

	private void saveLoginLog(String account, String status, String ip, String message) {
		LoginLog log = new LoginLog();
		log.setAccount(account);
		log.setStatus(status);
		log.setIp(ip);
		log.setMessage(message);
		systemService.addLoginLog(log);
	}

	@DeleteMapping("/api/session")
	@ResponseBody
	public Message logout(HttpServletRequest request, HttpServletResponse response) {
		MyTokenTool.removeToken(request, response);
		request.getSession().removeAttribute("loginRole");
		request.getSession().removeAttribute("loginAccount");
		request.getSession().removeAttribute("loginUserId");
		request.getSession().removeAttribute("loginMenus");
		request.getSession().removeAttribute("loginPermissions");
		return Message.success;
	}

}
