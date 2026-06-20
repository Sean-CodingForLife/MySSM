package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.message.Message;
import com.po.Permission;
import com.po.Role;
import com.responseData.ResponseData;
import com.service.SystemService;

@Controller
public class SystemController extends BaseController {

    @Autowired
    private SystemService systemService;

    @GetMapping("/admin/roles")
    public String toRolesPage() {
        return "admin/system/roles";
    }

    @GetMapping("/admin/menus")
    public String toMenusPage() {
        return "admin/system/menus";
    }

    @GetMapping("/admin/permissions")
    public String toPermissionsPage() {
        return "admin/system/permissions";
    }

    @GetMapping("/admin/login-logs")
    public String toLoginLogsPage() {
        return "admin/system/login-logs";
    }

    @GetMapping("/admin/operation-logs")
    public String toOperationLogsPage() {
        return "admin/system/operation-logs";
    }

    @GetMapping("/admin/configs")
    public String toConfigsPage() {
        return "admin/system/configs";
    }

    @GetMapping("/api/admin/roles")
    @ResponseBody
    public ResponseData queryRoles(@RequestParam String keyword, @RequestParam Integer startPage,
            @RequestParam Integer offset) {
        return systemService.queryRoles(keyword, startPage, offset);
    }

    @PostMapping("/api/admin/roles")
    @ResponseBody
    public Message addRole(@RequestBody Role role) {
        return systemService.addRole(role);
    }

    @DeleteMapping("/api/admin/roles")
    @ResponseBody
    public Message deleteRoles(@RequestBody List<Role> roles) {
        return systemService.deleteRoles(roles);
    }

    @GetMapping("/api/admin/roles/permissions")
    @ResponseBody
    public List<Permission> queryRolePermissions(@RequestParam Integer roleId) {
        return systemService.queryPermissionsByRoleId(roleId);
    }

    @PostMapping("/api/admin/roles/permissions")
    @ResponseBody
    public Message saveRolePermissions(@RequestParam Integer roleId, @RequestBody List<Integer> permissionIds) {
        return systemService.saveRolePermissions(roleId, permissionIds);
    }

    @GetMapping("/api/admin/menus")
    @ResponseBody
    public ResponseData queryMenus(@RequestParam String keyword, @RequestParam Integer startPage,
            @RequestParam Integer offset) {
        return systemService.queryMenus(keyword, startPage, offset);
    }

    @GetMapping("/api/admin/permissions")
    @ResponseBody
    public ResponseData queryPermissions(@RequestParam String keyword, @RequestParam Integer startPage,
            @RequestParam Integer offset) {
        return systemService.queryPermissions(keyword, startPage, offset);
    }

    @GetMapping("/api/admin/login-logs")
    @ResponseBody
    public ResponseData queryLoginLogs(@RequestParam String keyword, @RequestParam Integer startPage,
            @RequestParam Integer offset) {
        return systemService.queryLoginLogs(keyword, startPage, offset);
    }

    @GetMapping("/api/admin/operation-logs")
    @ResponseBody
    public ResponseData queryOperationLogs(@RequestParam String keyword, @RequestParam Integer startPage,
            @RequestParam Integer offset) {
        return systemService.queryOperationLogs(keyword, startPage, offset);
    }

    @GetMapping("/api/admin/configs")
    @ResponseBody
    public ResponseData queryConfigs(@RequestParam String keyword, @RequestParam Integer startPage,
            @RequestParam Integer offset) {
        return systemService.queryConfigs(keyword, startPage, offset);
    }
}
