<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${businessTitle}"/>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>
<div class="row">
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>${stats.cycleCount}</h3><p>我的周期</p></div></div>
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>${stats.productCount}</h3><p>我的产品</p></div></div>
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>${stats.orderCount}</h3><p>我的订单</p></div></div>
    <div class="col-md-3 mb-4"><div class="stat-card"><h3>¥ ${stats.totalAmount}</h3><p>累计销售额</p></div></div>
</div>
<div class="panel-card">
    <div class="mb-3">
        <h5 class="mb-1">${businessTitle}</h5>
        <p class="text-muted mb-0">这里可以继续管理周期、环节记录、农产品与订单，形成卖家端完整业务流程。</p>
    </div>
    <div id="sellerChart" class="chart-box-lg"></div>
</div>
<script>
window.dashboardStats={cycleCount:${stats.cycleCount},productCount:${stats.productCount},orderCount:${stats.orderCount},totalAmount:${stats.totalAmount}};
window.dashboardMode='${businessType}';
</script>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
