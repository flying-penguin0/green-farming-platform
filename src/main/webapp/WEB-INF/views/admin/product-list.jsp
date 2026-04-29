<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="产品管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/products">
            <select class="form-control mr-2" name="status">
                <option value="">全部状态</option>
                <option value="ON_SALE" ${status == 'ON_SALE' ? 'selected' : ''}>上架</option>
                <option value="OFF_SHELF" ${status == 'OFF_SHELF' ? 'selected' : ''}>下架</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索产品/卖家/分类">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/products">重置</a>
        </form>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/products/add">新增产品</a>
    </div>
    <div class="table-responsive">
        <table class="table admin-table">
            <thead>
            <tr>
                <th>编号</th>
                <th>图片</th>
                <th>产品名称</th>
                <th>分类</th>
                <th>卖家</th>
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
                    <td>${item.sellerName}</td>
                    <td>¥ ${item.price}/${item.unit}</td>
                    <td>${item.stock}</td>
                    <td>${item.salesCount}</td>
                    <td>
                        <span class="status-chip ${item.status == 'ON_SALE' ? 'status-on-sale' : 'status-off-shelf'}">
                            ${item.status == 'ON_SALE' ? '上架中' : '已下架'}
                        </span>
                    </td>
                    <td>
                        <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/products/edit/${item.id}">编辑</a>
                        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/products/delete/${item.id}" onclick="return confirm('确认删除该产品吗？');">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
