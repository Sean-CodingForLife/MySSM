<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>

<head>
	<title>
		用户管理
	</title>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />

	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/MD5.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
	<script type="text/javascript">

		var getRequestParam = new GetRequestParam("users", 1, 10, "", "");

		window.onload = function () {
			getRequest(getRequestParam);
			bindPageBarEventListener(getRequestParam);
		};

		function query() {

			var keyword = document.getElementById("keyword").value;
			var types = document.getElementsByName("type");
			if (keyword == "") {
				alert("Get out here Mother Sucker!");
				return;
			}

			var type = getSelectedRadio(types);
			getRequestParam.keyword = keyword;
			getRequestParam.type = type;
			getRequest(getRequestParam);
			window.href += "#wizard";
		}

		function deleteUser() {

			if (confirm("确定？")) {

				var users = getSelectedCheckbox(document.getElementsByName("selectOne"));

				if (users.length != 0) {

					deleteRequest("users", users, function () { alert("删除成功，来刷新一下吧"); });

				} else {
					alert("啥都没选你就删？")
				}

			}

		}

	</script>

</head>

<body>

	<div>
		<span>
			当前路径:主页>用户管理
		</span>
	</div>
	<div>
		<form>
			<div>
				<input type="text" id="keyword" />
				<input type="text" class="hiddenText" />
				<input type="button" onclick="query()" value="搜索" />
			</div>
			<div>
				按名字<input type="radio" name="type" value="name" checked /> |
				按状态<input type="radio" name="type" value="status" />
			</div>
		</form>
	</div>

	<div>
		<table id="table" border="1">
			<tr>
				<td>
					<input id="selectAll" type="checkbox" onclick="selectAll()" />
				</td>
				<td>编号</td>
				<td>账号</td>
				<td>密码</td>
				<td>昵称</td>
				<td>状态</td>
				<td>建档日期</td>
			</tr>
		</table>
	</div>
	<div class="operationBar">
		<a href="javascript:void(0)" onclick="deleteUser()">删除用户</a>
		<a href="../manager">返回</a>
	</div>
	<div>
		<ul class="pageBar">
			<li class="prevPage">
				<a>
					上一页
				</a>
			</li>
			<li class="nextPage">
				<a>
					下一页
				</a>
			</li>
		</ul>
	</div>
</body>

</html>