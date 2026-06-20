package com.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.SystemDao;
import com.message.Message;
import com.po.Menu;
import com.po.Permission;
import com.po.Role;
import com.po.LoginLog;
import com.po.OperationLog;
import com.responseData.ResponseData;

@Service("SystemService")
@Transactional
public class SystemServiceImp implements SystemService {

    private static final Logger LOGGER = LoggerFactory.getLogger(SystemServiceImp.class);

    @Autowired
    private SystemDao systemDao;

    @Override
    public ResponseData queryRoles(String keyword, Integer startPage, Integer offset) {
        String text = keyword == null ? "" : keyword;
        Integer start = (startPage - 1) * offset;
        Integer count = systemDao.queryRolesCount(text);
        List<Role> roles = count == 0 ? null : systemDao.queryRoles(text, start, offset);
        return new ResponseData(count, roles, roles != null);
    }

    @Override
    public Message addRole(Role role) {
        if (role == null || isBlank(role.getCode()) || isBlank(role.getName())) {
            return Message.fail;
        }
        role.setCode(role.getCode().trim().toUpperCase());
        if (systemDao.queryRoleByCode(role.getCode()) != null) {
            return Message.fail;
        }
        return systemDao.addRole(role) == 1 ? Message.success : Message.fail;
    }

    @Override
    public Message deleteRoles(List<Role> roles) {
        for (Role role : roles) {
            if (systemDao.deleteRole(role) == 0) {
                return Message.fail;
            }
        }
        return Message.success;
    }

    @Override
    public Message saveRolePermissions(Integer roleId, List<Integer> permissionIds) {
        if (roleId == null) {
            return Message.fail;
        }
        systemDao.deleteRolePermissions(roleId);
        if (permissionIds != null) {
            for (Integer permissionId : permissionIds) {
                systemDao.assignRolePermission(roleId, permissionId);
            }
        }
        return Message.success;
    }

    @Override
    public ResponseData queryMenus(String keyword, Integer startPage, Integer offset) {
        String text = keyword == null ? "" : keyword;
        Integer start = (startPage - 1) * offset;
        Integer count = systemDao.queryMenusCount(text);
        List<Menu> menus = count == 0 ? null : systemDao.queryMenus(text, start, offset);
        return new ResponseData(count, menus, menus != null);
    }

    @Override
    public ResponseData queryPermissions(String keyword, Integer startPage, Integer offset) {
        String text = keyword == null ? "" : keyword;
        Integer start = (startPage - 1) * offset;
        Integer count = systemDao.queryPermissionsCount(text);
        List<Permission> permissions = count == 0 ? null : systemDao.queryPermissions(text, start, offset);
        return new ResponseData(count, permissions, permissions != null);
    }

    @Override
    public List<Role> queryAllRoles() {
        return systemDao.queryAllRoles();
    }

    @Override
    public List<Menu> queryMenusByUserId(Integer userId) {
        return systemDao.queryMenusByUserId(userId);
    }

    @Override
    public List<Permission> queryPermissionsByUserId(Integer userId) {
        return systemDao.queryPermissionsByUserId(userId);
    }

    @Override
    public List<Permission> queryPermissionsByRoleId(Integer roleId) {
        return systemDao.queryPermissionsByRoleId(roleId);
    }

    @Override
    public Message addLoginLog(LoginLog log) {
        try {
            return systemDao.addLoginLog(log) == 1 ? Message.success : Message.fail;
        } catch (RuntimeException e) {
            LOGGER.warn("Failed to save login log.", e);
            return Message.fail;
        }
    }

    @Override
    public Message addOperationLog(OperationLog log) {
        try {
            return systemDao.addOperationLog(log) == 1 ? Message.success : Message.fail;
        } catch (RuntimeException e) {
            LOGGER.warn("Failed to save operation log.", e);
            return Message.fail;
        }
    }

    @Override
    public ResponseData queryLoginLogs(String keyword, Integer startPage, Integer offset) {
        String text = keyword == null ? "" : keyword;
        Integer start = (startPage - 1) * offset;
        Integer count = systemDao.queryLoginLogsCount(text);
        List<LoginLog> logs = count == 0 ? null : systemDao.queryLoginLogs(text, start, offset);
        return new ResponseData(count, logs, logs != null);
    }

    @Override
    public ResponseData queryOperationLogs(String keyword, Integer startPage, Integer offset) {
        String text = keyword == null ? "" : keyword;
        Integer start = (startPage - 1) * offset;
        Integer count = systemDao.queryOperationLogsCount(text);
        List<OperationLog> logs = count == 0 ? null : systemDao.queryOperationLogs(text, start, offset);
        return new ResponseData(count, logs, logs != null);
    }

    @Override
    public ResponseData queryConfigs(String keyword, Integer startPage, Integer offset) {
        String text = keyword == null ? "" : keyword;
        Integer start = (startPage - 1) * offset;
        Integer count = systemDao.queryConfigsCount(text);
        List<com.po.SysConfig> configs = count == 0 ? null : systemDao.queryConfigs(text, start, offset);
        return new ResponseData(count, configs, configs != null);
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().equals("");
    }
}
