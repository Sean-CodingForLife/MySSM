package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.message.Message;
import com.po.User;
import com.service.UserService;

@Controller
public class RegisterController {

	@Autowired
	private UserService userService;

	private final static String userRegisterPageUrl = "user/register";

	@GetMapping("/user/register")
	public String toRegisterPage() {

		return RegisterController.userRegisterPageUrl;
	}

	@PostMapping("/api/public/users")
	@ResponseBody
	public Message register(@RequestBody User user) {

		return userService.register(user);

	}

}
