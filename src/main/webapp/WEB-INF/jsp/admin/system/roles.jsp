<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="admin.roles.title"/></title>
    <%@ include file="../../common/assets.jsp" %>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        window.I18N = {
            noRecords: "<spring:message code="common.noRecords"/>",
            previous: "<spring:message code="common.previous"/>",
            next: "<spring:message code="common.next"/>",
            selectRequired: "<spring:message code="common.selectRequired"/>",
            requestFailed: "<spring:message code="common.requestFailed"/>",
            confirmTitle: "<spring:message code="common.confirm"/>",
            cancel: "<spring:message code="common.cancel"/>",
            confirm: "<spring:message code="common.confirm"/>",
            loading: "<spring:message code="common.loading"/>",
            statuses: {
                ACTIVE: "<spring:message code="status.ACTIVE"/>",
                DISABLED: "<spring:message code="status.DISABLED"/>"
            }
        };

        var activeRoleId = null;

        var state = createListState("${pageContext.request.contextPath}/api/admin/roles", 10, {
            keyword: ""
        });

        var columns = [
            { key: "id", label: "<spring:message code="common.id"/>" },
            { key: "code", label: "<spring:message code="common.code"/>" },
            { key: "name", label: "<spring:message code="common.name"/>" },
            { key: "status", label: "<spring:message code="common.status"/>" },
            { key: "created_date", label: "<spring:message code="common.createdAt"/>" }
        ];

        function refreshRoles() {
            loadTable(state, columns, {
                emptyText: "<spring:message code="admin.roles.empty"/>",
                actions: function (row) {
                    var button = document.createElement("button");
                    button.className = "btn btn-outline-primary btn-sm";
                    button.type = "button";
                    button.textContent = "<spring:message code="admin.roles.permissions"/>";
                    button.onclick = function () {
                        openPermissionModal(row.id);
                    };
                    return button;
                }
            });
        }

        function searchRoles() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            refreshRoles();
        }

        function addRole() {
            var data = formData("#roleForm");
            if (!data.code || !data.name) {
                notifyApp("<spring:message code="admin.roles.required"/>", "error");
                return;
            }
            postRequest("${pageContext.request.contextPath}/api/admin/roles", data, function () {
                closePopBox("roleModal");
                clearForm("#roleForm");
                refreshRoles();
            });
        }

        function deleteRole() {
            var roles = getSelectedCheckbox(document.getElementsByName("selectOne"));
            if (!requireSelection(roles, "<spring:message code="common.role"/>")) {
                return;
            }
            confirmApp("<spring:message code="admin.roles.confirmDelete"/>", function () {
                deleteRequest("${pageContext.request.contextPath}/api/admin/roles", roles, function () {
                    refreshRoles();
                });
            });
        }

        function openPermissionModal(roleId) {
            activeRoleId = roleId;
            $("#permissionList").empty();
            getJson("${pageContext.request.contextPath}/api/admin/permissions?keyword=&startPage=1&offset=1000", function (data) {
                var permissions = data.body || [];
                getJson("${pageContext.request.contextPath}/api/admin/roles/permissions?roleId=" + roleId, function (owned) {
                    var ownedMap = {};
                    (owned || []).forEach(function (permission) {
                        ownedMap[permission.id] = true;
                    });
                    permissions.forEach(function (permission) {
                        var item = $('<label class="list-group-item d-flex align-items-start gap-2"></label>');
                        var checkbox = $('<input class="form-check-input mt-1" type="checkbox" name="permissionIds" />');
                        checkbox.val(permission.id);
                        checkbox.prop("checked", !!ownedMap[permission.id]);
                        item.append(checkbox);
                        item.append($('<span></span>').text(permission.code + " - " + permission.name));
                        $("#permissionList").append(item);
                    });
                    openPopBox("permissionModal");
                });
            });
        }

        function saveRolePermissions() {
            var permissionIds = [];
            $("input[name='permissionIds']:checked").each(function () {
                permissionIds.push(parseInt($(this).val(), 10));
            });
            postRequest("${pageContext.request.contextPath}/api/admin/roles/permissions?roleId=" + activeRoleId, permissionIds, function () {
                closePopBox("permissionModal");
            });
        }

        $(function () {
            refreshRoles();
        });
    </script>
</head>
<body>
<spring:message code="admin.roles.title" var="pageTitle"/>
<% request.setAttribute("activeNav", "roles"); %>
<%@ include file="../../common/app-shell-start.jsp" %>
    <header class="content-header">
        <div>
            <h1><spring:message code="admin.roles.title"/></h1>
            <p><spring:message code="admin.roles.breadcrumb"/></p>
        </div>
        <button class="btn btn-primary" type="button" onclick="openPopBox('roleModal')"><spring:message code="admin.roles.add"/></button>
    </header>

    <section class="card mb-3">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-12 col-md">
                    <label class="form-label" for="keyword"><spring:message code="common.keyword"/></label>
                    <input class="form-control" type="text" id="keyword" placeholder="<spring:message code="admin.roles.searchPlaceholder"/>" />
                </div>
                <div class="col-12 col-md-auto d-flex gap-2">
                    <button class="btn btn-primary" type="button" onclick="searchRoles()"><spring:message code="common.search"/></button>
                    <button class="btn btn-outline-secondary" type="button" onclick="state.params.keyword=''; $('#keyword').val(''); searchRoles()"><spring:message code="common.reset"/></button>
                </div>
            </div>
        </div>
    </section>

    <section class="card table-panel">
        <div class="table-responsive">
            <table id="table" class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th><input id="selectAll" class="form-check-input" type="checkbox" onclick="selectAll()" /></th>
                    <th><spring:message code="common.id"/></th>
                    <th><spring:message code="common.code"/></th>
                    <th><spring:message code="common.name"/></th>
                    <th><spring:message code="common.status"/></th>
                    <th><spring:message code="common.createdAt"/></th>
                    <th><spring:message code="common.operation"/></th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div id="emptyState" class="empty-state border-top"></div>
    </section>

    <section class="d-flex flex-wrap justify-content-between align-items-center gap-3 mt-3">
        <button class="btn btn-outline-danger" type="button" onclick="deleteRole()"><spring:message code="common.delete"/></button>
        <ul class="pagination pageBar mb-0"></ul>
    </section>
<%@ include file="../../common/app-shell-end.jsp" %>

<div class="modal fade" id="roleModal" tabindex="-1" aria-labelledby="roleModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title fs-5" id="roleModalTitle"><spring:message code="admin.roles.add"/></h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="<spring:message code="common.cancel"/>"></button>
            </div>
            <div class="modal-body">
                <form id="roleForm" action="">
                    <div class="mb-3">
                        <label class="form-label" for="newCode"><spring:message code="common.code"/></label>
                        <input class="form-control" type="text" id="newCode" data-field="code" autocomplete="off" />
                    </div>
                    <div>
                        <label class="form-label" for="newName"><spring:message code="common.name"/></label>
                        <input class="form-control" type="text" id="newName" data-field="name" />
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal"><spring:message code="common.cancel"/></button>
                <button class="btn btn-primary" type="button" onclick="addRole()"><spring:message code="common.submit"/></button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="permissionModal" tabindex="-1" aria-labelledby="permissionModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title fs-5" id="permissionModalTitle"><spring:message code="admin.roles.permissions"/></h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="<spring:message code="common.cancel"/>"></button>
            </div>
            <div class="modal-body">
                <div id="permissionList" class="list-group permission-list"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal"><spring:message code="common.cancel"/></button>
                <button class="btn btn-primary" type="button" onclick="saveRolePermissions()"><spring:message code="common.submit"/></button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
