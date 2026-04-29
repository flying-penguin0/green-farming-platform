<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container py-5">
    <div class="panel-card">
        <h2 class="mb-3">系统说明</h2>
        <p class="text-muted">本系统为绿色农产品种养殖平台毕设项目，采用 JSP + SSM + MySQL 实现，支持管理员、种植户、养殖户、普通用户四类角色。</p>
        <ul class="mb-0">
            <li>管理员负责平台数据维护与业务审核</li>
            <li>种植户、养殖户负责周期、记录、农产品、订单管理</li>
            <li>普通用户负责浏览、下单、收货与评价</li>
            <li>系统支持农产品溯源、数据看台、图片上传与基础分页</li>
        </ul>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
