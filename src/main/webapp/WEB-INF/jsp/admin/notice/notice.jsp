<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>

<head>
    <title>
        通知管理
    </title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">

        var getRequestParam = new GetRequestParam("notices", 1, 2, "", "");

        window.onload = function () {
            getRequest(getRequestParam);
            bindPageBarEventListener(getRequestParam);
        }

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

        function deleteNotice() {
            if (confirm("确定？")) {
                var notices = getSelectedCheckbox(document.getElementsByName("selectOne"));
                if (notices.length != 0) {
                    deleteRequest("notices", notices, function () { alert("删除成功，来刷新一下吧"); });
                } else {
                    alert("啥都没有选你就删？");
                }

            }
        }

        function addNotice() {
            var title = document.getElementById("title").value;
            var content = document.getElementById("content").value;

            postRequest("notice", {
                title: title,
                content: content
            }, function () { alert("添加成功，刷新一下吧"); });

        }

        function updateNotice() {

            var activeRow = document.getElementById("activeRow");

            var no = activeRow.cells[1].textContent;
            var title = activeRow.cells[2].getElementsByTagName("input")[0].value;
            var content = activeRow.cells[3].getElementsByTagName("input")[0].value;

            var data = {
                no: no,
                title: title,
                content: content
            }; putRequest("notice", data, function () { alert("更新成功，刷新一下吧"); });

        }

    </script>

</head>

<body>
    <div>
        <span id="wizard">
            当前路径:主页>通知管理
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
                按标题<input type="radio" name="type" value="title" checked /> |
                按发送者<input type="radio" name="type" value="name" />
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
                <td>标题</td>
                <td>内容</td>
                <td>创建时间</td>
                <td>发送者</td>
            </tr>
        </table>
    </div>

    <div class="light">
        <div>
            <form action="">

                <ul class="form-input-list">
                    <li>
                        标题
                    </li>
                    <li>
                        <input type="text" id="title" />
                    </li>
                    <li>
                        内容
                    </li>
                    <li>
                        <input type="text" id="content" />
                    </li>
                </ul>

            </form>
        </div>
        <div class="operationBar">
            <a href="javascript:void(0)" onclick="addNotice()">提交</a>
            <a href="javascript:void(0)" onclick="closePopBox()">取消</a>
        </div>
    </div>
    <div class="fade"></div>

    <div" class="operationBar">
        <a class="save" href="javascript:void(0)" onclick="updateNotice()">保存</a>
        <a class="cancel" href="javascript:void(0)" onclick="cancelUpdate()">取消</a>
        <a class="show" href="javascript:void(0)" onclick="deleteNotice()">删除通知</a>
        <a class="show" href="javascript:void(0)" onclick="openPopBox()">添加通知</a>
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