<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/portal-navbar.jsp" %>

<section class="section-block portal-product-page">
    <div class="container">
        <div class="portal-product-hero">
            <div class="portal-product-hero-main">
                <a class="portal-back-link" href="${pageContext.request.contextPath}/portal/products">
                    &larr; 返回农产品
                </a>
                <div class="portal-seller-group-title">
                    <a class="portal-seller-avatar" href="javascript:void(0);">
                        <c:choose>
                            <c:when test="${not empty sellerAvatar}">
                                <img src="${sellerAvatar}" alt="${sellerName}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/static/img/default-avatar.svg" alt="${sellerName}">
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <div>
                        <h2>${sellerName}</h2>
                        <p>
                            <c:choose>
                                <c:when test="${sellerType == 'BREED'}">养殖户</c:when>
                                <c:otherwise>种植户</c:otherwise>
                            </c:choose>
                            旗下全部在售商品
                        </p>
                    </div>
                </div>
            </div>
            <div class="portal-product-summary">
                <div class="portal-product-summary-item">
                    <strong>${productCount}</strong>
                    <span>在售商品</span>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty products}">
                <div class="portal-empty-state">
                    <h4>该商户暂无在售商品</h4>
                    <p>可返回农产品页面继续浏览其他内容。</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="portal-seller-all-page-grid">
                    <c:forEach items="${products}" var="product">
                        <div class="portal-seller-product-card portal-seller-product-card-full">
                            <a class="portal-seller-product-cover" href="${pageContext.request.contextPath}/portal/product/${product.id}">
                                <img src="${product.mainImage}" alt="${product.productName}">
                            </a>
                            <div class="portal-seller-product-body">
                                <div class="portal-product-card-top">
                                    <span class="badge badge-success">${product.categoryName}</span>
                                    <span class="portal-product-sales">销量 ${product.salesCount}</span>
                                </div>
                                <h4>
                                    <a href="${pageContext.request.contextPath}/portal/product/${product.id}">${product.productName}</a>
                                </h4>
                                <c:choose>
                                    <c:when test="${empty product.description}">
                                        <p>暂无产品简介</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p>${product.description}</p>
                                    </c:otherwise>
                                </c:choose>
                                <div class="portal-product-card-bottom">
                                    <div>
                                        <div class="portal-product-price">&yen;${product.price}/${product.unit}</div>
                                        <div class="portal-product-stock">库存 ${product.stock}</div>
                                    </div>
                                    <div class="d-flex" style="gap:8px;">
                                        <a class="btn btn-sm btn-outline-success portal-btn-outline" href="${pageContext.request.contextPath}/portal/product/${product.id}">查看详情</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
