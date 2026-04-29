<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <div class="text-muted">${businessType == 'BREED' ? '养殖周期列表' : '种植周期列表'}</div>
        <div class="table-toolbar-actions">
            <form class="table-search-form" method="get" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/cycles">
                <input class="form-control" type="text" name="keyword" value="${keyword}" placeholder="搜索周期名称、对象、状态">
                <button class="btn btn-outline-success" type="submit">搜索</button>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/cycles">重置</a>
            </form>
            <a class="btn btn-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/cycles/add">新增周期</a>
        </div>
    </div>
    <table class="table admin-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>名称</th>
            <th>对象</th>
            <th>规模</th>
            <th>状态</th>
            <th>公开</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.records}" var="item" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${item.cycleName}</td>
                <td>${item.itemName}</td>
                <td><fmt:formatNumber value="${item.scaleValue}" pattern="0.##"/>${item.scaleUnit}</td>
                <td>
                    <span class="status-chip ${item.status == 'ONGOING' ? 'status-on-sale' : 'status-off-shelf'}">
                        ${item.status == 'ONGOING' ? '进行中' : '已完成'}
                    </span>
                </td>
                <td>${item.isPublic == 1 ? '是' : '否'}</td>
                <td>
                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/cycles/edit/${item.id}">编辑</a>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/cycles/delete/${item.id}">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
