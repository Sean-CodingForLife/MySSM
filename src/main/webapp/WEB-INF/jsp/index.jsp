<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="app.name"/></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        window.I18N = {
            accountPasswordRequired: "<spring:message code="auth.required.accountPassword"/>",
            requestFailed: "<spring:message code="common.requestFailed"/>"
        };

        function login() {
            var account = $("#account").val();
            var password = $("#password").val();
            if (!account || !password) {
                alert(window.I18N.accountPasswordRequired);
                return;
            }

            postRequest("${pageContext.request.contextPath}/api/session", {
                account: account,
                password: password
            }, function () {
                window.location.href = "${pageContext.request.contextPath}/dashboard";
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
                <div class="field">
                    <label for="account"><spring:message code="auth.account"/></label>
                    <input type="text" id="account" autocomplete="username" />
                </div>
                <div class="field">
                    <label for="password"><spring:message code="auth.password"/></label>
                    <input type="password" id="password" autocomplete="current-password" />
                </div>
                <div class="login-actions">
                    <button class="primary" type="submit"><spring:message code="auth.login"/></button>
                    <button type="button" onclick="logUp()"><spring:message code="auth.signup"/></button>
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
