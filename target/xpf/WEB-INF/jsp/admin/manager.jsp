<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>
	<head>

		<title>
			欢迎来到祖安
		</title>

		<style>
			#list li {
				list-style-type  : none;
			}
		</style>

	</head>
	<body>
		<div>
			<span>
				当前路径:主页
			</span>
		</div>
		<div>
			<ul id = "list">
				<li>
					<a href="user/home">用户管理</a>
				</li>
				<li>
					<a href="department/home">部门管理</a>
				</li>
				<li>
					<a href="job/home">职位管理</a>
				</li>
				<li>
					<a href="document/home">文件管理</a>
				</li>
				<li>
					<a href="employee/home">员工管理</a>
				</li>
				<li>
					<a href="notice/home">公告管理</a>
				</li>
			</ul>
		</div>
	</body>
</html>
