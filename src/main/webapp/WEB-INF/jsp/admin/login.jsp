<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/MD5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function login() {
            var account = $("#account").val();
            var password = $("#password").val();
            if (!account || !password) {
                alert("Account and password are required.");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/admin/session", {
                account: account,
                password: hex_md5(password)
            }, function () {
                window.location.href = "${pageContext.request.contextPath}/admin/dashboard";
            });
        }
    </script>
</head>
<body>
<main class="auth-panel">
    <h1>Admin Login</h1>
    <form action="">
        <div class="field">
            <label for="account">Account</label>
            <input type="text" id="account" autocomplete="username" />
        </div>
        <div class="field">
            <label for="password">Password</label>
            <input type="password" id="password" autocomplete="current-password" />
        </div>
        <button class="primary" type="button" onclick="login()">Login</button>
    </form>
</main>
</body>
</html>
