<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Admin Console</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function logout() {
            deleteRequest("${pageContext.request.contextPath}/api/admin/session", {}, function () {
                window.location.href = "${pageContext.request.contextPath}/admin/login";
            });
        }
    </script>
    <style>
        #list li {
            list-style-type: none;
            margin: 8px 0;
        }
    </style>
</head>
<body>
    <div>
        <span>Admin Console</span>
    </div>
    <div>
        <ul id="list">
            <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/departments">Departments</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/jobs">Jobs</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/documents">Documents</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/employees">Employees</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/notices">Notices</a></li>
        </ul>
    </div>
    <div>
        <a href="javascript:void(0)" onclick="logout()">Logout</a>
    </div>
</body>
</html>
