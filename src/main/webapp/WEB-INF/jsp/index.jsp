<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="app.name"/></title>
    <%@ include file="common/assets.jsp" %>
    <script type="text/javascript">
        window.I18N = {
            accountPasswordRequired: "<spring:message code="auth.required.accountPassword"/>",
            captchaRequired: "<spring:message code="auth.captcha.required"/>",
            requestFailed: "<spring:message code="common.requestFailed"/>"
        };

        function refreshCaptcha() {
            $("#captchaImage").attr("src", "${pageContext.request.contextPath}/api/captcha?_=" + new Date().getTime());
            $("#captcha").val("");
        }

        function login() {
            var account = $("#account").val();
            var password = $("#password").val();
            var captcha = $("#captcha").val();
            if (!account || !password) {
                notifyApp(window.I18N.accountPasswordRequired, "error");
                return;
            }
            if (!captcha) {
                notifyApp(window.I18N.captchaRequired, "error");
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/session", {
                account: account,
                password: password,
                captcha: captcha
            }, function () {
                window.location.href = "${pageContext.request.contextPath}/dashboard";
            }, {
                onFail: refreshCaptcha,
                onError: refreshCaptcha
            });
        }

        function logUp() {
            window.location.href = "${pageContext.request.contextPath}/user/register";
        }
    </script>
</head>
<body class="site-body">
<div id="top"></div>
<header class="site-nav">
    <a class="site-brand" href="${pageContext.request.contextPath}/"><spring:message code="app.name"/></a>
    <nav class="language-switch">
        <a href="?lang=zh-CN"><spring:message code="language.zh"/></a>
        <a href="?lang=en-US"><spring:message code="language.en"/></a>
    </nav>
</header>

<main class="site-main">
    <section class="site-hero">
        <div class="hero-copy">
            <p class="hero-eyebrow"><spring:message code="app.workspace"/></p>
            <h1><spring:message code="app.name"/></h1>
            <p class="hero-lead">
                <spring:message code="app.hero.lead"/>
            </p>
            <div class="hero-stats">
                <div>
                    <strong><spring:message code="hero.role.title"/></strong>
                    <span><spring:message code="hero.role.text"/></span>
                </div>
                <div>
                    <strong><spring:message code="hero.rest.title"/></strong>
                    <span><spring:message code="hero.rest.text"/></span>
                </div>
                <div>
                    <strong><spring:message code="hero.data.title"/></strong>
                    <span><spring:message code="hero.data.text"/></span>
                </div>
            </div>
        </div>

        <aside class="login-entry">
            <p class="login-entry-label"><spring:message code="auth.signIn"/></p>
            <form action="" onsubmit="login(); return false;">
                <div class="mb-3">
                    <label class="form-label" for="account"><spring:message code="auth.account"/></label>
                    <input class="form-control" type="text" id="account" autocomplete="username" />
                </div>
                <div class="mb-3">
                    <label class="form-label" for="password"><spring:message code="auth.password"/></label>
                    <input class="form-control" type="password" id="password" autocomplete="current-password" />
                </div>
                <div class="mb-3">
                    <label class="form-label" for="captcha"><spring:message code="auth.captcha"/></label>
                    <div class="captcha-row">
                        <input class="form-control" type="text" id="captcha" autocomplete="off" />
                        <img id="captchaImage"
                             src="${pageContext.request.contextPath}/api/captcha"
                             alt="<spring:message code="auth.captcha"/>"
                             onclick="refreshCaptcha()" />
                    </div>
                </div>
                <div class="d-grid gap-2">
                    <button class="btn btn-primary" type="submit"><spring:message code="auth.login"/></button>
                    <button class="btn btn-outline-primary" type="button" onclick="logUp()"><spring:message code="auth.signup"/></button>
                </div>
            </form>
        </aside>
    </section>
</main>

<footer class="site-footer">
    <div>
        <strong><spring:message code="app.name"/></strong>
        <span><spring:message code="app.footer"/></span>
    </div>
    <nav>
        <a href="#top"><spring:message code="nav.about"/></a>
        <a href="#top"><spring:message code="nav.privacy"/></a>
        <a href="#top"><spring:message code="nav.terms"/></a>
        <a href="#top"><spring:message code="nav.contact"/></a>
    </nav>
</footer>
</body>
</html>
