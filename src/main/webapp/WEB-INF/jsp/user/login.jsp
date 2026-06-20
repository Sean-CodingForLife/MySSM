<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/MD5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function login() {
            var account = document.getElementById("account").value;
            var password = document.getElementById("password").value;

            postRequest("${pageContext.request.contextPath}/api/user/session", {
                account: account,
                password: hex_md5(password)
            }, function () {
                window.location.href = "${pageContext.request.contextPath}/user/dashboard";
            });
        }
    </script>
</head>
<body>
    <form action="">
        <ul class="form-input-list">
            <li>Account</li>
            <li><input type="text" id="account" /></li>
            <li>Password</li>
            <li><input type="password" id="password" /></li>
        </ul>
        <input type="button" onclick="login()" value="Login" />
    </form>
    <div>
        <a href="${pageContext.request.contextPath}/user/register">Register</a>
    </div>
</body>
</html>
