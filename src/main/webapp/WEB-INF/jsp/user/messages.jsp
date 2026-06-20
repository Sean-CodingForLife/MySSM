<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="user.messages.title"/></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title"><spring:message code="user.messages.title"/></h1>
            <p class="breadcrumb"><spring:message code="user.messages.breadcrumb"/></p>
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
        <div class="empty-state visible">
            <spring:message code="user.messages.empty"/>
        </div>
    </section>
</main>
</body>
</html>
