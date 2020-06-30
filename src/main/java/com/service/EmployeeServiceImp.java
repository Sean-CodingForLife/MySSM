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
import com.reponseData.ResponseData;

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
        List<Map<String, Object>> employeeWithJobAndDepartmentList = null;
        Department department = null;
        Job job = null;
        switch (type) {
            default:
                count = employeeDao.queryEmployeesCount();
                if (count != 0) {
                    employees = employeeDao.queryEmployees(start, end);
                    employeeWithJobAndDepartmentList = new ArrayList<Map<String, Object>>();
                    for (Employee employee : employees) {
                        job = employee_Job_RelateDao.queryJobByEmployee(employee);
                        department = employee_Department_RelateDao.queryDepartmentByEmployee(employee);
                        Map<String, Object> map = MyMapTool.getMap(employee);
                        if (department == null) {
                            map.put("department", "null");
                        } else {
                            map.put("department", department.getName());
                        } if (job == null) {
                            map.put("job", "null");
                        } else {
                            map.put("job", job.getName());
                        } employeeWithJobAndDepartmentList.add(map);
                    }
                }
                break;
            case "name":
                count = employeeDao.queryEmployeesCountByName(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesByName(keyword, start, end);
                    employeeWithJobAndDepartmentList = new ArrayList<Map<String, Object>>();
                    for (Employee employee : employees) {
                        job = employee_Job_RelateDao.queryJobByEmployee(employee);
                        department = employee_Department_RelateDao.queryDepartmentByEmployee(employee);
                        Map<String, Object> map = MyMapTool.getMap(employee);
                        if (department == null) {
                            map.put("department", "null");
                        } else {
                            map.put("department", department.getName());
                        }
                        if (job == null) {
                            map.put("job", "null");
                        } else {
                            map.put("job", job.getName());
                        }
                        employeeWithJobAndDepartmentList.add(map);
                    }
                }
                break;
            case "id":
                count = employeeDao.queryEmployeesCountById(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesById(keyword, start, end);
                    employeeWithJobAndDepartmentList = new ArrayList<Map<String, Object>>();
                    for (Employee employee : employees) {
                        job = employee_Job_RelateDao.queryJobByEmployee(employee);
                        department = employee_Department_RelateDao.queryDepartmentByEmployee(employee);
                        Map<String, Object> map = MyMapTool.getMap(employee);
                        if (department == null) {
                            map.put("department", "null");
                        } else {
                            map.put("department", department.getName());
                        }
                        if (job == null) {
                            map.put("job", "null");
                        } else {
                            map.put("job", job.getName());
                        }
                        employeeWithJobAndDepartmentList.add(map);
                    }
                }
                break;
            case "phone":
                count = employeeDao.queryEmployeesCountByPhone(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesByPhone(keyword, start, end);
                    employeeWithJobAndDepartmentList = new ArrayList<Map<String, Object>>();
                    for (Employee employee : employees) {
                        job = employee_Job_RelateDao.queryJobByEmployee(employee);
                        department = employee_Department_RelateDao.queryDepartmentByEmployee(employee);
                        Map<String, Object> map = MyMapTool.getMap(employee);
                        if (department == null) {
                            map.put("department", "null");
                        } else {
                            map.put("department", department.getName());
                        }
                        if (job == null) {
                            map.put("job", "null");
                        } else {
                            map.put("job", job.getName());
                        }
                        employeeWithJobAndDepartmentList.add(map);
                    }
                }
                break;
            case "sex":
                count = employeeDao.queryEmployeesCountBySex(keyword);
                if (count != 0) {
                    employees = employeeDao.queryEmployeesBySex(keyword, start, end);
                    employeeWithJobAndDepartmentList = new ArrayList<Map<String, Object>>();
                    for (Employee employee : employees) {
                        job = employee_Job_RelateDao.queryJobByEmployee(employee);
                        department = employee_Department_RelateDao.queryDepartmentByEmployee(employee);
                        Map<String, Object> map = MyMapTool.getMap(employee);
                        if (department == null) {
                            map.put("department", "null");
                        } else {
                            map.put("department", department.getName());
                        }
                        if (job == null) {
                            map.put("job", "null");
                        } else {
                            map.put("job", job.getName());
                        }
                        employeeWithJobAndDepartmentList.add(map);
                    }
                }
                break;
            case "job":
                job = jobDao.queryJobByName(keyword);
                if (job != null) {
                    employeeWithJobAndDepartmentList = new ArrayList<Map<String, Object>>();
                    List<Employee_Job_Relate> employee_Job_Relates = employee_Job_RelateDao
                            .queryEmployee_Job_RelatesByJob(job, start, end);
                    for (Employee_Job_Relate employee_Job_Relate : employee_Job_Relates) {
                        Employee employee = employeeDao.queryEmployeeByNo(employee_Job_Relate.getEmployee_no());
                        department = employee_Department_RelateDao.queryDepartmentByEmployee(employee);
                        Map<String, Object> map = MyMapTool.getMap(employee);
                        if (department == null) {
                            map.put("department", "null");
                        } else {
                            map.put("department", department.getName());
                        }
                        map.put("job", keyword);
                        employeeWithJobAndDepartmentList.add(map);
                    }
                }
                break;
            case "department":
                department = departmentDao.queryDepartmentByName(keyword);
                if (department != null) {
                    employeeWithJobAndDepartmentList = new ArrayList<Map<String, Object>>();
                    List<Employee_Department_Relate> employee_Department_Relates = employee_Department_RelateDao
                            .queryEmployee_Department_RelatesByDepartment(department, start, end);
                    for (Employee_Department_Relate employee_Department_Relate : employee_Department_Relates) {
                        Employee employee = employeeDao.queryEmployeeByNo(employee_Department_Relate.getEmployee_no());
                        job = employee_Job_RelateDao.queryJobByEmployee(employee);
                        Map<String, Object> map = MyMapTool.getMap(employee);
                        map.put("department", keyword);
                        if (job == null) {
                            map.put("job", "null");
                        } else {
                            map.put("job", job.getName());
                        }
                        employeeWithJobAndDepartmentList.add(map);
                    }
                }
                break;
        }

        return new ResponseData(count, employeeWithJobAndDepartmentList, employeeWithJobAndDepartmentList != null);
    }

    @Override
    public Message addEmloyee(Map<String, Object> map) {

        String jobNo = (String) map.get("job_no");
        String departmentNo = (String) map.get("department_no");

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
        } else {
            return Message.fail;
        }
    }

    @Override
    public Message deleteEmployees(List<Employee> employees) {

        for (Employee employee : employees) {
            System.out.println(employee_Department_RelateDao.deleteEmployee_Department_RelateByEmployee(employee));
            System.out.println(employee_Job_RelateDao.deleteEmployee_Job_RelateByEmployee(employee));
            System.out.println(employeeDao.deleteEmployee(employee));
        } return Message.success;
    }

    @Override
    public Message updateEmployee(Map<String, Object> map) {

        String job_no = (String) map.get("job_no");
        String department_no = (String) map.get("department_no");
        String employee_no = (String) map.get("no");

        employeeDao.updateEmployee(map);

        Employee_Job_Relate employee_Job_Relate = new Employee_Job_Relate();
        employee_Job_Relate.setEmployee_no(Integer.valueOf(employee_no));
        employee_Job_Relate.setJob_no(Integer.valueOf(job_no));
        employee_Job_RelateDao.updateEmployee_Job_RelateJobNoByEmployee(employee_Job_Relate);

        Employee_Department_Relate employee_Department_Relate = new Employee_Department_Relate();
        employee_Department_Relate.setEmployee_no(Integer.valueOf(employee_no));
        employee_Department_Relate.setDepartment_no(Integer.valueOf(department_no));
        employee_Department_RelateDao.updateEmployee_Department_RelateDepartmentNoByEmployee(employee_Department_Relate);

        return Message.success;
    }

}