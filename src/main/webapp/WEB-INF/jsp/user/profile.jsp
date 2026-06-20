<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="user.profile.title"/></title>
    <%@ include file="../common/assets.jsp" %>
</head>
<body>
<spring:message code="user.profile.title" var="pageTitle"/>
<% request.setAttribute("activeNav", "profile"); %>
<%@ include file="../common/app-shell-start.jsp" %>
    <header class="content-header">
        <div>
            <h1><spring:message code="user.profile.title"/></h1>
            <p><spring:message code="user.profile.breadcrumb"/></p>
        </div>
    </header>

    <section class="card table-panel">
        <table class="table align-middle mb-0">
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
<%@ include file="../common/app-shell-end.jsp" %>
</body>
</html>
