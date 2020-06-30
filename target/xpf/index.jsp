<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>

<head>
	<title>
		欢迎来到祖安！
	</title>
	<script type="text/javascript">
		function toLogin(flag) {
			window.location.href = "login/" + flag;
		}			
	</script>
</head>

<body>
	<div>
		<label>我是皮尔吉沃特人请点这里-></label>
		<span>
			<input id="admin" type="button" onclick="toLogin(this.id)" value="登录"> <BR>
		</span>
		<label>我是祖安人请点这里-></label>
		<span>
			<input id="user" type="button" onclick="toLogin(this.id)" value="登录">
		</span>
	</div>
</body>

</html>