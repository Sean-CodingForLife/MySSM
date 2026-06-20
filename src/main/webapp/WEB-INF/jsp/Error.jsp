<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="error.notFound.title"/></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
</head>
<body>
<main class="auth-panel">
    <h1><spring:message code="error.notFound.title"/></h1>
    <p><spring:message code="error.notFound.text"/></p>
    <p><a class="button-link primary" href="${pageContext.request.contextPath}/"><spring:message code="error.backHome"/></a></p>
</main>
</body>
</html>
