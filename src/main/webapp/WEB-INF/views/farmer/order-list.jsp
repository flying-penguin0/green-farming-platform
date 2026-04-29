<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <div class="text-muted">订单列表</div>
        <form class="table-search-form" method="get" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/orders">
            <input class="form-control" type="text" name="keyword" value="${keyword}" placeholder="搜索订单号、买家、商品">
            <button class="btn btn-outline-success" type="submit">搜索</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/orders">重置</a>
            <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/orders/export?keyword=${keyword}">导出数据</a>
        </form>
    </div>

    <c:forEach items="${pageResult.records}" var="order" varStatus="statusIndex">
        <div class="order-card mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <strong>订单 ${statusIndex.index + 1}：${order.orderNo}</strong>
                    <span class="text-muted ml-3">买家：${order.userName}</span>
                </div>
                <div>
                    <span class="table-tag mr-2">
                        <c:choose>
                            <c:when test="${order.orderStatus == 'PENDING_SHIP'}">待发货</c:when>
                            <c:when test="${order.orderStatus == 'PENDING_RECEIVE'}">待收货</c:when>
                            <c:when test="${order.orderStatus == 'FINISHED'}">已完成</c:when>
                            <c:otherwise>已取消</c:otherwise>
                        </c:choose>
                    </span>
                    <c:if test="${order.orderStatus == 'PENDING_SHIP'}">
                        <a class="btn btn-sm btn-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/orders/status/${order.id}?status=PENDING_RECEIVE">发货</a>
                    </c:if>
                </div>
            </div>
            <div class="farmer-order-address-box">
                <div class="farmer-order-address-head">收货信息</div>
                <div class="farmer-order-address-body">
                    <span>${order.receiverName}</span>
                    <span>${order.receiverPhone}</span>
                    <span>${order.receiverAddress}</span>
                </div>
            </div>
            <table class="table admin-table mb-0">
                <thead>
                <tr>
                    <th>商品</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${order.itemList}" var="item">
                    <tr>
                        <td>${item.productName}</td>
                        <td>&yen;${item.price}</td>
                        <td>${item.quantity}</td>
                        <td>&yen;${item.amount}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:forEach>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
