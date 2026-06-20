package com.service;

import java.util.List;

import com.message.Message;
import com.po.Menu;
import com.po.Permission;
import com.po.Role;
import com.po.LoginLog;
import com.po.OperationLog;
import com.responseData.ResponseData;

public interface SystemService {
    public ResponseData queryRoles(String keyword, Integer startPage, Integer offset);

    public Message addRole(Role role);

    public Message deleteRoles(List<Role> roles);

    public Message saveRolePermissions(Integer roleId, List<Integer> permissionIds);

    public ResponseData queryMenus(String keyword, Integer startPage, Integer offset);

    public ResponseData queryPermissions(String keyword, Integer startPage, Integer offset);

    public List<Role> queryAllRoles();

    public List<Menu> queryMenusByUserId(Integer userId);

    public List<Permission> queryPermissionsByUserId(Integer userId);

    public List<Permission> queryPermissionsByRoleId(Integer roleId);

    public Message addLoginLog(LoginLog log);

    public Message addOperationLog(OperationLog log);

    public ResponseData queryLoginLogs(String keyword, Integer startPage, Integer offset);

    public ResponseData queryOperationLogs(String keyword, Integer startPage, Integer offset);

    public ResponseData queryConfigs(String keyword, Integer startPage, Integer offset);
}
