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
            var account = document.getElementById("account").value;
            var name = document.getElementById("name").value;
            var password = document.getElementById("password").value;
            var rePassword = document.getElementById("repassword").value;

            if (password.length < 8) {
                alert("Password must be at least 8 characters.");
                return;
            }
            if (password !== rePassword) {
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
    <form action="">
        <ul class="form-input-list">
            <li>Account</li>
            <li><input type="text" id="account" /></li>
            <li>Name</li>
            <li><input type="text" id="name" /></li>
            <li>Password</li>
            <li><input type="password" id="password" /></li>
            <li>Repeat Password</li>
            <li><input type="password" id="repassword" /></li>
        </ul>
        <input type="button" onclick="register()" value="Register" />
    </form>
</body>
</html>
