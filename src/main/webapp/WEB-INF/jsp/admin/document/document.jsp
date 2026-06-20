<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Document Management</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title">Document Management</h1>
            <p class="breadcrumb">Admin Console / Documents</p>
        </div>
        <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
    </header>

    <section class="table-panel">
        <div class="empty-state" style="display:block;">
            Document management has a page route, but no document API has been implemented yet.
        </div>
    </section>
</main>
</body>
</html>
