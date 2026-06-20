<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="dashboard.title"/></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function logout() {
            deleteRequest("${pageContext.request.contextPath}/api/session", {}, function () {
                window.location.href = "${pageContext.request.contextPath}/";
            });
        }
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title"><spring:message code="dashboard.title"/></h1>
            <p class="breadcrumb"><spring:message code="dashboard.signedIn"/> ${loginRole}: ${loginAccount}</p>
        </div>
        <div class="page-actions">
            <nav class="language-switch">
                <a href="?lang=zh-CN"><spring:message code="language.zh"/></a>
                <a href="?lang=en-US"><spring:message code="language.en"/></a>
            </nav>
            <button type="button" onclick="logout()"><spring:message code="auth.logout"/></button>
        </div>
    </header>

    <section class="dashboard-grid">
        <% if ("ADMIN".equals(request.getAttribute("loginRole"))) { %>
        <a href="${pageContext.request.contextPath}/admin/users"><spring:message code="dashboard.users"/></a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/user/profile"><spring:message code="dashboard.profile"/></a>
        <a href="${pageContext.request.contextPath}/user/messages"><spring:message code="dashboard.messages"/></a>
        <a href="${pageContext.request.contextPath}/user/settings"><spring:message code="dashboard.settings"/></a>
        <% } %>
    </section>
</main>
</body>
</html>
