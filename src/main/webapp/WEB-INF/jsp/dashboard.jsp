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
        <%
            java.util.List<?> dashboardMenus = (java.util.List<?>) session.getAttribute("loginMenus");
            if (dashboardMenus != null) {
                for (Object item : dashboardMenus) {
                    com.po.Menu menu = (com.po.Menu) item;
        %>
        <a href="${pageContext.request.contextPath}<%= menu.getPath() %>"><%= menu.getName() %></a>
        <%      }
            }
        %>
    </section>
<%@ include file="common/app-shell-end.jsp" %>
</body>
</html>
