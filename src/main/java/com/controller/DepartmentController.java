package com.controller;

import java.util.List;
import com.po.Department;
import com.service.DepartmentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/department")
public class DepartmentController extends BaseController {

	@Autowired
	DepartmentService departmentService;

	private final static String departmentPageUrl = "admin/department/department";

	@GetMapping("/home")
	public String toDepartmentPage() {
		return DepartmentController.departmentPageUrl;
	}

	@GetMapping("/departments")
	@ResponseBody
	public String queryDepartments(@RequestParam String keyword, @RequestParam Integer startPage,
			@RequestParam Integer offset) {
		return departmentService.queryDepartments(keyword, startPage, offset).toJson();
	}

	@DeleteMapping("/departments")
	@ResponseBody
	public String deleteDepartments(@RequestBody List<Department> departments) {
		return departmentService.deleteDepartments(departments).toJson();
	}

	@PutMapping("/department")
	@ResponseBody
	public String updateDepartment(@RequestBody Department department) {
		return departmentService.updateDepartment(department).toJson();
	}

	@PostMapping("/department")
	@ResponseBody
	public String addDepartment(@RequestBody Department department) {
		return departmentService.addDepartment(department).toJson();
	}

}
