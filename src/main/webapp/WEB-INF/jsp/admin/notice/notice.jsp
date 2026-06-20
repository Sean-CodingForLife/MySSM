<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Notice Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        var state = createListState("${pageContext.request.contextPath}/api/admin/notices", 10, {
            keyword: "",
            type: ""
        });

        var columns = [
            { key: "no", label: "No." },
            { key: "title", label: "Title", editable: true },
            { key: "content", label: "Content", editable: true },
            { key: "created_date", label: "Created At" },
            { key: "name", label: "Publisher" }
        ];

        function refreshNotices() {
            loadTable(state, columns, { emptyText: "No notices found." });
        }

        function searchNotices() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            state.params.type = $("#type").val();
            refreshNotices();
        }

        function addNotice() {
            var data = formData("#noticeForm");
            if (!data.title || !data.content) {
                alert("Title and content are required.");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/admin/notices", data, function () {
                closePopBox();
                clearForm("#noticeForm");
                refreshNotices();
            });
        }

        function updateNotice() {
            var row = getEditedRowData();
            if (!row) {
                return;
            }

            putRequest("${pageContext.request.contextPath}/api/admin/notices", {
                no: row.no,
                title: row.title,
                content: row.content
            }, function () {
                refreshNotices();
            });
        }

        function deleteNotice() {
            var notices = getSelectedCheckbox(document.getElementsByName("selectOne"));
            if (!requireSelection(notices, "notice")) {
                return;
            }

            if (confirm("Delete selected notices?")) {
                deleteRequest("${pageContext.request.contextPath}/api/admin/notices", notices, function () {
                    refreshNotices();
                });
            }
        }

        $(function () {
            bindTableEditing(columns);
            refreshNotices();
        });
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title">Notice Management</h1>
            <p class="breadcrumb">Admin Console / Notices</p>
        </div>
        <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
    </header>

    <section class="toolbar">
        <div class="field grow">
            <label for="keyword">Keyword</label>
            <input type="text" id="keyword" placeholder="Search notices" />
        </div>
        <div class="field">
            <label for="type">Search By</label>
            <select id="type">
                <option value="">All</option>
                <option value="title">Title</option>
                <option value="name">Publisher</option>
            </select>
        </div>
        <button type="button" onclick="searchNotices()">Search</button>
        <button type="button" onclick="state.params.keyword=''; state.params.type=''; $('#keyword').val(''); $('#type').val(''); searchNotices()">Reset</button>
    </section>

    <section class="table-panel">
        <table id="table" class="data-table">
            <thead>
            <tr>
                <th><input id="selectAll" type="checkbox" onclick="selectAll()" /></th>
                <th>No.</th>
                <th>Title</th>
                <th>Content</th>
                <th>Created At</th>
                <th>Publisher</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div id="emptyState" class="empty-state"></div>
    </section>

    <section class="operationBar">
        <button class="save primary" type="button" onclick="updateNotice()">Save</button>
        <button class="cancel" type="button" onclick="cancelUpdate()">Cancel</button>
        <button class="danger" type="button" onclick="deleteNotice()">Delete</button>
        <button class="primary" type="button" onclick="openPopBox()">Add Notice</button>
    </section>

    <ul class="pageBar"></ul>
</main>

<div class="light">
    <h2 class="modal-header">Add Notice</h2>
    <form id="noticeForm" action="">
        <div class="form-grid">
            <div class="field full">
                <label for="title">Title</label>
                <input type="text" id="title" data-field="title" />
            </div>
            <div class="field full">
                <label for="content">Content</label>
                <textarea id="content" data-field="content"></textarea>
            </div>
        </div>
    </form>
    <div class="modal-actions">
        <button type="button" onclick="closePopBox()">Cancel</button>
        <button class="primary" type="button" onclick="addNotice()">Submit</button>
    </div>
</div>
<div class="fade"></div>
</body>
</html>
