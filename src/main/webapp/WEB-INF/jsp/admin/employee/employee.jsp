<%@ page language = "java" import = "java.util.*" pageEncoding = "UTF-8"%>

<html>

<head>
    <title>
        员工管理
    </title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">

        var getRequestParam = new GetRequestParam("employees", 1, 10, "", "");

        window.onload = function () {
            getRequest(getRequestParam);
            bindPageBarEventListener(getRequestParam);
        }

        function query() {

            var keyword = document.getElementById("keyword").value;
            var type = getSelectedOption(document.getElementById("selector"));
            if (keyword == "") {
                alert("Get out here Mother Sucker!");
                return;
            }
            getRequestParam.keyword = keyword;
            getRequestParam.type = type;
            getRequest(getRequestParam);
            window.href += "#wizard";
        }

        function deleteEmployee() {
            if (confirm("确定?")) {
                 var employees = getSelectedCheckbox(document.getElementsByName("selectOne"));
                if (employees.length != 0) {
                    deleteRequest("employees", employees, function () { alert("删除成功，来刷新一下吧"); });
                } else {
                    alert("哈都没有选你就删？");
                }
            
            }
        }

        function requestBody(no, name, id, address, mail, phone, QQ, email, sex, political_status,
                             birthday, nation, education, major, hobby, description, job_no, department_no) {
            {
                this.no = no;
                this.name = name;
                this.id = id; 
                this.address = address;
                this.mail = mail;
                this.phone = phone; 
                this.QQ = QQ; 
                this.email = email; 
                this.sex = sex; 
                this.political_status = political_status; 
                this.birthday = birthday; 
                this.nation = nation; 
                this.education = education; 
                this.major = major; 
                this.hobby = hobby; 
                this.description = description; 
                this.job_no = job_no;
                this.department_no = department_no; 
            }
        }

        function addEmployee() {

            var data = new requestBody(
            null,
            document.getElementById("name").value,
            document.getElementById("id").value,
            document.getElementById("address").value,
            document.getElementById("mail").value,
            document.getElementById("phone").value,
            document.getElementById("QQ").value,
            document.getElementById("email").value,
            document.getElementById("sex").value,
            document.getElementById("political_status").value,
            document.getElementById("birthday").value,
            document.getElementById("nation").value,
            document.getElementById("education").value,
            document.getElementById("major").value,
            document.getElementById("hobby").value,
            document.getElementById("description").value,
            getSelectedOption(document.getElementById("jobSelector")),
            getSelectedOption(document.getElementById("departmentSelector")));
            
            postRequest("employee", data, function () { alert("添加成功，刷新一下吧"); });

        }

        function updateEmployee() {

            var activeRow = document.getElementById("activeRow");

            var data = new requestBody(
                activeRow.cells[1].textContent,
                activeRow.cells[2].getElementsByTagName("input")[0].value,
                activeRow.cells[3].getElementsByTagName("input")[0].value,
                activeRow.cells[4].getElementsByTagName("input")[0].value,
                activeRow.cells[5].getElementsByTagName("input")[0].value,
                activeRow.cells[6].getElementsByTagName("input")[0].value,
                activeRow.cells[7].getElementsByTagName("input")[0].value,
                activeRow.cells[8].getElementsByTagName("input")[0].value,
                activeRow.cells[9].getElementsByTagName("input")[0].value,
                activeRow.cells[10].getElementsByTagName("input")[0].value,
                activeRow.cells[11].getElementsByTagName("input")[0].value,
                activeRow.cells[12].getElementsByTagName("input")[0].value,
                activeRow.cells[13].getElementsByTagName("input")[0].value,
                activeRow.cells[14].getElementsByTagName("input")[0].value,
                activeRow.cells[15].getElementsByTagName("input")[0].value,
                activeRow.cells[16].getElementsByTagName("input")[0].value,
                activeRow.cells[17].getElementsByTagName("input")[0].value,
                activeRow.cells[18].getElementsByTagName("input")[0].value);
                putRequest("employee", data, function () { alert("更新成功，刷新一下吧"); });

        }

    </script>

</head>

