package com.controller;

import java.util.List;
import com.message.Message;
import com.po.Department;
import com.responseData.ResponseData;
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
public class DepartmentController extends BaseController {

	@Autowired
	DepartmentService departmentService;

	private final static String departmentPageUrl = "admin/department/department";

	@GetMapping("/admin/departments")
	public String toDepartmentPage() {
		return DepartmentController.departmentPageUrl;
	}

	@GetMapping("/api/admin/departments")
	@ResponseBody
	public ResponseData queryDepartments(@RequestParam String keyword, @RequestParam Integer startPage,
			@RequestParam Integer offset) {
		return departmentService.queryDepartments(keyword, startPage, offset);
	}

	@DeleteMapping("/api/admin/departments")
	@ResponseBody
	public Message deleteDepartments(@RequestBody List<Department> departments) {
		return departmentService.deleteDepartments(departments);
	}

	@PutMapping("/api/admin/departments")
	@ResponseBody
	public Message updateDepartment(@RequestBody Department department) {
		return departmentService.updateDepartment(department);
	}

	@PostMapping("/api/admin/departments")
	@ResponseBody
	public Message addDepartment(@RequestBody Department department) {
		return departmentService.addDepartment(department);
	}

}
