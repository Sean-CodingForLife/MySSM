package com.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.dao.DepartmentDao;
import com.dao.EmployeeDao;
import com.dao.Employee_Department_RelateDao;
import com.dao.Employee_Job_RelateDao;
import com.dao.JobDao;
import com.dao.ToolDao;
import com.message.Message;
import com.myTool.MyMapTool;
import com.po.Department;
import com.po.Employee;
import com.po.Employee_Department_Relate;
import com.po.Employee_Job_Relate;
import com.po.Job;
import com.responseData.ResponseData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("EmployeeService")
@Transactional
public class EmployeeServiceImp implements EmployeeService {

    @Autowired
    ToolDao toolDao;

    @Autowired
    EmployeeDao employeeDao;

    @Autowired
    JobDao jobDao;

    @Autowired
    DepartmentDao departmentDao;

    @Autowired
    Employee_Job_RelateDao employee_Job_RelateDao;

    @Autowired
    Employee_Department_RelateDao employee_Department_RelateDao;

    @Override
    public ResponseData queryEmployees(String keyword, String type, Integer startPage, Integer offset) {
        Integer count = 0;
        Integer start = (startPage - 1) * offset;
        Integer end = offset;
        List<Employee> employees = null;
        List<Map<String, Object>> result = null;

        switch (type) {
            case "name":
                count = employeeDao.queryEmployeesCountByName(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesByName(keyword, start, end);
                }
                break;
            case "id":
                count = employeeDao.queryEmployeesCountById(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesById(keyword, start, end);
                }
                break;
            case "phone":
                count = employeeDao.queryEmployeesCountByPhone(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesByPhone(keyword, start, end);
                }
                break;
            case "sex":
                count = employeeDao.queryEmployeesCountBySex(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesBySex(keyword, start, end);
                }
                break;
            case "job":
                Job job = jobDao.queryJobByName(keyword);
                if (job != null) {
                    count = employee_Job_RelateDao.queryEmployee_Job_RelatesCountByJob(job);
                    result = new ArrayList<Map<String, Object>>();
                    List<Employee_Job_Relate> relates = employee_Job_RelateDao.queryEmployee_Job_RelatesByJob(job, start, end);
                    for (Employee_Job_Relate relate : relates) {
                        Employee employee = employeeDao.queryEmployeeByNo(relate.getEmployee_no());
                        result.add(toEmployeeMap(employee));
                    }
                }
                break;
            case "department":
                Department department = departmentDao.queryDepartmentByName(keyword);
                if (department != null) {
                    count = employee_Department_RelateDao.queryEmployee_Department_RelatesCountByDepartment(department);
                    result = new ArrayList<Map<String, Object>>();
                    List<Employee_Department_Relate> relates = employee_Department_RelateDao
                            .queryEmployee_Department_RelatesByDepartment(department, start, end);
                    for (Employee_Department_Relate relate : relates) {
                        Employee employee = employeeDao.queryEmployeeByNo(relate.getEmployee_no());
                        result.add(toEmployeeMap(employee));
                    }
                }
                break;
            default:
                count = employeeDao.queryEmployeesCount();
                if (count != 0) {
                    employees = employeeDao.queryEmployees(start, end);
                }
                break;
        }

        if (result == null && employees != null) {
            result = new ArrayList<Map<String, Object>>();
            for (Employee employee : employees) {
                result.add(toEmployeeMap(employee));
            }
        }

        return new ResponseData(count, result, result != null);
    }

    private Map<String, Object> toEmployeeMap(Employee employee) {
        Map<String, Object> map = MyMapTool.getMap(employee);
        Department department = employee_Department_RelateDao.queryDepartmentByEmployee(employee);
        Job job = employee_Job_RelateDao.queryJobByEmployee(employee);

        if (department == null) {
            map.put("department", "");
            map.put("department_no", "");
        } else {
            map.put("department", department.getName());
            map.put("department_no", String.valueOf(department.getNo()));
        }

        if (job == null) {
            map.put("job", "");
            map.put("job_no", "");
        } else {
            map.put("job", job.getName());
            map.put("job_no", String.valueOf(job.getNo()));
        }

        return map;
    }

    @Override
    public Message addEmployee(Map<String, Object> map) {
        String jobNo = String.valueOf(map.get("job_no"));
        String departmentNo = String.valueOf(map.get("department_no"));

        if (employeeDao.addEmployee(map) != 0) {
            Integer employeeNo = toolDao.queryLastNo();

            Employee_Job_Relate employee_Job_Relate = new Employee_Job_Relate();
            employee_Job_Relate.setEmployee_no(employeeNo);
            employee_Job_Relate.setJob_no(Integer.valueOf(jobNo));
            employee_Job_RelateDao.addEmployee_Job_Relate(employee_Job_Relate);

            Employee_Department_Relate employee_Department_Relate = new Employee_Department_Relate();
            employee_Department_Relate.setEmployee_no(employeeNo);
            employee_Department_Relate.setDepartment_no(Integer.valueOf(departmentNo));
            employee_Department_RelateDao.addEmployee_Department_Relate(employee_Department_Relate);
            return Message.success;
        }

        return Message.fail;
    }

    @Override
    public Message deleteEmployees(List<Employee> employees) {
        for (Employee employee : employees) {
            employee_Department_RelateDao.deleteEmployee_Department_RelateByEmployee(employee);
            employee_Job_RelateDao.deleteEmployee_Job_RelateByEmployee(employee);
            employeeDao.deleteEmployee(employee);
        }
        return Message.success;
    }

    @Override
    public Message updateEmployee(Map<String, Object> map) {
        String jobNo = String.valueOf(map.get("job_no"));
        String departmentNo = String.valueOf(map.get("department_no"));
        String employeeNo = String.valueOf(map.get("no"));

        employeeDao.updateEmployee(map);

        Employee_Job_Relate employee_Job_Relate = new Employee_Job_Relate();
        employee_Job_Relate.setEmployee_no(Integer.valueOf(employeeNo));
        employee_Job_Relate.setJob_no(Integer.valueOf(jobNo));
        employee_Job_RelateDao.updateEmployee_Job_RelateJobNoByEmployee(employee_Job_Relate);

        Employee_Department_Relate employee_Department_Relate = new Employee_Department_Relate();
        employee_Department_Relate.setEmployee_no(Integer.valueOf(employeeNo));
        employee_Department_Relate.setDepartment_no(Integer.valueOf(departmentNo));
        employee_Department_RelateDao.updateEmployee_Department_RelateDepartmentNoByEmployee(employee_Department_Relate);

        return Message.success;
    }
}
