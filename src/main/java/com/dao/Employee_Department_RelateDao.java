package com.dao;

import java.util.List;

import com.po.Department;
import com.po.Employee;
import com.po.Employee_Department_Relate;

import org.apache.ibatis.annotations.Param;

public interface Employee_Department_RelateDao {
    public List<Employee_Department_Relate> queryEmployee_Department_RelatesByDepartment(@Param("department") Department department, @Param("start") Integer start,
            @Param("end") Integer end);

    public Department queryDepartmentByEmployee(Employee employee);

    public Integer addEmployee_Department_Relate(Employee_Department_Relate employee_Department_Relate);

    public Integer deleteEmployee_Department_RelateByEmployee(Employee employee);

    public Integer deleteEmployee_Department_RelatesByDepartment(Department department);

    public Integer updateEmployee_Department_RelateDepartmentNoByEmployee(Employee_Department_Relate employee_Department_Relate);
}