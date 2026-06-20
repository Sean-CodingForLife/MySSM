package com.controller;

import java.util.List;
import java.util.Map;

import com.message.Message;
import com.po.Employee;
import com.responseData.ResponseData;
import com.service.EmployeeService;

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
public class EmployeeController extends BaseController {

	@Autowired
	EmployeeService employeeService;

	private final static String employeePageUrl = "admin/employee/employee";
	
	@GetMapping("/admin/employees")
	public String toEmployeePage() {
		return EmployeeController.employeePageUrl;
	}

	@GetMapping("/api/admin/employees")
	@ResponseBody
	public ResponseData queryEmployees(@RequestParam String keyword, @RequestParam String type, @RequestParam Integer startPage, @RequestParam Integer offset) {
		return employeeService.queryEmployees(keyword, type, startPage, offset);
	}

	@DeleteMapping("/api/admin/employees")
	@ResponseBody
	public Message deleteEmployees(@RequestBody List<Employee> employees) {
		return employeeService.deleteEmployees(employees);
	}

	@PostMapping("/api/admin/employees")
	@ResponseBody
	public Message addEmployee(@RequestBody Map<String, Object> map) {
		return employeeService.addEmployee(map);
	}

	@PutMapping("/api/admin/employees")
	@ResponseBody
	public Message updateEmployee(@RequestBody Map<String, Object> map) {
		return employeeService.updateEmployee(map);
	}
}