<body>
    <div>
        <span>
            当前路径:主页>员工管理
        </span>
    </div>
    <div>
        <form>
            <div>
                <input type="text" id="keyword" />
                <input type="text" class="hiddenText" />
                <select id="selector">
                    <option value="name">姓名</option>
                    <option value="id">身份证号</option>
                    <option value="phone">手机号</option>
                    <option value="sex">性别</option>
                    <option value="job">职位</option>
                    <option value="department">部门</option>
                </select>
                <input type="button" onclick="query()" value="搜索" />
            </div>
        </form>
    </div>
    <div>
        <table id="table" border="1" ondblclick="preUpdate()">
            <tr class = "headRow">
                <td>
                    <input id="selectAll" type="checkbox" onclick="selectAll()" />
                </td>
                <td>编    号</td>
                <td>姓    名</td>
                <td>身份证号</td>
                <td>住    址</td>
                <td>邮箱编号</td>
                <td>电话号码</td>
                <td>Q  Q 号</td>
                <td>电子邮箱</td>
                <td>性    别</td>
                <td>政治面貌</td>
                <td>生    日</td>
                <td>民    族</td>
                <td>学    历</td>
                <td>专    业</td>
                <td>爱    好</td>
                <td>描    述</td>
                <td>建档日期</td>
                <td>所属部门</td>
                <td>职    位</td>
            </tr>
        </table>
    </div>

    <div class="light">
        <div>
            <form action="">
                <ul>
                    <li class="popBoxContent-left">
                        <ul class="popBoxContent">
                            <li>姓名</li>
                            <li>身份证号</li>
                            <li>住址</li>
                            <li>邮箱编号</li>
                            <li>电话号码</li>
                            <li>QQ号</li>
                            <li>电子邮箱</li>
                            <li>性别</li>
                        </ul>
                        <ul class="popBoxContent">
                            <li><input id="name" type="text" /></li>
                            <li><input id="id" type="text" /></li>
                            <li><input id="address" type="text" /></li>
                            <li><input id="mail" type="text" /></li>
                            <li><input id="phone" type="text" /></li>
                            <li><input id="QQ" type="text" /></li>
                            <li><input id="email" type="text" /></li>
                            <li><input id="sex" type="text" /></li>
                        </ul>
                    </li>
                    <li class="popBoxContent-right">
                        <ul class="popBoxContent">
                            <li>政治面貌</li>
                            <li>生日</li>
                            <li>民族</li>
                            <li>学历</li>
                            <li>专业</li>
                            <li>爱好</li>
                            <li>描述</li>
                            <li>所属部门</li>
                            <li>职位</li>
                        </ul>
                        <ul class="popBoxContent">
                            <li><input id="political_status" type="text" /></li>
                            <li><input id="birthday" type="text" /></li>
                            <li><input id="nation" type="text" /></li>
                            <li><input id="education" type="text" /></li>
                            <li><input id="major" type="text" /></li>
                            <li><input id="hobby" type="text" /></li>
                            <li><input id="description" type="text" /></li>
                            <li>
                                <select id="departmentSelector">
                                    <option value = "default" checked>选择部门</option>
                                </select>
                            </li>
                            <li>
                                <select id="jobSelector">
                                    <option  value = "default">选择职位</option>
                                </select>
                            </li>
                        </ul>
                    </li>
                </ul>
            </form>
        </div>
        <div class="popBoxOperationBar">
            <a href="javascript:void(0)" onclick="addEmployee()">提交</a>
            <a href="javascript:void(0)" onclick="closePopBox()">取消</a>
        </div>
    </div>
    <div class="fade"></div>

    <div" class="operationBar">
        <a class="save" href="javascript:void(0)" onclick="updateEmployee()">保存</a>
        <a class="cancel" href="javascript:void(0)" onclick="cancelUpdate()">取消</a>
        <a id = "deleteJob"class="show" href="javascript:void(0)" onclick="deleteEmployee()">删除员工</a>
        <a id = "addJob"   class="show" href="javascript:void(0)" onclick="openPopBox()">添加员工</a>
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
        <script type = "text/javascript">
            (function(){
                var departmentSelector = document.getElementById("departmentSelector");
                var jobSelector        = document.getElementById("jobSelector");
                var addJob             = document.getElementById("addJob");
                addJob.addEventListener("click", function () {
                    $.ajax({
                        url: "../job/jobs?keyword=&startPage=&offset=",
                        type: "get",
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        cache: false,
                        success: function (data) {
                            if (data.head.successful == false) {
                            } else {
                                for (let i = 0, max = data.head.count;i < max;i++) {
                                    let option = document.createElement("option");
                                    option.setAttribute("value", data.body[i].no);
                                    option.textContent = data.body[i].name;
                                    jobSelector.appendChild(option);
                                }
                            }
                        },
                        erorr: function () {
                            alert("傻逼");
                        }
                    });
                    $.ajax({
                        url: "../department/departments?keyword=&startPage=&offset=",
                        type: "get",
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        cache: false,
                        success: function (data) {
                            if (data.head.successful == false) {
                            } else {
                                for (let i = 0, max = data.head.count; i < max; i++) {
                                    let option = document.createElement("option");
                                    option.setAttribute("value", data.body[i].no);
                                    option.textContent = data.body[i].name;
                                    departmentSelector.appendChild(option);
                                }
                            }
                        },
                        erorr: function () {
                            alert("傻逼");
                        }
                    });
                 });
            })();
        </script>
</body>

</html>