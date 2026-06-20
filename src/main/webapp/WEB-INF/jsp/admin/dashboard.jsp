<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Admin Console</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function logout() {
            deleteRequest("${pageContext.request.contextPath}/api/admin/session", {}, function () {
                window.location.href = "${pageContext.request.contextPath}/admin/login";
            });
        }
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title">Admin Console</h1>
            <p class="breadcrumb">Personnel operations and account management</p>
        </div>
        <button type="button" onclick="logout()">Logout</button>
    </header>

    <section class="dashboard-grid">
        <a href="${pageContext.request.contextPath}/admin/users">Users</a>
        <a href="${pageContext.request.contextPath}/admin/departments">Departments</a>
        <a href="${pageContext.request.contextPath}/admin/jobs">Jobs</a>
        <a href="${pageContext.request.contextPath}/admin/documents">Documents</a>
        <a href="${pageContext.request.contextPath}/admin/employees">Employees</a>
        <a href="${pageContext.request.contextPath}/admin/notices">Notices</a>
    </section>
</main>
</body>
</html>
