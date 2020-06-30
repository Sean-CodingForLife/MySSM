package com.service;

import java.util.List;

import com.dao.Employee_Job_RelateDao;
import com.dao.JobDao;
import com.dao.ToolDao;
import com.message.Message;
import com.po.Job;
import com.reponseData.ResponseData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("JobrService")
@Transactional
public class JobServiceImp implements JobService {

    @Autowired
    JobDao jobDao;

    @Autowired
    Employee_Job_RelateDao employee_job_RelateDao;

    @Autowired
    ToolDao toolDao;

    @Override
    public ResponseData queryJobs(String keyword, Integer startPage, Integer offset) {

        Integer count = 0;
        List<Job> jobs = null;

        if (keyword == "" && (startPage == null || offset == null)) {
            count = jobDao.queryJobsCount();
            if (count != 0) {
                jobs = jobDao.queryAllJob();
            }
        } else {

            Integer start = (startPage - 1) * offset;
            Integer end = offset;

            switch (keyword) {
                case "":
                    count = jobDao.queryJobsCount();
                    if (count != 0) {
                        jobs = jobDao.queryJobs(start, end);
                    }
                    break;
                default:
                    count = jobDao.queryJobsCountByName(keyword);
                    if (count != 0) {
                        jobs = jobDao.queryJobsByName(keyword, start, end);
                    }
                    break;
            }
        }
        return new ResponseData(count, jobs, jobs != null);
    }

    @Override
    public Message addJob(Job job) {
        if (jobDao.addJob(job) != 0) {
            return Message.success;
        }
        return Message.fail;
    }

    @Override
    public Message deleteJobs(List<Job> jobs) {
        for (Job job : jobs) {
            if ((employee_job_RelateDao.deleteEmployee_Job_RelatesByJob(job) == 0) || (jobDao.deleteJob(job) == 0)) {
                return Message.fail;
            }
        }
        return Message.success;
    }

    @Override
    public Message updateJob(Job job) {
        if (jobDao.updateJob(job) != 0) {
            return Message.success;
        }
        return Message.fail;
    }
}