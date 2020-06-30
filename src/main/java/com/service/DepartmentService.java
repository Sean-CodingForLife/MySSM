package com.service;

import java.util.List;

import com.message.Message;
import com.po.Department;
import com.reponseData.ResponseData;

public interface DepartmentService {
    public ResponseData queryDepartments(String keyword, Integer startPage, Integer offset);
    public Message      deleteDepartments(List<Department> departments);
    public Message      addDepartment(Department department);
    public Message      updateDepartment(Department department);
}
