package com.controller;

import java.util.List;
import com.po.User;
import com.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	@Autowired
	UserService userService;

	private final static String userPageUrl = "admin/user/user";

	@GetMapping("/home")
	public String toUserPage() {
		return UserController.userPageUrl;
	}

	@GetMapping("/users")
	@ResponseBody
	public String queryUser(@RequestParam String keyword, @RequestParam String type, @RequestParam Integer startPage,
			@RequestParam Integer offset) {
		return userService.queryUsers(keyword, type, startPage, offset).toJson();
	}

	@DeleteMapping("/users")
	@ResponseBody
	public String deleteUser(@RequestBody List<User> users) {
		return userService.deleteUsers(users).toJson();
	}

}
