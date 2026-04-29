<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <div class="text-muted">我的农产品</div>
        <div class="table-toolbar-actions">
            <form class="table-search-form" method="get" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/products">
                <input class="form-control" type="text" name="keyword" value="${keyword}" placeholder="搜索产品名称、分类、状态">
                <button class="btn btn-outline-success" type="submit">搜索</button>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/products">重置</a>
            </form>
            <a class="btn btn-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/products/add">新增产品</a>
        </div>
    </div>
    <table class="table admin-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>图片</th>
            <th>产品名称</th>
            <th>分类</th>
            <th>价格</th>
            <th>库存</th>
            <th>销量</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.records}" var="item" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>
                    <c:if test="${not empty item.mainImage}">
                        <img src="${item.mainImage}" alt="${item.productName}" class="table-thumb">
                    </c:if>
                </td>
                <td>${item.productName}</td>
                <td>${item.categoryName}</td>
                <td>&yen;${item.price}/${item.unit}</td>
                <td>${item.stock}</td>
                <td>${item.salesCount}</td>
                <td>
                    <span class="status-chip ${item.status == 'ON_SALE' ? 'status-on-sale' : 'status-off-shelf'}">
                        ${item.status == 'ON_SALE' ? '上架中' : '已下架'}
                    </span>
                </td>
                <td>
                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/products/edit/${item.id}">编辑</a>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/products/delete/${item.id}">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
