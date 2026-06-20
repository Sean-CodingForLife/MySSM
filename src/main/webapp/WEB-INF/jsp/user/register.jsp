<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>User Register</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/MD5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function register() {
            var account = $("#account").val();
            var name = $("#name").val();
            var password = $("#password").val();
            var repeatedPassword = $("#repassword").val();

            if (!account || !name || !password) {
                alert("Account, name and password are required.");
                return;
            }
            if (password.length < 8) {
                alert("Password must be at least 8 characters.");
                return;
            }
            if (password !== repeatedPassword) {
                alert("Passwords do not match.");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/public/users", {
                account: account,
                name: name,
                password: hex_md5(password)
            }, function () {
                window.location.href = "${pageContext.request.contextPath}/user/login";
            });
        }
    </script>
</head>
<body>
<main class="auth-panel">
    <h1>User Register</h1>
    <form action="">
        <div class="field">
            <label for="account">Account</label>
            <input type="text" id="account" autocomplete="username" />
        </div>
        <div class="field">
            <label for="name">Name</label>
            <input type="text" id="name" />
        </div>
        <div class="field">
            <label for="password">Password</label>
            <input type="password" id="password" autocomplete="new-password" />
        </div>
        <div class="field">
            <label for="repassword">Repeat Password</label>
            <input type="password" id="repassword" autocomplete="new-password" />
        </div>
        <button class="primary" type="button" onclick="register()">Register</button>
    </form>
    <p><a href="${pageContext.request.contextPath}/user/login">Back to login</a></p>
</main>
</body>
</html>
