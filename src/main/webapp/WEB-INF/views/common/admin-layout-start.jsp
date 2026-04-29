<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-brand">绿色农产品平台</div>
        <div class="admin-subtitle">管理员后台</div>
        <nav class="admin-menu">
            <a class="admin-menu-item ${activeMenu == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/dashboard">数据看台</a>
            <a class="admin-menu-item ${activeMenu == 'users' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/users">用户管理</a>
            <a class="admin-menu-item ${activeMenu == 'templates' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/templates">环节模板管理</a>
            <a class="admin-menu-item ${activeMenu == 'cycles' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/cycles">种养殖周期管理</a>
            <a class="admin-menu-item ${activeMenu == 'productCategories' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/product-categories">产品分类管理</a>
            <a class="admin-menu-item ${activeMenu == 'products' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/products">产品管理</a>
            <a class="admin-menu-item ${activeMenu == 'orders' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/orders">订单管理</a>
            <a class="admin-menu-item ${activeMenu == 'comments' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/comments">评价管理</a>
            <a class="admin-menu-item ${activeMenu == 'notices' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/notices">公告管理</a>
            <a class="admin-menu-item ${activeMenu == 'operations' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/banners">轮播图管理</a>
            <a class="admin-menu-item ${activeMenu == 'profile' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/profile">个人信息</a>
        </nav>
    </aside>
    <main class="admin-main">
        <div class="admin-topbar">
            <div>
                <h1 class="admin-page-title">${pageTitle}</h1>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/portal/home" class="btn btn-light btn-sm mr-2">首页</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-secondary btn-sm">退出</a>
            </div>
        </div>
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success">${successMsg}</div>
        </c:if>
