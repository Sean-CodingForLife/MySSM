<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="admin.loginLogs.title"/></title>
    <%@ include file="../../common/assets.jsp" %>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript">
        window.I18N = {
            noRecords: "<spring:message code="common.noRecords"/>",
            previous: "<spring:message code="common.previous"/>",
            next: "<spring:message code="common.next"/>",
            requestFailed: "<spring:message code="common.requestFailed"/>",
            statuses: {
                SUCCESS: "<spring:message code="status.SUCCESS"/>",
                FAIL: "<spring:message code="status.FAIL"/>"
            }
        };

        var state = createListState("${pageContext.request.contextPath}/api/admin/login-logs", 10, { keyword: "" });
        var columns = [
            { key: "id", label: "<spring:message code="common.id"/>" },
            { key: "account", label: "<spring:message code="common.account"/>" },
            { key: "status", label: "<spring:message code="common.status"/>" },
            { key: "ip", label: "<spring:message code="common.ip"/>" },
            { key: "message", label: "<spring:message code="common.message"/>" },
            { key: "created_date", label: "<spring:message code="common.createdAt"/>" }
        ];

        function refreshLogs() {
            loadTable(state, columns, { selectable: false, emptyText: "<spring:message code="admin.loginLogs.empty"/>" });
        }

        function searchLogs() {
            state.page = 1;
            state.params.keyword = $("#keyword").val();
            refreshLogs();
        }

        $(function () {
            refreshLogs();
        });
    </script>
</head>
<body>
<spring:message code="admin.loginLogs.title" var="pageTitle"/>
<% request.setAttribute("activeNav", "login-logs"); %>
<%@ include file="../../common/app-shell-start.jsp" %>
    <header class="content-header">
        <div>
            <h1><spring:message code="admin.loginLogs.title"/></h1>
            <p><spring:message code="admin.loginLogs.breadcrumb"/></p>
        </div>
    </header>
    <section class="card mb-3">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-12 col-md">
                    <label class="form-label" for="keyword"><spring:message code="common.keyword"/></label>
                    <input class="form-control" type="text" id="keyword" placeholder="<spring:message code="admin.loginLogs.searchPlaceholder"/>" />
                </div>
                <div class="col-12 col-md-auto d-flex gap-2">
                    <button class="btn btn-primary" type="button" onclick="searchLogs()"><spring:message code="common.search"/></button>
                    <button class="btn btn-outline-secondary" type="button" onclick="state.params.keyword=''; $('#keyword').val(''); searchLogs()"><spring:message code="common.reset"/></button>
                </div>
            </div>
        </div>
    </section>
    <section class="card table-panel">
        <div class="table-responsive">
            <table id="table" class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th><spring:message code="common.id"/></th>
                    <th><spring:message code="common.account"/></th>
                    <th><spring:message code="common.status"/></th>
                    <th><spring:message code="common.ip"/></th>
                    <th><spring:message code="common.message"/></th>
                    <th><spring:message code="common.createdAt"/></th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div id="emptyState" class="empty-state border-top"></div>
    </section>
    <section class="d-flex justify-content-end mt-3">
        <ul class="pagination pageBar mb-0"></ul>
    </section>
<%@ include file="../../common/app-shell-end.jsp" %>
</body>
</html>
