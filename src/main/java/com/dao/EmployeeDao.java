package com.dao;

import java.util.List;
import java.util.Map;

import com.po.Employee;

import org.apache.ibatis.annotations.Param;

public interface EmployeeDao {

        public Employee queryEmployeeByNo(@Param("keyword") Integer keyword);

        public List<Employee> queryEmployees(@Param("start") Integer start, @Param("end") Integer end);

        public Integer queryEmployeesCount();

        public List<Employee> queryEmployeesByName(@Param("keyword") String keyword, @Param("start") Integer start,
                        @Param("end") Integer end);

        public Integer queryEmployeesCountByName(@Param("keyword") String keyword);

        public List<Employee> queryEmployeesById(@Param("keyword") String keyword, @Param("start") Integer start,
                        @Param("end") Integer end);

        public Integer queryEmployeesCountById(@Param("keyword") String keyword);

        public List<Employee> queryEmployeesByPhone(@Param("keyword") String keyword, @Param("start") Integer start,
                        @Param("end") Integer end);

        public Integer queryEmployeesCountByPhone(@Param("keyword") String keyword);

        public List<Employee> queryEmployeesBySex(@Param("keyword") String keyword, @Param("start") Integer start,
                        @Param("end") Integer end);

        public Integer queryEmployeesCountBySex(@Param("keyword") String keyword);

        public Integer updateEmployee(Map<String, Object> map);

        public Integer addEmployee(Map<String, Object> map);

        public Integer deleteEmployee(Employee employee);

}