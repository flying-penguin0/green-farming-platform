<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="订单管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/orders">
            <select class="form-control mr-2" name="status">
                <option value="">全部状态</option>
                <option value="PENDING_SHIP" ${status == 'PENDING_SHIP' ? 'selected' : ''}>待发货</option>
                <option value="PENDING_RECEIVE" ${status == 'PENDING_RECEIVE' ? 'selected' : ''}>待收货</option>
                <option value="FINISHED" ${status == 'FINISHED' ? 'selected' : ''}>已完成</option>
                <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>已取消</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索订单号、买家、卖家">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary mr-2" href="${pageContext.request.contextPath}/admin/orders">重置</a>
            <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/admin/orders/export?keyword=${keyword}&status=${status}">导出数据</a>
        </form>
    </div>

    <c:forEach items="${pageResult.records}" var="order" varStatus="statusIndex">
        <div class="order-card mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <strong>订单 ${statusIndex.index + 1}：${order.orderNo}</strong>
                    <span class="text-muted ml-3">买家：${order.userName}</span>
                    <span class="text-muted ml-3">卖家：${order.sellerName}</span>
                </div>
                <div>
                    <span class="table-tag mr-2">
                        ${order.orderStatus == 'PENDING_SHIP' ? '待发货' : order.orderStatus == 'PENDING_RECEIVE' ? '待收货' : order.orderStatus == 'FINISHED' ? '已完成' : '已取消'}
                    </span>
                    <c:if test="${order.orderStatus == 'PENDING_SHIP'}">
                        <a class="btn btn-sm btn-success" href="${pageContext.request.contextPath}/admin/orders/status/${order.id}?status=PENDING_RECEIVE">发货</a>
                    </c:if>
                    <c:if test="${order.orderStatus == 'PENDING_RECEIVE'}">
                        <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/orders/status/${order.id}?status=FINISHED">完成</a>
                    </c:if>
                </div>
            </div>

            <div class="table-responsive">
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

            <div class="mt-3 d-flex justify-content-between">
                <span class="text-muted">收货信息：${order.receiverName} ${order.receiverPhone} ${order.receiverAddress}</span>
                <strong>订单金额：&yen;${order.totalAmount}</strong>
            </div>
        </div>
    </c:forEach>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
