<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="error.notFound.title"/></title>
    <%@ include file="common/assets.jsp" %>
</head>
<body>
<main class="auth-panel card">
    <div class="card-body">
        <h1 class="h3"><spring:message code="error.notFound.title"/></h1>
        <p class="text-secondary"><spring:message code="error.notFound.text"/></p>
        <a class="btn btn-primary w-100" href="${pageContext.request.contextPath}/"><spring:message code="error.backHome"/></a>
    </div>
</main>
</body>
</html>
