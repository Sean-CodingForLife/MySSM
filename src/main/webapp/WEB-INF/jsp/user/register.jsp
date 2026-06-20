<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="auth.signup"/></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        window.I18N = {
            registerRequired: "<spring:message code="auth.required.register"/>",
            passwordMin: "<spring:message code="auth.password.min"/>",
            passwordMismatch: "<spring:message code="auth.password.mismatch"/>",
            requestFailed: "<spring:message code="common.requestFailed"/>"
        };

        function register() {
            var account = $("#account").val();
            var name = $("#name").val();
            var password = $("#password").val();
            var repeatedPassword = $("#repassword").val();

            if (!account || !name || !password) {
                alert(window.I18N.registerRequired);
                return;
            }
            if (password.length < 8) {
                alert(window.I18N.passwordMin);
                return;
            }
            if (password !== repeatedPassword) {
                alert(window.I18N.passwordMismatch);
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/public/users", {
                account: account,
                name: name,
                password: password
            }, function () {
                window.location.href = "${pageContext.request.contextPath}/";
            });
        }
    </script>
</head>
<body>
<main class="auth-panel">
    <h1><spring:message code="auth.signup"/></h1>
    <nav class="language-switch">
        <a href="?lang=zh-CN"><spring:message code="language.zh"/></a>
        <a href="?lang=en-US"><spring:message code="language.en"/></a>
    </nav>
    <form action="">
        <div class="field">
            <label for="account"><spring:message code="auth.account"/></label>
            <input type="text" id="account" autocomplete="username" />
        </div>
        <div class="field">
            <label for="name"><spring:message code="auth.name"/></label>
            <input type="text" id="name" />
        </div>
        <div class="field">
            <label for="password"><spring:message code="auth.password"/></label>
            <input type="password" id="password" autocomplete="new-password" />
        </div>
        <div class="field">
            <label for="repassword"><spring:message code="auth.repeatPassword"/></label>
            <input type="password" id="repassword" autocomplete="new-password" />
        </div>
        <button class="primary" type="button" onclick="register()"><spring:message code="auth.signup"/></button>
    </form>
    <p><a href="${pageContext.request.contextPath}/"><spring:message code="common.back"/></a></p>
</main>
</body>
</html>
