<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="user.profile.title"/></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title"><spring:message code="user.profile.title"/></h1>
            <p class="breadcrumb"><spring:message code="user.profile.breadcrumb"/></p>
        </div>
        <div class="page-actions">
            <nav class="language-switch">
                <a href="?lang=zh-CN"><spring:message code="language.zh"/></a>
                <a href="?lang=en-US"><spring:message code="language.en"/></a>
            </nav>
            <a class="button-link" href="${pageContext.request.contextPath}/dashboard"><spring:message code="common.back"/></a>
        </div>
    </header>

    <section class="table-panel">
        <table class="data-table">
            <tbody>
            <tr>
                <th><spring:message code="common.account"/></th>
                <td>${sessionScope.loginAccount}</td>
            </tr>
            <tr>
                <th><spring:message code="dashboard.signedIn"/></th>
                <td>${sessionScope.loginRole}</td>
            </tr>
            <tr>
                <th><spring:message code="common.status"/></th>
                <td><spring:message code="common.active"/></td>
            </tr>
            </tbody>
        </table>
    </section>
</main>
</body>
</html>
