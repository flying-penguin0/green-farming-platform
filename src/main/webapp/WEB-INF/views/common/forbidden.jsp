<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container py-5">
    <div class="panel-card text-center">
        <h2 class="mb-3">无权访问</h2>
        <p class="text-muted">当前账号没有权限访问这个页面，请返回首页或重新登录正确的角色账号。</p>
        <a class="btn btn-success mr-2" href="${pageContext.request.contextPath}/portal/home">返回首页</a>
        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/auth/login">重新登录</a>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
