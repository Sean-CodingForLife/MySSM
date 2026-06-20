<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
    <title>User Center</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/my.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/requests.js"></script>
    <script type="text/javascript">
        function logout() {
            deleteRequest("${pageContext.request.contextPath}/api/user/session", {}, function () {
                window.location.href = "${pageContext.request.contextPath}/user/login";
            });
        }
    </script>
</head>
<body>
<main class="app-shell">
    <header class="page-header">
        <div>
            <h1 class="page-title">User Center</h1>
            <p class="breadcrumb">Welcome, ${sessionScope.userAccount}</p>
        </div>
        <button type="button" onclick="logout()">Logout</button>
    </header>

    <section class="table-panel">
        <div class="empty-state" style="display:block;">
            User-facing features are separated from administrator-only management pages.
        </div>
    </section>
</main>
</body>
</html>
