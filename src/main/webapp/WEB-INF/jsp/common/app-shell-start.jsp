<%
    String activeNav = String.valueOf(request.getAttribute("activeNav"));
    String loginRole = String.valueOf(session.getAttribute("loginRole"));
    boolean isAdmin = "ADMIN".equals(loginRole);
%>
<div class="app-frame">
    <aside class="app-sidebar">
        <a class="app-brand" href="${pageContext.request.contextPath}/dashboard">
            <span class="app-brand-mark">M</span>
            <span><spring:message code="app.name"/></span>
        </a>
        <nav class="nav nav-pills flex-column app-menu">
            <a class="nav-link <%= "dashboard".equals(activeNav) ? "active" : "" %>"
               href="${pageContext.request.contextPath}/dashboard">
                <spring:message code="dashboard.title"/>
            </a>
            <% if (isAdmin) { %>
            <a class="nav-link <%= "users".equals(activeNav) ? "active" : "" %>"
               href="${pageContext.request.contextPath}/admin/users">
                <spring:message code="dashboard.users"/>
            </a>
            <% } else { %>
            <a class="nav-link <%= "profile".equals(activeNav) ? "active" : "" %>"
               href="${pageContext.request.contextPath}/user/profile">
                <spring:message code="dashboard.profile"/>
            </a>
            <a class="nav-link <%= "messages".equals(activeNav) ? "active" : "" %>"
               href="${pageContext.request.contextPath}/user/messages">
                <spring:message code="dashboard.messages"/>
            </a>
            <a class="nav-link <%= "settings".equals(activeNav) ? "active" : "" %>"
               href="${pageContext.request.contextPath}/user/settings">
                <spring:message code="dashboard.settings"/>
            </a>
            <% } %>
        </nav>
    </aside>

    <div class="app-main">
        <header class="app-topbar">
            <div>
                <div class="app-topbar-title">${pageTitle}</div>
                <div class="app-topbar-subtitle"><spring:message code="dashboard.signedIn"/> ${sessionScope.loginRole}: ${sessionScope.loginAccount}</div>
            </div>
            <div class="app-topbar-actions">
                <nav class="language-switch">
                    <a href="?lang=zh-CN"><spring:message code="language.zh"/></a>
                    <a href="?lang=en-US"><spring:message code="language.en"/></a>
                </nav>
                <button class="btn btn-outline-danger btn-sm" type="button" onclick="logoutApp('${pageContext.request.contextPath}')">
                    <spring:message code="auth.logout"/>
                </button>
            </div>
        </header>

        <main class="app-content">
