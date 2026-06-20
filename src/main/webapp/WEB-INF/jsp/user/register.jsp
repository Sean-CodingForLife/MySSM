<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="auth.signup"/></title>
    <%@ include file="../common/assets.jsp" %>
    <script type="text/javascript">
        window.I18N = {
            registerRequired: "<spring:message code="auth.required.register"/>",
            passwordMin: "<spring:message code="auth.password.min"/>",
            passwordMismatch: "<spring:message code="auth.password.mismatch"/>",
            loading: "<spring:message code="common.loading"/>",
            requestFailed: "<spring:message code="common.requestFailed"/>"
        };

        function register() {
            var account = $("#account").val();
            var name = $("#name").val();
            var password = $("#password").val();
            var repeatedPassword = $("#repassword").val();

            if (!account || !name || !password) {
                notifyApp(window.I18N.registerRequired, "error");
                return;
            }
            if (password.length < 8) {
                notifyApp(window.I18N.passwordMin, "error");
                return;
            }
            if (password !== repeatedPassword) {
                notifyApp(window.I18N.passwordMismatch, "error");
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
<main class="auth-panel card">
    <div class="card-body">
        <div class="d-flex align-items-start justify-content-between gap-3 mb-4">
            <h1 class="h3 mb-0"><spring:message code="auth.signup"/></h1>
            <nav class="language-switch">
                <a href="?lang=zh-CN"><spring:message code="language.zh"/></a>
                <a href="?lang=en-US"><spring:message code="language.en"/></a>
            </nav>
        </div>
        <form action="" onsubmit="register(); return false;">
            <div class="mb-3">
                <label class="form-label" for="account"><spring:message code="auth.account"/></label>
                <input class="form-control" type="text" id="account" autocomplete="username" />
            </div>
            <div class="mb-3">
                <label class="form-label" for="name"><spring:message code="auth.name"/></label>
                <input class="form-control" type="text" id="name" />
            </div>
            <div class="mb-3">
                <label class="form-label" for="password"><spring:message code="auth.password"/></label>
                <input class="form-control" type="password" id="password" autocomplete="new-password" />
            </div>
            <div class="mb-4">
                <label class="form-label" for="repassword"><spring:message code="auth.repeatPassword"/></label>
                <input class="form-control" type="password" id="repassword" autocomplete="new-password" />
            </div>
            <div class="d-grid gap-2">
                <button class="btn btn-primary" type="submit"><spring:message code="auth.signup"/></button>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/"><spring:message code="common.back"/></a>
            </div>
        </form>
    </div>
</main>
</body>
</html>
