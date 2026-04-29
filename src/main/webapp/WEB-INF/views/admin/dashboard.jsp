<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="管理员数据看台"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="row">
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>${stats.cycleCount}</h3><p>周期总数</p></div></div>
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>${stats.productCount}</h3><p>产品总数</p></div></div>
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>${stats.orderCount}</h3><p>订单总数</p></div></div>
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>¥ ${stats.totalAmount}</h3><p>平台交易额</p></div></div>
</div>

<div class="panel-card">
    <div class="mb-3">
        <h5 class="mb-1">平台运营概览</h5>
        <p class="text-muted mb-0">当前已接入用户、环节模板、种养殖周期、产品、订单、评价、公告和首页运营管理模块。</p>
    </div>
    <div id="adminChart" class="chart-box-lg"></div>
</div>

<script>
    window.dashboardStats = {
        cycleCount: ${stats.cycleCount},
        productCount: ${stats.productCount},
        orderCount: ${stats.orderCount},
        totalAmount: ${stats.totalAmount}
    };
    window.dashboardMode = 'admin';
</script>

<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
