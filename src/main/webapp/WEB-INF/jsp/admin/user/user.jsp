<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="admin.users.title"/></title>
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
            },
            roles: {
                ADMIN: "<spring:message code="role.admin"/>",
                USER: "<spring:message code="role.user"/>"
            }
        };

        var state = createListState("${pageContext.request.contextPath}/api/admin/users", 10, {
            keyword: "",
            type: ""
        });

        var columns = [
            { key: "id", label: "<spring:message code="common.id"/>" },
            { key: "account", label: "<spring:message code="common.account"/>" },
            { key: "name", label: "<spring:message code="common.name"/>" },
            { key: "role", label: "<spring:message code="common.role"/>" },
            { key: "status", label: "<spring:message code="common.status"/>" },
            { key: "created_date", label: "<spring:message code="common.createdAt"/>" }
        ];

        function refreshUsers() {
            loadTable(state, columns, { emptyText: "<spring:message code="admin.users.empty"/>" });
        }

        function searchUsers() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            state.params.type = $("#type").val();
            refreshUsers();
        }

        function addUser() {
            var data = formData("#userForm");
            if (!data.account || !data.name || !data.password || !data.role) {
                notifyApp("<spring:message code="auth.required.register"/>", "error");
                return;
            }
            if (data.password.length < 8) {
                notifyApp("<spring:message code="auth.password.min"/>", "error");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/admin/users", data, function () {
                closePopBox();
                clearForm("#userForm");
                refreshUsers();
            });
        }

        function deleteUser() {
            var users = getSelectedCheckbox(document.getElementsByName("selectOne"));
            if (!requireSelection(users, "<spring:message code="common.user"/>")) {
                return;
            }

            confirmApp("<spring:message code="admin.users.confirmDelete"/>", function () {
                deleteRequest("${pageContext.request.contextPath}/api/admin/users", users, function () {
                    refreshUsers();
                });
            });
        }

        $(function () {
            refreshUsers();
        });
    </script>
</head>
<body>
<spring:message code="admin.users.title" var="pageTitle"/>
<% request.setAttribute("activeNav", "users"); %>
<%@ include file="../../common/app-shell-start.jsp" %>
    <header class="content-header">
        <div>
            <h1><spring:message code="admin.users.title"/></h1>
            <p><spring:message code="admin.users.breadcrumb"/></p>
        </div>
        <button class="btn btn-primary" type="button" onclick="openPopBox()"><spring:message code="admin.users.add"/></button>
    </header>

    <section class="card mb-3">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-12 col-md">
                    <label class="form-label" for="keyword"><spring:message code="common.keyword"/></label>
                    <input class="form-control" type="text" id="keyword" placeholder="<spring:message code="admin.users.searchPlaceholder"/>" />
                </div>
                <div class="col-12 col-md-3">
                    <label class="form-label" for="type"><spring:message code="common.searchBy"/></label>
                    <select class="form-select" id="type">
                        <option value=""><spring:message code="common.all"/></option>
                        <option value="name"><spring:message code="common.name"/></option>
                        <option value="role"><spring:message code="common.role"/></option>
                        <option value="status"><spring:message code="common.status"/></option>
                    </select>
                </div>
                <div class="col-12 col-md-auto d-flex gap-2">
                    <button class="btn btn-primary" type="button" onclick="searchUsers()"><spring:message code="common.search"/></button>
                    <button class="btn btn-outline-secondary" type="button" onclick="state.params.keyword=''; state.params.type=''; $('#keyword').val(''); $('#type').val(''); searchUsers()"><spring:message code="common.reset"/></button>
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
                    <th><spring:message code="common.account"/></th>
                    <th><spring:message code="common.name"/></th>
                    <th><spring:message code="common.role"/></th>
                    <th><spring:message code="common.status"/></th>
                    <th><spring:message code="common.createdAt"/></th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div id="emptyState" class="empty-state border-top"></div>
    </section>

    <section class="d-flex flex-wrap justify-content-between align-items-center gap-3 mt-3">
        <div class="d-flex gap-2">
            <button class="btn btn-outline-danger" type="button" onclick="deleteUser()"><spring:message code="common.delete"/></button>
        </div>
        <ul class="pagination pageBar mb-0"></ul>
    </section>
<%@ include file="../../common/app-shell-end.jsp" %>

<div class="modal fade" id="userModal" tabindex="-1" aria-labelledby="userModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title fs-5" id="userModalTitle"><spring:message code="admin.users.add"/></h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="<spring:message code="common.cancel"/>"></button>
            </div>
            <div class="modal-body">
                <form id="userForm" action="">
                    <div class="row g-3">
                        <div class="col-12 col-md-6">
                            <label class="form-label" for="newAccount"><spring:message code="auth.account"/></label>
                            <input class="form-control" type="text" id="newAccount" data-field="account" autocomplete="off" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label" for="newName"><spring:message code="auth.name"/></label>
                            <input class="form-control" type="text" id="newName" data-field="name" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label" for="newPassword"><spring:message code="auth.password"/></label>
                            <input class="form-control" type="password" id="newPassword" data-field="password" autocomplete="new-password" />
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label" for="newRole"><spring:message code="common.role"/></label>
                            <select class="form-select" id="newRole" data-field="role">
                                <option value="USER"><spring:message code="role.user"/></option>
                                <option value="ADMIN"><spring:message code="role.admin"/></option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal"><spring:message code="common.cancel"/></button>
                <button class="btn btn-primary" type="button" onclick="addUser()"><spring:message code="common.submit"/></button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
