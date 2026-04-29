<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="admin-shell">
    <aside class="admin-sidebar farmer-sidebar">
        <div class="admin-brand">${businessType == 'BREED' ? '养殖户工作台' : '种植户工作台'}</div>
        <div class="admin-subtitle">商户后台</div>
        <nav class="admin-menu">
            <a class="admin-menu-item ${pageTitle == businessTitle ? 'active' : ''}" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/dashboard">数据看台</a>
            <a class="admin-menu-item ${pageTitle == '种植周期管理' || pageTitle == '养殖周期管理' || pageTitle == '新增种植周期' || pageTitle == '新增养殖周期' || pageTitle == '编辑种植周期' || pageTitle == '编辑养殖周期' ? 'active' : ''}" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/cycles">周期管理</a>
            <a class="admin-menu-item ${pageTitle == '种植环节记录' || pageTitle == '养殖环节记录' || pageTitle == '新增种植记录' || pageTitle == '新增养殖记录' || pageTitle == '编辑种植记录' || pageTitle == '编辑养殖记录' ? 'active' : ''}" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/records">环节记录</a>
            <a class="admin-menu-item ${pageTitle == '我的农产品' || pageTitle == '新增农产品' || pageTitle == '编辑农产品' ? 'active' : ''}" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/products">农产品管理</a>
            <a class="admin-menu-item ${pageTitle == '订单管理' ? 'active' : ''}" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/orders">订单管理</a>
            <a class="admin-menu-item ${pageTitle == '评价管理' ? 'active' : ''}" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/comments">评价管理</a>
            <a class="admin-menu-item ${pageTitle == '个人信息' ? 'active' : ''}" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/profile">个人信息</a>
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
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger">${errorMsg}</div>
        </c:if>
