package com.dao;

import java.util.List;

import com.po.Employee;
import com.po.Employee_Job_Relate;
import com.po.Job;

import org.apache.ibatis.annotations.Param;

public interface Employee_Job_RelateDao {
    public List<Employee_Job_Relate> queryEmployee_Job_RelatesByJob(@Param("job") Job job, @Param("start") Integer start, @Param("end") Integer end);
    public Job                       queryJobByEmployee(Employee employee);
    public Integer                   addEmployee_Job_Relate(Employee_Job_Relate employee_Job_Relate);
    public Integer                   deleteEmployee_Job_RelateByEmployee(Employee employee);
    public Integer                   deleteEmployee_Job_RelatesByJob(Job job);
    public Integer                   updateEmployee_Job_RelateJobNoByEmployee(Employee_Job_Relate employee_Job_Relate);
}