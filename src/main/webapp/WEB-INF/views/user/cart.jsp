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
                <h1>购物车</h1>
                <p>统一管理购物车商品、调整数量，再确认收货地址后提交订单。</p>
            </div>
            <div class="table-toolbar-actions">
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/portal/products">继续选购</a>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/center">返回个人中心</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty cartList}">
                <div class="user-empty-state">
                    <h4>购物车还是空的</h4>
                    <p>先去挑一些喜欢的绿色农产品吧。</p>
                    <a class="btn btn-success" href="${pageContext.request.contextPath}/portal/products">去逛逛</a>
                </div>
            </c:when>
            <c:otherwise>
                <c:set var="cartTotal" value="0"/>
                <div class="cart-page-layout">
                    <div class="cart-page-main">
                        <div class="cart-list-head">
                            <span class="js-cart-size-label">已加入 ${cartList.size()} 件商品</span>
                            <span>支持直接修改数量，金额会同步回显</span>
                        </div>

                        <div class="user-card-list cart-card-list">
                            <c:forEach items="${cartList}" var="item">
                                <c:set var="cartTotal" value="${cartTotal + item.price * item.quantity}"/>
                                <div class="user-card-item cart-card-item js-cart-card" data-cart-id="${item.id}">
                                    <div class="cart-card-cover">
                                        <img src="${item.mainImage}" alt="${item.productName}">
                                    </div>

                                    <div class="cart-card-content">
                                        <div class="cart-card-top">
                                            <div class="cart-card-title-box">
                                                <h3>${item.productName}</h3>
                                                <div class="cart-card-badges">
                                                    <span class="table-tag">库存 ${item.stock} ${item.unit}</span>
                                                    <span class="table-tag table-tag-muted">单价 &yen;<fmt:formatNumber value="${item.price}" pattern="0.00"/>/${item.unit}</span>
                                                </div>
                                            </div>
                                            <button class="btn btn-sm btn-outline-danger js-cart-delete-btn" type="button" data-id="${item.id}">删除</button>
                                        </div>

                                        <div class="cart-card-bottom">
                                            <form class="cart-qty-form js-cart-update-form" method="post" action="${pageContext.request.contextPath}/user/cart/update-ajax">
                                                <input type="hidden" name="id" value="${item.id}">
                                                <label>购买数量</label>
                                                <div class="cart-qty-row">
                                                    <div class="qty-stepper">
                                                        <button class="qty-stepper-btn js-qty-dec" type="button">-</button>
                                                        <input class="form-control cart-qty-input js-qty-input" type="number" name="quantity" min="1" max="${item.stock}" value="${item.quantity}">
                                                        <button class="qty-stepper-btn js-qty-inc" type="button">+</button>
                                                    </div>
                                                    <button class="btn btn-outline-success js-cart-update-btn" type="submit">更新数量</button>
                                                </div>
                                            </form>

                                            <div class="cart-subtotal-box js-cart-subtotal-box">
                                                <span>当前小计</span>
                                                <strong class="js-cart-subtotal-value">&yen;<fmt:formatNumber value="${item.price * item.quantity}" pattern="0.00"/></strong>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="cart-page-side">
                        <div class="cart-summary-card">
                            <h3>订单汇总</h3>
                            <div class="cart-summary-meta">
                                <span>商品件数</span>
                                <strong class="js-cart-size-value">${cartList.size()} 件</strong>
                            </div>
                            <div class="cart-summary-total">
                                <span>合计金额</span>
                                <strong class="js-cart-total-value">&yen;<fmt:formatNumber value="${cartTotal}" pattern="0.00"/></strong>
                            </div>

                            <form method="post" action="${pageContext.request.contextPath}/user/orders/submit">
                                <input type="hidden" name="checkoutMode" value="CART">
                                <div class="form-group mb-3">
                                    <label class="mb-2">收货地址</label>
                                    <select class="form-control" name="addressId" required ${empty addressList ? 'disabled' : ''}>
                                        <option value="">请选择收货地址</option>
                                        <c:forEach items="${addressList}" var="address">
                                            <option value="${address.id}" ${address.isDefault == 1 ? 'selected' : ''}>
                                                ${address.receiverName} ${address.receiverPhone} ${address.province}${address.city}${address.area}${address.detailAddress}${address.isDefault == 1 ? '【默认】' : ''}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="cart-summary-actions">
                                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/addresses">管理地址</a>
                                    <c:if test="${empty addressList}">
                                        <div class="checkout-address-tip">请先新增收货地址，再提交订单。</div>
                                    </c:if>
                                    <button class="btn btn-success btn-block" type="submit" ${empty addressList ? 'disabled' : ''}>提交订单</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
