package com.service;

import java.util.List;
import java.util.Map;

import com.message.Message;
import com.po.Employee;
import com.reponseData.ResponseData;

public interface EmployeeService {
    public ResponseData queryEmployees(String keyword, String type,Integer startPage, Integer offset);
    public Message      addEmloyee(Map<String, Object> map);
    public Message      deleteEmployees(List<Employee> employees);
    public Message      updateEmployee(Map<String, Object> map);
    
}