package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.po.User;
import com.service.UserService;

@Controller
@RequestMapping("/register")
public class RegisterController {

	@Autowired
	private UserService userService;

	private final static String userRegisterPageUrl = "user/register";

	@GetMapping
	public String toRegisterPage() {

		return RegisterController.userRegisterPageUrl;
	}

	@PostMapping(produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String register(@RequestBody User user) {

		return userService.register(user).toJson();

	}

}
