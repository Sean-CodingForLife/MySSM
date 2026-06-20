<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="user.messages.title"/></title>
    <%@ include file="../common/assets.jsp" %>
</head>
<body>
<spring:message code="user.messages.title" var="pageTitle"/>
<% request.setAttribute("activeNav", "messages"); %>
<%@ include file="../common/app-shell-start.jsp" %>
    <header class="content-header">
        <div>
            <h1><spring:message code="user.messages.title"/></h1>
            <p><spring:message code="user.messages.breadcrumb"/></p>
        </div>
    </header>

    <section class="card table-panel">
        <div class="empty-state visible">
            <spring:message code="user.messages.empty"/>
        </div>
    </section>
<%@ include file="../common/app-shell-end.jsp" %>
</body>
</html>
