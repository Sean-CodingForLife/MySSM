<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="admin.users.title"/></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        window.I18N = {
            noRecords: "<spring:message code="common.noRecords"/>",
            previous: "<spring:message code="common.previous"/>",
            next: "<spring:message code="common.next"/>",
            selectRequired: "<spring:message code="common.selectRequired"/>",
            requestFailed: "<spring:message code="common.requestFailed"/>",
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
                alert("<spring:message code="auth.required.register"/>");
                return;
            }
            if (data.password.length < 8) {
                alert("<spring:message code="auth.password.min"/>");
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

            if (confirm("<spring:message code="admin.users.confirmDelete"/>")) {
                deleteRequest("${pageContext.request.contextPath}/api/admin/users", users, function () {
                    refreshUsers();
                });
            }
        }

        $(function () {
            refreshUsers();
        });
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title"><spring:message code="admin.users.title"/></h1>
            <p class="breadcrumb"><spring:message code="admin.users.breadcrumb"/></p>
        </div>
        <div class="page-actions">
            <nav class="language-switch">
                <a href="?lang=zh-CN"><spring:message code="language.zh"/></a>
                <a href="?lang=en-US"><spring:message code="language.en"/></a>
            </nav>
            <a class="button-link" href="${pageContext.request.contextPath}/dashboard"><spring:message code="common.back"/></a>
        </div>
    </header>

    <section class="toolbar">
        <div class="field grow">
            <label for="keyword"><spring:message code="common.keyword"/></label>
            <input type="text" id="keyword" placeholder="<spring:message code="admin.users.searchPlaceholder"/>" />
        </div>
        <div class="field">
            <label for="type"><spring:message code="common.searchBy"/></label>
            <select id="type">
                <option value=""><spring:message code="common.all"/></option>
                <option value="name"><spring:message code="common.name"/></option>
                <option value="role"><spring:message code="common.role"/></option>
                <option value="status"><spring:message code="common.status"/></option>
            </select>
        </div>
        <button type="button" onclick="searchUsers()"><spring:message code="common.search"/></button>
        <button type="button" onclick="state.params.keyword=''; state.params.type=''; $('#keyword').val(''); $('#type').val(''); searchUsers()"><spring:message code="common.reset"/></button>
    </section>

    <section class="table-panel">
        <table id="table" class="data-table">
            <thead>
            <tr>
                <th><input id="selectAll" type="checkbox" onclick="selectAll()" /></th>
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
        <div id="emptyState" class="empty-state"></div>
    </section>

    <section class="operationBar">
        <button class="danger" type="button" onclick="deleteUser()"><spring:message code="common.delete"/></button>
        <button class="primary" type="button" onclick="openPopBox()"><spring:message code="admin.users.add"/></button>
    </section>

    <ul class="pageBar"></ul>
</main>

<div class="fade"></div>
<section class="light">
    <h2 class="modal-header"><spring:message code="admin.users.add"/></h2>
    <form id="userForm" action="">
        <div class="form-grid">
            <div class="field">
                <label for="newAccount"><spring:message code="auth.account"/></label>
                <input type="text" id="newAccount" data-field="account" autocomplete="off" />
            </div>
            <div class="field">
                <label for="newName"><spring:message code="auth.name"/></label>
                <input type="text" id="newName" data-field="name" />
            </div>
            <div class="field">
                <label for="newPassword"><spring:message code="auth.password"/></label>
                <input type="password" id="newPassword" data-field="password" autocomplete="new-password" />
            </div>
            <div class="field">
                <label for="newRole"><spring:message code="common.role"/></label>
                <select id="newRole" data-field="role">
                    <option value="USER"><spring:message code="role.user"/></option>
                    <option value="ADMIN"><spring:message code="role.admin"/></option>
                </select>
            </div>
        </div>
        <div class="modal-actions">
            <button type="button" onclick="closePopBox()"><spring:message code="common.cancel"/></button>
            <button class="primary" type="button" onclick="addUser()"><spring:message code="common.submit"/></button>
        </div>
    </form>
</section>
</body>
</html>
