<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${formTitle}"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/admin/templates/save">
        <input type="hidden" name="id" value="${entity.id}">

        <div class="form-row">
            <div class="form-group col-md-6">
                <label>模板名称</label>
                <input type="text" class="form-control" name="templateName" value="${entity.templateName}" required>
            </div>
            <div class="form-group col-md-3">
                <label>业务类型</label>
                <select class="form-control" name="businessType">
                    <option value="PLANT" ${entity.businessType == 'PLANT' ? 'selected' : ''}>种植</option>
                    <option value="BREED" ${entity.businessType == 'BREED' ? 'selected' : ''}>养殖</option>
                </select>
            </div>
            <div class="form-group col-md-3">
                <label>状态</label>
                <select class="form-control" name="status">
                    <option value="ENABLED" ${entity.status == 'ENABLED' ? 'selected' : ''}>启用</option>
                    <option value="DISABLED" ${entity.status == 'DISABLED' ? 'selected' : ''}>禁用</option>
                </select>
            </div>
            <div class="form-group col-md-12">
                <label>备注</label>
                <input type="text" class="form-control" name="remark" value="${entity.remark}">
            </div>
        </div>

        <div class="form-actions">
            <button class="btn btn-success" type="submit">保存</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/templates">返回</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
