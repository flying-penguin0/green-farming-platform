<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${successMsg}</div>
    </c:if>

    <div class="panel-card user-page-shell">
        <div class="user-page-head">
            <div>
                <h1>我的收藏</h1>
                <p>快速回看感兴趣的农产品与商户。</p>
            </div>
            <div class="table-toolbar-actions">
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/portal/products">继续浏览</a>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/center">返回个人中心</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty favoriteList}">
                <div class="user-empty-state">
                    <h4>还没有收藏商品</h4>
                    <p>去前台逛逛，把喜欢的商品先收藏起来。</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="user-favorite-grid">
                    <c:forEach items="${favoriteList}" var="item">
                        <div class="product-card user-favorite-card">
                            <div class="product-cover">
                                <img src="${item.mainImage}" alt="${item.productName}">
                            </div>
                            <div class="product-body">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="badge badge-success">${item.categoryName}</span>
                                    <span class="text-muted small">${item.sellerName}</span>
                                </div>
                                <h5 class="mb-2">${item.productName}</h5>
                                <p class="text-muted user-favorite-desc">${item.description}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="portal-product-price">&yen;${item.price}/${item.unit}</div>
                                    <div class="d-flex" style="gap:8px;">
                                        <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/portal/product/${item.id}">查看详情</a>
                                        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/user/favorites/delete/${item.id}">取消收藏</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
