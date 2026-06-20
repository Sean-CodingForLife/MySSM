<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="dashboard.title"/></title>
    <%@ include file="common/assets.jsp" %>
</head>
<body>
<spring:message code="dashboard.title" var="pageTitle"/>
<% request.setAttribute("activeNav", "dashboard"); %>
<%@ include file="common/app-shell-start.jsp" %>
    <header class="content-header">
        <div>
            <h1><spring:message code="dashboard.title"/></h1>
            <p><spring:message code="app.tagline"/></p>
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
<%@ include file="common/app-shell-end.jsp" %>
</body>
</html>
