<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="user.settings.title"/></title>
    <%@ include file="../common/assets.jsp" %>
</head>
<body>
<spring:message code="user.settings.title" var="pageTitle"/>
<% request.setAttribute("activeNav", "settings"); %>
<%@ include file="../common/app-shell-start.jsp" %>
    <header class="content-header">
        <div>
            <h1><spring:message code="user.settings.title"/></h1>
            <p><spring:message code="user.settings.breadcrumb"/></p>
        </div>
    </header>

    <section class="card table-panel">
        <table class="table align-middle mb-0">
            <tbody>
            <tr>
                <th><spring:message code="user.sessionAccount"/></th>
                <td>${sessionScope.loginAccount}</td>
            </tr>
            <tr>
                <th><spring:message code="user.accessScope"/></th>
                <td><spring:message code="user.center"/></td>
            </tr>
            <tr>
                <th><spring:message code="user.security"/></th>
                <td><spring:message code="user.securityText"/></td>
            </tr>
            </tbody>
        </table>
    </section>
<%@ include file="../common/app-shell-end.jsp" %>
</body>
</html>
