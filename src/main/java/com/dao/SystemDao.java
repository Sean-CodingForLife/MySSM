package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.po.Menu;
import com.po.Permission;
import com.po.Role;
import com.po.LoginLog;
import com.po.OperationLog;
import com.po.SysConfig;

public interface SystemDao {
    public Integer queryRolesCount(@Param("keyword") String keyword);

    public List<Role> queryRoles(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);

    public Role queryRoleByCode(@Param("code") String code);

    public Integer addRole(Role role);

    public Integer deleteRole(Role role);

    public List<Role> queryAllRoles();

    public Integer deleteRolePermissions(@Param("roleId") Integer roleId);

    public Integer assignRolePermission(@Param("roleId") Integer roleId, @Param("permissionId") Integer permissionId);

    public List<Permission> queryPermissionsByRoleId(@Param("roleId") Integer roleId);

    public Integer queryMenusCount(@Param("keyword") String keyword);

    public List<Menu> queryMenus(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);

    public List<Menu> queryAllMenus();

    public List<Menu> queryMenusByUserId(@Param("userId") Integer userId);

    public Integer queryPermissionsCount(@Param("keyword") String keyword);

    public List<Permission> queryPermissions(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);

    public List<Permission> queryAllPermissions();

    public List<Permission> queryPermissionsByUserId(@Param("userId") Integer userId);

    public Permission queryPermissionByRequest(@Param("method") String method, @Param("path") String path);

    public Integer addLoginLog(LoginLog log);

    public Integer addOperationLog(OperationLog log);

    public Integer queryLoginLogsCount(@Param("keyword") String keyword);

    public List<LoginLog> queryLoginLogs(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);

    public Integer queryOperationLogsCount(@Param("keyword") String keyword);

    public List<OperationLog> queryOperationLogs(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);

    public Integer queryConfigsCount(@Param("keyword") String keyword);

    public List<SysConfig> queryConfigs(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);
}
