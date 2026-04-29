<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty pageTitle ? '首页运营管理' : pageTitle}"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/banners">
            <select class="form-control mr-2" name="status">
                <option value="">全部状态</option>
                <option value="ENABLED" ${status == 'ENABLED' ? 'selected' : ''}>已启用</option>
                <option value="DISABLED" ${status == 'DISABLED' ? 'selected' : ''}>已停用</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索轮播图标题">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/banners">重置</a>
        </form>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/banners/add">新增轮播图</a>
    </div>

    <div class="table-responsive">
        <table class="table admin-table">
            <thead>
            <tr>
                <th>编号</th>
                <th>轮播图</th>
                <th>标题</th>
                <th>排序</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageResult.records}" var="item" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td><img src="${item.imageUrl}" alt="${item.title}" class="table-thumb"></td>
                    <td>${item.title}</td>
                    <td>${item.sortNo}</td>
                    <td>
                        <span class="table-tag ${item.status == 'ENABLED' ? '' : 'table-tag-muted'}">
                            ${item.status == 'ENABLED' ? '已启用' : '已停用'}
                        </span>
                    </td>
                    <td>
                        <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/banners/edit/${item.id}">编辑</a>
                        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/banners/delete/${item.id}" onclick="return confirm('确认删除该轮播图吗？');">删除</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty pageResult.records}">
                <tr>
                    <td colspan="6" class="text-center text-muted py-4">暂无轮播图数据</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
