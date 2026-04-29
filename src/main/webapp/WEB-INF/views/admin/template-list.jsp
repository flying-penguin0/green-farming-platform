<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="环节模板管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/templates">
            <select class="form-control mr-2" name="businessType">
                <option value="">全部业务</option>
                <option value="PLANT" ${businessType == 'PLANT' ? 'selected' : ''}>种植</option>
                <option value="BREED" ${businessType == 'BREED' ? 'selected' : ''}>养殖</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索环节名称">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/templates">重置</a>
        </form>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/templates/add">新增模板</a>
    </div>

    <table class="table admin-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>模板名称</th>
            <th>业务类型</th>
            <th>状态</th>
            <th>备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.records}" var="item" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${item.templateName}</td>
                <td>
                    <span class="table-tag ${item.businessType == 'PLANT' ? 'table-tag-role-planter' : 'table-tag-role-breeder'}">
                        ${item.businessType == 'PLANT' ? '种植' : '养殖'}
                    </span>
                </td>
                <td>
                    <span class="status-chip ${item.status == 'ENABLED' ? 'status-enabled' : 'status-disabled'}">
                        ${item.status == 'ENABLED' ? '启用' : '禁用'}
                    </span>
                </td>
                <td>${item.remark}</td>
                <td>
                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/templates/edit/${item.id}">编辑</a>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/templates/delete/${item.id}" onclick="return confirm('确认删除该模板吗？');">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
