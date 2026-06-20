<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>User Center</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function logout() {
            deleteRequest("${pageContext.request.contextPath}/api/user/session", {}, function () {
                window.location.href = "${pageContext.request.contextPath}/user/login";
            });
        }
    </script>
</head>
<body>
    <div>
        <span>User Center</span>
    </div>
    <div>
        <p>Welcome, ${sessionScope.userAccount}</p>
        <p>Admin pages and APIs are only available to administrators.</p>
    </div>
    <div>
        <a href="javascript:void(0)" onclick="logout()">Logout</a>
    </div>
</body>
</html>
