<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark app-navbar">
    <div class="container">
        <a class="navbar-brand font-weight-bold" href="${pageContext.request.contextPath}/portal/home">绿色农产品种养殖平台</a>
        <div class="portal-nav-links mx-auto">
            <a class="portal-nav-link ${portalNav == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/portal/home">首页</a>
            <a class="portal-nav-link ${portalNav == 'plant' ? 'active' : ''}" href="${pageContext.request.contextPath}/portal/plant-cycles">种植周期</a>
            <a class="portal-nav-link ${portalNav == 'breed' ? 'active' : ''}" href="${pageContext.request.contextPath}/portal/breed-cycles">养殖周期</a>
            <a class="portal-nav-link ${portalNav == 'products' ? 'active' : ''}" href="${pageContext.request.contextPath}/portal/products">农产品</a>
            <a class="portal-nav-link ${portalNav == 'notices' ? 'active' : ''}" href="${pageContext.request.contextPath}/portal/notices">平台公告</a>
        </div>
        <div class="portal-nav-actions">
            <c:choose>
                <c:when test="${empty sessionScope.loginUser}">
                    <a class="btn btn-outline-light btn-sm mr-2" href="${pageContext.request.contextPath}/auth/login">登录</a>
                    <a class="btn btn-light btn-sm" href="${pageContext.request.contextPath}/auth/register">注册用户</a>
                </c:when>
                <c:otherwise>
                    <div class="portal-user-chip mr-2">
                        <span class="portal-user-name">欢迎你，${empty sessionScope.loginUser.realName ? sessionScope.loginUser.username : sessionScope.loginUser.realName}</span>
                        <span class="portal-user-role">
                            <c:choose>
                                <c:when test="${sessionScope.loginUser.roleType == 'ADMIN'}">管理员</c:when>
                                <c:when test="${sessionScope.loginUser.roleType == 'PLANTER'}">种植户</c:when>
                                <c:when test="${sessionScope.loginUser.roleType == 'BREEDER'}">养殖户</c:when>
                                <c:otherwise>普通用户</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.roleType == 'ADMIN'}">
                            <a class="btn btn-light btn-sm mr-2" href="${pageContext.request.contextPath}/admin/dashboard">进入系统</a>
                        </c:when>
                        <c:when test="${sessionScope.loginUser.roleType == 'PLANTER'}">
                            <a class="btn btn-light btn-sm mr-2" href="${pageContext.request.contextPath}/farmer/plant/dashboard">进入系统</a>
                        </c:when>
                        <c:when test="${sessionScope.loginUser.roleType == 'BREEDER'}">
                            <a class="btn btn-light btn-sm mr-2" href="${pageContext.request.contextPath}/farmer/breed/dashboard">进入系统</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-light btn-sm mr-2" href="${pageContext.request.contextPath}/user/center">进入系统</a>
                        </c:otherwise>
                    </c:choose>
                    <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/auth/logout">退出</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
