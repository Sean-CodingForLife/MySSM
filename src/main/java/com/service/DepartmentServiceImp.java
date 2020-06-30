package com.service;

import java.util.List;

import com.po.Department;
import com.reponseData.ResponseData;
import com.dao.DepartmentDao;
import com.dao.Employee_Department_RelateDao;
import com.message.Message;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("DepartmentService")
@Transactional
public class DepartmentServiceImp implements DepartmentService {

    @Autowired
    DepartmentDao departmentDao;

    @Autowired
    Employee_Department_RelateDao employee_Department_RelateDao;

    @Override
    public ResponseData queryDepartments(String keyword, Integer startPage, Integer offset) {

        Integer count = 0;
        List<Department> departments = null;

        if (keyword == "" && (startPage == null || offset == null)) {
            count = departmentDao.queryDepartmentsCount();
            if (count != 0) {
                departments = departmentDao.queryAllDepartment();
            }
        } else {

            Integer start = (startPage - 1) * offset;
            Integer end = offset;

            switch (keyword) {
                case "":
                    count = departmentDao.queryDepartmentsCount();
                    if (count != 0) {
                        departments = departmentDao.queryDepartments();
                    }
                    break;
                default:
                    count = departmentDao.queryDepartmentsCountByName(keyword);
                    if (count != 0) {
                        departments = departmentDao.queryDepartmentsByName(keyword, start, end);
                    }
                    break;
            }
        }

        return new ResponseData(count, departments, (departments != null));
    }

    @Override
    public Message deleteDepartments(List<Department> departments) {

        for (Department department : departments) {
            if ((employee_Department_RelateDao.deleteEmployee_Department_RelatesByDepartment(department) == 0)
                    || (departmentDao.deleteDepartment(department) == 0)) {
                return Message.fail;
            }
        }
        return Message.success;
    }

    @Override
    public Message addDepartment(Department department) {
        if (departmentDao.addDepartment(department) != 0) {
            return Message.success;
        }
        return Message.fail;

    }

    @Override
    public Message updateDepartment(Department department) {

        if (departmentDao.updateDepartment(department) != 0) {
            return Message.success;
        }
        return Message.fail;
    }

}