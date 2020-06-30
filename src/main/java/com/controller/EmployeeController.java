package com.controller;

import java.util.List;
import java.util.Map;

import com.po.Employee;
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
@RequestMapping("/employee")
public class EmployeeController extends BaseController {

	@Autowired
	EmployeeService employeeService;

	private final static String employeePageUrl = "admin/employee/employee";
	
	@GetMapping("/home")
	public String toEmployeePage() {
		return EmployeeController.employeePageUrl;
	}

	@GetMapping("/employees")
	@ResponseBody
	public String queryEmployees(@RequestParam String keyword, @RequestParam String type, @RequestParam Integer startPage, @RequestParam Integer offset) {
		return employeeService.queryEmployees(keyword, type, startPage, offset).toJson();
	}

	@DeleteMapping("/employees")
	@ResponseBody
	public String deleteEmployees(@RequestBody List<Employee> employees) {
		return employeeService.deleteEmployees(employees).toJson();
	}

	@PostMapping("/employee")
	@ResponseBody
	public String addEmployee(@RequestBody Map<String, Object> map) {
		return employeeService.addEmloyee(map).toJson();
	}

	@PutMapping("/employee")
	@ResponseBody
	public String updateEmployee(@RequestBody Map<String, Object> map) {
		return employeeService.updateEmployee(map).toJson();
	}
}
