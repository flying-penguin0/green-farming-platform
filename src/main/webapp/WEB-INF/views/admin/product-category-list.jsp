<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="产品分类管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/product-categories">
            <select class="form-control mr-2" name="status">
                <option value="">全部状态</option>
                <option value="ENABLED" ${status == 'ENABLED' ? 'selected' : ''}>启用</option>
                <option value="DISABLED" ${status == 'DISABLED' ? 'selected' : ''}>禁用</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索分类名称">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/product-categories">重置</a>
        </form>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/product-categories/add">新增分类</a>
    </div>

    <table class="table admin-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>分类名称</th>
            <th>状态</th>
            <th>创建时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.records}" var="item" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${item.categoryName}</td>
                <td>
                    <span class="status-chip ${item.status == 'ENABLED' ? 'status-enabled' : 'status-disabled'}">
                        ${item.status == 'ENABLED' ? '启用' : '禁用'}
                    </span>
                </td>
                <td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/product-categories/edit/${item.id}">编辑</a>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/product-categories/delete/${item.id}" onclick="return confirm('确认删除该分类吗？');">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
