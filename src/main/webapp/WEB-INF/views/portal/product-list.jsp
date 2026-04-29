<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/portal-navbar.jsp" %>

<section class="section-block portal-product-page">
    <div class="container">
        <div class="portal-product-hero">
            <div class="portal-product-hero-main">
                <span class="portal-product-kicker">绿色农产品</span>
                <h2>种植户与养殖户旗下农产品</h2>
            </div>
            <div class="portal-product-summary">
                <div class="portal-product-summary-item">
                    <strong>${productCount}</strong>
                    <span>在售产品</span>
                </div>
                <div class="portal-product-summary-item">
                    <strong>${sellerGroups.size()}</strong>
                    <span>经营主体</span>
                </div>
            </div>
        </div>

        <form class="portal-product-search" method="get" action="${pageContext.request.contextPath}/portal/products">
            <div class="portal-product-search-input">
                <span class="portal-product-search-icon glyphicon glyphicon-search"></span>
                <input type="text" name="keyword" value="${keyword}" placeholder="搜索产品名称、卖家或分类">
            </div>
            <button type="submit" class="btn btn-success">搜索</button>
            <a class="btn btn-outline-success portal-btn-outline" href="${pageContext.request.contextPath}/portal/products">重置</a>
        </form>

        <c:choose>
            <c:when test="${empty sellerGroups}">
                <div class="portal-empty-state">
                    <h4>暂无符合条件的农产品</h4>
                    <p>可以尝试更换关键词，或稍后再来查看最新上架内容。</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="portal-seller-group-list">
                    <c:forEach items="${sellerGroups}" var="group">
                        <div class="portal-seller-group" id="seller-${group.sellerType}-${group.sellerId}">
                            <div class="portal-seller-group-head">
                                <div class="portal-seller-group-title">
                                    <a class="portal-seller-avatar"
                                       href="${pageContext.request.contextPath}/portal/seller-products?sellerId=${group.sellerId}&sellerType=${group.sellerType}">
                                        <c:choose>
                                            <c:when test="${not empty group.sellerAvatar}">
                                                <img src="${group.sellerAvatar}" alt="${group.sellerName}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/static/img/default-avatar.svg" alt="${group.sellerName}">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                    <div>
                                        <div class="portal-seller-name-row">
                                            <h3>${group.sellerName}</h3>
                                            <c:choose>
                                                <c:when test="${group.sellerType == 'BREED'}">
                                                    <span class="portal-seller-badge portal-seller-badge-breed">养殖户</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="portal-seller-badge">种植户</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                <div class="portal-seller-count">
                                    <strong>${group.totalCount}</strong>
                                    <span>个产品</span>
                                </div>
                            </div>

                            <div class="portal-seller-product-grid">
                                <c:forEach items="${group.products}" var="product">
                                    <div class="portal-seller-product-card">
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

                            <div class="portal-seller-expand">
                                <a class="portal-expand-link"
                                   href="${pageContext.request.contextPath}/portal/seller-products?sellerId=${group.sellerId}&sellerType=${group.sellerType}">
                                    查看全部 ${group.totalCount} 个商品
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
