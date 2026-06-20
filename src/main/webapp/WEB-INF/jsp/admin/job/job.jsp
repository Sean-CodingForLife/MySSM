<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Job Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        var state = createListState("${pageContext.request.contextPath}/api/admin/jobs", 10, {
            keyword: ""
        });

        var columns = [
            { key: "no", label: "No." },
            { key: "name", label: "Name", editable: true },
            { key: "description", label: "Description", editable: true }
        ];

        function refreshJobs() {
            loadTable(state, columns, { emptyText: "No jobs found." });
        }

        function searchJobs() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            refreshJobs();
        }

        function addJob() {
            var data = formData("#jobForm");
            if (!data.name) {
                alert("Job name is required.");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/admin/jobs", data, function () {
                closePopBox();
                clearForm("#jobForm");
                refreshJobs();
            });
        }

        function updateJob() {
            var data = getEditedRowData();
            if (!data) {
                return;
            }

            putRequest("${pageContext.request.contextPath}/api/admin/jobs", data, function () {
                refreshJobs();
            });
        }

        function deleteJob() {
            var jobs = getSelectedCheckbox(document.getElementsByName("selectOne"));
            if (!requireSelection(jobs, "job")) {
                return;
            }

            if (confirm("Delete selected jobs?")) {
                deleteRequest("${pageContext.request.contextPath}/api/admin/jobs", jobs, function () {
                    refreshJobs();
                });
            }
        }

        $(function () {
            bindTableEditing(columns);
            refreshJobs();
        });
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title">Job Management</h1>
            <p class="breadcrumb">Admin Console / Jobs</p>
        </div>
        <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
    </header>

    <section class="toolbar">
        <div class="field grow">
            <label for="keyword">Keyword</label>
            <input type="text" id="keyword" placeholder="Search by job name" />
        </div>
        <button type="button" onclick="searchJobs()">Search</button>
        <button type="button" onclick="state.params.keyword=''; $('#keyword').val(''); searchJobs()">Reset</button>
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
        <button class="save primary" type="button" onclick="updateJob()">Save</button>
        <button class="cancel" type="button" onclick="cancelUpdate()">Cancel</button>
        <button class="danger" type="button" onclick="deleteJob()">Delete</button>
        <button class="primary" type="button" onclick="openPopBox()">Add Job</button>
    </section>

    <ul class="pageBar"></ul>
</main>

<div class="light">
    <h2 class="modal-header">Add Job</h2>
    <form id="jobForm" action="">
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
        <button class="primary" type="button" onclick="addJob()">Submit</button>
    </div>
</div>
<div class="fade"></div>
</body>
</html>
