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
        <div class="user-page-head">
            <div>
                <h1>确认订单</h1>
                <p>请选择收货地址并确认商品信息后提交订单。</p>
            </div>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/portal/product-detail?id=${product.id}">返回商品详情</a>
        </div>

        <div class="checkout-page-layout">
            <div class="checkout-product-card">
                <div class="checkout-product-cover">
                    <img src="${product.mainImage}" alt="${product.productName}">
                </div>
                <div class="checkout-product-body">
                    <div class="checkout-product-top">
                        <div>
                            <h3>${product.productName}</h3>
                            <span>${product.sellerName}</span>
                        </div>
                        <strong>&yen;<fmt:formatNumber value="${product.price}" pattern="0.00"/>/${product.unit}</strong>
                    </div>
                    <div class="checkout-product-meta">
                        <span>购买数量：${quantity}</span>
                        <span>库存：${product.stock} ${product.unit}</span>
                    </div>
                    <div class="checkout-total-row">
                        <span>订单合计</span>
                        <strong>&yen;<fmt:formatNumber value="${product.price * quantity}" pattern="0.00"/></strong>
                    </div>
                </div>
            </div>

            <div class="checkout-address-panel">
                <div class="checkout-address-head">
                    <h3>选择收货地址</h3>
                    <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/user/addresses">管理地址</a>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/user/orders/submit">
                    <input type="hidden" name="checkoutMode" value="DIRECT">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="hidden" name="quantity" value="${quantity}">

                    <c:choose>
                        <c:when test="${empty addressList}">
                            <div class="user-empty-state mb-0">
                                <h4>暂无收货地址</h4>
                                <p>请先添加收货地址，再完成购买。</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="checkout-address-list">
                                <c:forEach items="${addressList}" var="address">
                                    <label class="checkout-address-option ${address.isDefault == 1 ? 'active' : ''}">
                                        <input type="radio" name="addressId" value="${address.id}" ${address.isDefault == 1 ? 'checked' : ''} required>
                                        <div>
                                            <div class="checkout-address-name-row">
                                                <strong>${address.receiverName}</strong>
                                                <span>${address.receiverPhone}</span>
                                                <c:if test="${address.isDefault == 1}">
                                                    <em>默认</em>
                                                </c:if>
                                            </div>
                                            <p>${address.province}${address.city}${address.area}${address.detailAddress}</p>
                                        </div>
                                    </label>
                                </c:forEach>
                            </div>
                            <div class="form-actions">
                                <button class="btn btn-success" type="submit">提交订单</button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
