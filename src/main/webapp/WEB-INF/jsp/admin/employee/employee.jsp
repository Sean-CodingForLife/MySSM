<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Employee Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        var state = createListState("${pageContext.request.contextPath}/api/admin/employees", 10, {
            keyword: "",
            type: ""
        });

        var columns = [
            { key: "no", label: "No." },
            { key: "name", label: "Name", editable: true },
            { key: "id", label: "ID Number", editable: true },
            { key: "phone", label: "Phone", editable: true },
            { key: "email", label: "Email", editable: true },
            { key: "sex", label: "Sex", editable: true },
            { key: "department", label: "Department" },
            { key: "job", label: "Job" },
            { key: "created_date", label: "Created At" }
        ];

        var detailFields = [
            "name", "id", "address", "mail", "phone", "qq", "email", "sex",
            "political_status", "birthday", "nation", "education", "major",
            "hobby", "description", "department_no", "job_no"
        ];

        function refreshEmployees() {
            loadTable(state, columns, { emptyText: "No employees found." });
        }

        function searchEmployees() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            state.params.type = $("#type").val();
            refreshEmployees();
        }

        function employeePayload(source) {
            var data = {};
            detailFields.forEach(function (field) {
                data[field] = source[field] || "";
            });
            if (source.no !== undefined) {
                data.no = String(source.no);
            }
            return data;
        }

        function addEmployee() {
            var data = employeePayload(formData("#employeeForm"));
            if (!data.name || !data.department_no || !data.job_no) {
                alert("Name, department and job are required.");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/admin/employees", data, function () {
                closePopBox();
                clearForm("#employeeForm");
                refreshEmployees();
            });
        }

        function updateEmployee() {
            var row = getEditedRowData();
            if (!row) {
                return;
            }

            var data = employeePayload(row);
            putRequest("${pageContext.request.contextPath}/api/admin/employees", data, function () {
                refreshEmployees();
            });
        }

        function deleteEmployee() {
            var employees = getSelectedCheckbox(document.getElementsByName("selectOne"));
            if (!requireSelection(employees, "employee")) {
                return;
            }

            if (confirm("Delete selected employees?")) {
                deleteRequest("${pageContext.request.contextPath}/api/admin/employees", employees, function () {
                    refreshEmployees();
                });
            }
        }

        function loadOptions() {
            getJson("${pageContext.request.contextPath}/api/admin/departments?keyword=", function (data) {
                fillOptions("#department_no", data.body || [], "Select department");
            });
            getJson("${pageContext.request.contextPath}/api/admin/jobs?keyword=", function (data) {
                fillOptions("#job_no", data.body || [], "Select job");
            });
        }

        function fillOptions(selector, rows, placeholder) {
            var select = $(selector);
            select.empty();
            select.append($("<option>").val("").text(placeholder));
            rows.forEach(function (row) {
                select.append($("<option>").val(row.no).text(row.name));
            });
        }

        $(function () {
            bindTableEditing(columns);
            loadOptions();
            refreshEmployees();
        });
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title">Employee Management</h1>
            <p class="breadcrumb">Admin Console / Employees</p>
        </div>
        <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
    </header>

    <section class="toolbar">
        <div class="field grow">
            <label for="keyword">Keyword</label>
            <input type="text" id="keyword" placeholder="Search employees" />
        </div>
        <div class="field">
            <label for="type">Search By</label>
            <select id="type">
                <option value="">All</option>
                <option value="name">Name</option>
                <option value="id">ID Number</option>
                <option value="phone">Phone</option>
                <option value="sex">Sex</option>
                <option value="department">Department</option>
                <option value="job">Job</option>
            </select>
        </div>
        <button type="button" onclick="searchEmployees()">Search</button>
        <button type="button" onclick="state.params.keyword=''; state.params.type=''; $('#keyword').val(''); $('#type').val(''); searchEmployees()">Reset</button>
    </section>

    <section class="table-panel">
        <table id="table" class="data-table">
            <thead>
            <tr>
                <th><input id="selectAll" type="checkbox" onclick="selectAll()" /></th>
                <th>No.</th>
                <th>Name</th>
                <th>ID Number</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Sex</th>
                <th>Department</th>
                <th>Job</th>
                <th>Created At</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div id="emptyState" class="empty-state"></div>
    </section>

    <section class="operationBar">
        <button class="save primary" type="button" onclick="updateEmployee()">Save</button>
        <button class="cancel" type="button" onclick="cancelUpdate()">Cancel</button>
        <button class="danger" type="button" onclick="deleteEmployee()">Delete</button>
        <button class="primary" type="button" onclick="openPopBox()">Add Employee</button>
    </section>

    <ul class="pageBar"></ul>
</main>

<div class="light">
    <h2 class="modal-header">Add Employee</h2>
    <form id="employeeForm" action="">
        <div class="form-grid">
            <div class="field">
                <label for="name">Name</label>
                <input type="text" id="name" data-field="name" />
            </div>
            <div class="field">
                <label for="id">ID Number</label>
                <input type="text" id="id" data-field="id" />
            </div>
            <div class="field">
                <label for="address">Address</label>
                <input type="text" id="address" data-field="address" />
            </div>
            <div class="field">
                <label for="mail">Postal Code</label>
                <input type="text" id="mail" data-field="mail" />
            </div>
            <div class="field">
                <label for="phone">Phone</label>
                <input type="text" id="phone" data-field="phone" />
            </div>
            <div class="field">
                <label for="qq">QQ</label>
                <input type="text" id="qq" data-field="qq" />
            </div>
            <div class="field">
                <label for="email">Email</label>
                <input type="text" id="email" data-field="email" />
            </div>
            <div class="field">
                <label for="sex">Sex</label>
                <input type="text" id="sex" data-field="sex" />
            </div>
            <div class="field">
                <label for="political_status">Political Status</label>
                <input type="text" id="political_status" data-field="political_status" />
            </div>
            <div class="field">
                <label for="birthday">Birthday</label>
                <input type="text" id="birthday" data-field="birthday" />
            </div>
            <div class="field">
                <label for="nation">Nation</label>
                <input type="text" id="nation" data-field="nation" />
            </div>
            <div class="field">
                <label for="education">Education</label>
                <input type="text" id="education" data-field="education" />
            </div>
            <div class="field">
                <label for="major">Major</label>
                <input type="text" id="major" data-field="major" />
            </div>
            <div class="field">
                <label for="hobby">Hobby</label>
                <input type="text" id="hobby" data-field="hobby" />
            </div>
            <div class="field">
                <label for="department_no">Department</label>
                <select id="department_no" data-field="department_no"></select>
            </div>
            <div class="field">
                <label for="job_no">Job</label>
                <select id="job_no" data-field="job_no"></select>
            </div>
            <div class="field full">
                <label for="description">Description</label>
                <textarea id="description" data-field="description"></textarea>
            </div>
        </div>
    </form>
    <div class="modal-actions">
        <button type="button" onclick="closePopBox()">Cancel</button>
        <button class="primary" type="button" onclick="addEmployee()">Submit</button>
    </div>
</div>
<div class="fade"></div>
</body>
</html>
