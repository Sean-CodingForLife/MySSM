<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>

<head>
	<title>
		请您验证您的管理员身份！
	</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/MD5.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>

	<script type="text/javascript">
		function login() {

			var account = document.getElementById("account").value;
			var password = document.getElementById("password").value;

			var md5Password = hex_md5(password);

			postRequest("admin", {
				account: account,
				password: md5Password

			}, function () { window.location.href = "../manager"; });
		}
	</script>
</head>

<body>
	<form action="">
		<ul class="form-input-list">
			<li>账号</li>
			<li><input type="text" id="account" /></li>
			<li>密码</li>
			<li><input type="password" id="password" /></li>
		</ul>
		<input type="button" onclick="login()" value="登录" />
	</form>
</body>

</html>