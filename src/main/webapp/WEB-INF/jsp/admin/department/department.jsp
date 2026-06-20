<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Department Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        var state = createListState("${pageContext.request.contextPath}/api/admin/departments", 10, {
            keyword: ""
        });

        var columns = [
            { key: "no", label: "No." },
            { key: "name", label: "Name", editable: true },
            { key: "description", label: "Description", editable: true }
        ];

        function refreshDepartments() {
            loadTable(state, columns, { emptyText: "No departments found." });
        }

        function searchDepartments() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            refreshDepartments();
        }

        function addDepartment() {
            var data = formData("#departmentForm");
            if (!data.name) {
                alert("Department name is required.");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/admin/departments", data, function () {
                closePopBox();
                clearForm("#departmentForm");
                refreshDepartments();
            });
        }

        function updateDepartment() {
            var data = getEditedRowData();
            if (!data) {
                return;
            }

            putRequest("${pageContext.request.contextPath}/api/admin/departments", data, function () {
                refreshDepartments();
            });
        }

        function deleteDepartment() {
            var departments = getSelectedCheckbox(document.getElementsByName("selectOne"));
            if (!requireSelection(departments, "department")) {
                return;
            }

            if (confirm("Delete selected departments?")) {
                deleteRequest("${pageContext.request.contextPath}/api/admin/departments", departments, function () {
                    refreshDepartments();
                });
            }
        }

        $(function () {
            bindTableEditing(columns);
            refreshDepartments();
        });
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title">Department Management</h1>
            <p class="breadcrumb">Admin Console / Departments</p>
        </div>
        <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
    </header>

    <section class="toolbar">
        <div class="field grow">
            <label for="keyword">Keyword</label>
            <input type="text" id="keyword" placeholder="Search by department name" />
        </div>
        <button type="button" onclick="searchDepartments()">Search</button>
        <button type="button" onclick="state.params.keyword=''; $('#keyword').val(''); searchDepartments()">Reset</button>
    </section>

    <section class="table-panel">
        <table id="table" class="data-table">
            <thead>
            <tr>
                <th><input id="selectAll" type="checkbox" onclick="selectAll()" /></th>
                <th>No.</th>
                <th>Name</th>
                <th>Description</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div id="emptyState" class="empty-state"></div>
    </section>

    <section class="operationBar">
        <button class="save primary" type="button" onclick="updateDepartment()">Save</button>
        <button class="cancel" type="button" onclick="cancelUpdate()">Cancel</button>
        <button class="danger" type="button" onclick="deleteDepartment()">Delete</button>
        <button class="primary" type="button" onclick="openPopBox()">Add Department</button>
    </section>

    <ul class="pageBar"></ul>
</main>

<div class="light">
    <h2 class="modal-header">Add Department</h2>
    <form id="departmentForm" action="">
        <div class="form-grid">
            <div class="field">
                <label for="name">Name</label>
                <input type="text" id="name" data-field="name" />
            </div>
            <div class="field">
                <label for="description">Description</label>
                <input type="text" id="description" data-field="description" />
            </div>
        </div>
    </form>
    <div class="modal-actions">
        <button type="button" onclick="closePopBox()">Cancel</button>
        <button class="primary" type="button" onclick="addDepartment()">Submit</button>
    </div>
</div>
<div class="fade"></div>
</body>
</html>
