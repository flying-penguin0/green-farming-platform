<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
    </c:if>

    <div class="panel-card user-page-shell">
        <div class="user-page-head user-page-head-filter">
            <div>
                <h1>我的订单</h1>
                <p>查看订单进度、收货状态和历史记录。</p>
            </div>
            <div class="table-toolbar-actions">
                <form class="table-search-form" method="get" action="${pageContext.request.contextPath}/user/orders">
                    <select class="form-control" name="status">
                        <option value="">全部状态</option>
                        <option value="PENDING_SHIP" ${status == 'PENDING_SHIP' ? 'selected' : ''}>待发货</option>
                        <option value="PENDING_RECEIVE" ${status == 'PENDING_RECEIVE' ? 'selected' : ''}>待收货</option>
                        <option value="FINISHED" ${status == 'FINISHED' ? 'selected' : ''}>已完成</option>
                        <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>已取消</option>
                    </select>
                    <button class="btn btn-success" type="submit">筛选</button>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/orders">重置</a>
                </form>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/center">返回个人中心</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty orderList}">
                <div class="user-empty-state">
                    <h4>暂时没有订单</h4>
                    <p>下单后可以在这里查看全部订单记录。</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="user-order-list">
                    <c:forEach items="${orderList}" var="order">
                        <div class="order-card user-order-card">
                            <div class="user-order-head">
                                <div>
                                    <strong>${order.orderNo}</strong>
                                    <span>卖家：${order.sellerName}</span>
                                </div>
                                <div class="user-order-actions">
                                    <span class="table-tag">
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'PENDING_SHIP'}">待发货</c:when>
                                            <c:when test="${order.orderStatus == 'PENDING_RECEIVE'}">待收货</c:when>
                                            <c:when test="${order.orderStatus == 'FINISHED'}">已完成</c:when>
                                            <c:otherwise>已取消</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <c:if test="${order.orderStatus == 'PENDING_RECEIVE'}">
                                        <a class="btn btn-sm btn-success" href="${pageContext.request.contextPath}/user/orders/receive/${order.id}">确认收货</a>
                                    </c:if>
                                </div>
                            </div>

                            <div class="user-order-items">
                                <c:forEach items="${order.itemList}" var="item">
                                    <div class="user-order-item">
                                        <div class="user-order-item-cover">
                                            <img src="${item.productImage}" alt="${item.productName}">
                                        </div>
                                        <div class="user-order-item-main">
                                            <div class="user-order-item-top">
                                                <h4>${item.productName}</h4>
                                                <strong>&yen;${item.amount}</strong>
                                            </div>
                                            <div class="user-order-item-meta">
                                                <span>单价：&yen;${item.price}</span>
                                                <span>数量：${item.quantity}</span>
                                            </div>
                                            <c:if test="${order.orderStatus == 'FINISHED'}">
                                                <div class="user-order-comment-entry">
                                                    <span>订单已完成，可前往“我的评价”统一打分和评价。</span>
                                                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/user/comments">去评价</a>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="user-order-foot">
                                <div class="user-order-receiver">
                                    <span>收货信息：${order.receiverName} ${order.receiverPhone}</span>
                                    <span>${order.receiverAddress}</span>
                                </div>
                                <span>下单时间：<fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                <strong>订单金额：&yen;${order.totalAmount}</strong>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
