<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>

<head>
    <title>
        部门管理
    </title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">

        var getRequestParam = new GetRequestParam("departments", 1, 10, "");

        window.onload = function () {
                getRequest(getRequestParam);
                bindPageBarEventListener(getRequestParam);
        }

        function query() {
                var keyword = document.getElementById("keyword").value;
                if (keyword == "") {
                    alert("Get out here Mother Sucker!");
                    return;
                }
                getRequestParam.keyword = keyword;
                getRequest(getRequestParam);
                window.href += "#wizard";
        }

        function deleteDepartment() {
            if (confirm("确定？")) {
                var departments = getSelectedCheckbox(document.getElementsByName("selectOne"));
                if (departments.length != 0) {
                    deleteRequest("departments", departments, function () { alert("删除成功，来刷新一下吧"); });
                } else {
                    alert("哈都没有选你就删？")
                }
            }
        }

        function addDepartment() {
            var name = document.getElementById("name").value;
            var description = document.getElementById("description").value;

            var data = {
                name: name,
                description: description
            };

            postRequest("department", data, function () { alert("添加成功，刷新一下吧"); });

        }

        function updateDepartment() {

            var activeRow = document.getElementById("activeRow");

            var no = activeRow.cells[1].textContent;
            var name = activeRow.cells[2].getElementsByTagName("input")[0].value;
            var description = activeRow.cells[3].getElementsByTagName("input")[0].value;

            var data = {
                no: no,
                name: name,
                description: description
            }; putRequest("department", data, function () { alert("更新成功，刷新一下吧"); });

        }

    </script>

</head>

<body>
    <div>
        <span>
            当前路径:主页>部门管理
        </span>
    </div>
    <div>
        <form>
            <div>
                <input type="text" id="keyword" />
                <input type="text" class="hiddenText" />
                <input type="button" onclick="query()" value="搜索" />
            </div>
        </form>
    </div>
    <div>
        <table id="table" border="1" ondblclick="preUpdate()">
            <tr>
                <td>
                    <input id="selectAll" type="checkbox" onclick="selectAll()" />
                </td>
                <td>编号</td>
                <td>部门名称</td>
                <td>描述</td>
            </tr>
        </table>
    </div>

    <div class="light">
        <div>
            <form action="">
                <label>部门名称</label>
                <input type="text" id="name" />
                <label>描述</label>
                <input type="text" id="description" />
            </form>
        </div>
        <div class="operationBar">
            <a href="javascript:void(0)" onclick="addDepartment()">提交</a>
            <a href="javascript:void(0)" onclick="closePopBox()">取消</a>
        </div>
    </div>
    <div class="fade"></div>

    <div" class="operationBar">
        <a class="save" href="javascript:void(0)" onclick="updateDepartment()">保存</a>
        <a class="cancel" href="javascript:void(0)" onclick="cancelUpdate()">取消</a>
        <a class="show" href="javascript:void(0)" onclick="deleteDepartment()">删除部门</a>
        <a class="show" href="javascript:void(0)" onclick="openPopBox()">添加部门</a>
        <a class="show" href="../manager">返回</a>
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