<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>User Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        var state = createListState("${pageContext.request.contextPath}/api/admin/users", 10, {
            keyword: "",
            type: ""
        });

        var columns = [
            { key: "no", label: "No." },
            { key: "account", label: "Account" },
            { key: "name", label: "Name" },
            { key: "status", label: "Status" },
            { key: "created_date", label: "Created At" }
        ];

        function refreshUsers() {
            loadTable(state, columns, { emptyText: "No users found." });
        }

        function searchUsers() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            state.params.type = $("#type").val();
            refreshUsers();
        }

        function deleteUser() {
            var users = getSelectedCheckbox(document.getElementsByName("selectOne"));
            if (!requireSelection(users, "user")) {
                return;
            }

            if (confirm("Delete selected users?")) {
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
            <h1 class="page-title">User Management</h1>
            <p class="breadcrumb">Admin Console / Users</p>
        </div>
        <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
    </header>

    <section class="toolbar">
        <div class="field grow">
            <label for="keyword">Keyword</label>
            <input type="text" id="keyword" placeholder="Search users" />
        </div>
        <div class="field">
            <label for="type">Search By</label>
            <select id="type">
                <option value="">All</option>
                <option value="name">Name</option>
                <option value="status">Status</option>
            </select>
        </div>
        <button type="button" onclick="searchUsers()">Search</button>
        <button type="button" onclick="state.params.keyword=''; state.params.type=''; $('#keyword').val(''); $('#type').val(''); searchUsers()">Reset</button>
    </section>

    <section class="table-panel">
        <table id="table" class="data-table">
            <thead>
            <tr>
                <th><input id="selectAll" type="checkbox" onclick="selectAll()" /></th>
                <th>No.</th>
                <th>Account</th>
                <th>Name</th>
                <th>Status</th>
                <th>Created At</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div id="emptyState" class="empty-state"></div>
    </section>

    <section class="operationBar">
        <button class="danger" type="button" onclick="deleteUser()">Delete</button>
    </section>

    <ul class="pageBar"></ul>
</main>
</body>
</html>
