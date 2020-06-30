<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>

<head>
	<title>
		成为一名祖安人！
	</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/MD5.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">

		function validLength(str, reStr) {

			if (str.length < 8 || reStr.length < 8) {
				alert("密码太短了, 太短了！至少8个字");
				return true;
			} return false;
		}


		function validRepeat(str, reStr) {

			if (str != reStr) {
				alert("你个蠢货！你两次输入的密码不一致！");
				return true;
			} return false;
		}

		function validWordAndNumber(str) {

			var regA2z = new RegExp("[a-z]");
			var reg029 = new RegExp("[0-9]");

			if (regA2z.test(str) && reg029.test(str)) {
				return false;
			} alert("你的密码应该包含数字与字母的组合");
			return false;
		}

		function valid(password, rePassword) {
			if (!validRepeat(password, rePassword)
				&& !validLength(password, rePassword)
				&& !validWordAndNumber(password)) {
				return true;
			} return false;
		}

		function register() {

			var account = document.getElementById("account").value;
			var name = document.getElementById("name").value;
			var password = document.getElementById("password").value;
			var rePassword = document.getElementById("repassword").value;

			var md5Password = hex_md5(password);

			if (valid(password, rePassword)) {

				var data = {

					account: account,
					name: name,
					password: md5Password

				}; postRequest("register", data, function () { window.location.href = "login/user"; });

			} else {

			}

		}
	</script>

</head>

<body>
	<form action="">
		<ul class = "form-input-list">
			<li>账号<< /li>
			<li><input type="text" id="account" /></li>
			<li>昵称<< /li>
			<li><input type="text" id="name" /></li>
			<li>密码</li>
			<li><input type="password" id="password" /></li>
			<li>重复密码</li>
			<li><input type="password" id="repassword" /></li>
		</ul>
		<input type="button" onclick="register()" value="注册" />
	</form>
</body>

</html>