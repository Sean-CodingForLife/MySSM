<%
    String activeNav = String.valueOf(request.getAttribute("activeNav"));
    java.util.List<?> loginMenus = (java.util.List<?>) session.getAttribute("loginMenus");
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
            <% if (loginMenus != null) {
                for (Object item : loginMenus) {
                    com.po.Menu menu = (com.po.Menu) item;
            %>
            <a class="nav-link <%= menu.getCode().equals(activeNav) ? "active" : "" %>"
               href="${pageContext.request.contextPath}<%= menu.getPath() %>">
                <%= menu.getName() %>
            </a>
            <%  }
            } %>
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
