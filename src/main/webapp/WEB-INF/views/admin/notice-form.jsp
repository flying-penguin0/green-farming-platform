<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${formTitle}"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/admin/notices/save">
        <input type="hidden" name="id" value="${entity.id}">
        <div class="form-row">
            <div class="form-group col-md-8">
                <label>公告标题</label>
                <input type="text" class="form-control" name="title" value="${entity.title}" required>
            </div>
            <div class="form-group col-md-4">
                <label>发布状态</label>
                <select class="form-control" name="publishStatus">
                    <option value="PUBLISHED" ${entity.publishStatus == 'PUBLISHED' ? 'selected' : ''}>已发布</option>
                    <option value="DRAFT" ${entity.publishStatus == 'DRAFT' ? 'selected' : ''}>草稿</option>
                </select>
            </div>
            <div class="form-group col-md-12">
                <label>公告内容</label>
                <textarea class="form-control" rows="6" name="content">${entity.content}</textarea>
            </div>
        </div>
        <div class="form-actions">
            <button class="btn btn-success" type="submit">保存</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/notices">返回</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
