<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="产品分类管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/admin/product-categories/save">
        <input type="hidden" name="id" value="${entity.id}">
        <div class="form-row">
            <div class="form-group col-md-8">
                <label>分类名称</label>
                <input class="form-control" type="text" name="categoryName" value="${entity.categoryName}" required>
            </div>
            <div class="form-group col-md-4">
                <label>状态</label>
                <select class="form-control" name="status">
                    <option value="ENABLED" ${entity.status == 'ENABLED' ? 'selected' : ''}>启用</option>
                    <option value="DISABLED" ${entity.status == 'DISABLED' ? 'selected' : ''}>禁用</option>
                </select>
            </div>
        </div>
        <div class="form-actions">
            <button class="btn btn-success" type="submit">保存</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/product-categories">返回列表</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
