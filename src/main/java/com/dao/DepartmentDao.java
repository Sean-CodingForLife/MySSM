package com.dao;

import java.util.List;

import com.po.Department;

import org.apache.ibatis.annotations.Param;

public interface DepartmentDao {

    public List<Department> queryAllDepartment();

    public Integer queryDepartmentsCount();

    public Integer queryDepartmentsCountByName(@Param("keyword") String keyword);

    public Integer addDepartment(Department department);

    public Integer deleteDepartment(Department department);

    public Integer updateDepartment(Department department);

    public Department queryDepartmentByName(@Param("name") String keyword);

    public List<Department> queryDepartments();

    public List<Department> queryDepartmentsByName(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);
}