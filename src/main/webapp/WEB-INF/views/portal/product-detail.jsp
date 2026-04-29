<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/portal-navbar.jsp" %>

<section class="section-block portal-detail-page">
    <div class="container">
        <div class="portal-detail-back-row">
            <a class="portal-back-link" href="${pageContext.request.contextPath}/portal/products">
                &larr; 返回农产品
            </a>
        </div>

        <div class="portal-detail-hero">
            <div class="portal-detail-hero-main">
                <div class="portal-detail-media">
                    <img src="${product.mainImage}" alt="${product.productName}">
                </div>

                <div class="portal-detail-content">
                    <div class="portal-detail-topline">
                        <span class="badge badge-success">${product.categoryName}</span>
<%--                        <span class="portal-detail-sales">销量 ${product.salesCount}</span>--%>
                    </div>

                    <h1>${product.productName}</h1>

                    <div class="portal-detail-seller-card">
                        <a class="portal-seller-avatar" href="${pageContext.request.contextPath}/portal/seller-products?sellerId=${product.sellerId}&sellerType=${product.sellerType}">
                            <c:choose>
                                <c:when test="${not empty product.sellerAvatar}">
                                    <img src="${product.sellerAvatar}" alt="${product.sellerName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/static/img/default-avatar.svg" alt="${product.sellerName}">
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <div class="portal-detail-seller-meta">
                            <strong>${product.sellerName}</strong>
                            <div class="portal-detail-subline">
                                <span>发布者</span>
                                <c:if test="${not empty cycle}">
                                    <span>
                                        <c:choose>
                                            <c:when test="${cycle.businessType == 'BREED'}">养殖周期</c:when>
                                            <c:otherwise>种植周期</c:otherwise>
                                        </c:choose>
                                        ：${cycle.cycleName}
                                    </span>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="portal-detail-price-row">
                        <div class="portal-detail-price">&yen;${product.price}/${product.unit}</div>
                        <div class="portal-detail-stock">
                            <span>库存 ${product.stock}</span>
                            <span>销量 ${product.salesCount}</span>
                        </div>
                    </div>

                    <p class="portal-detail-desc">${product.description}</p>
                </div>

                <div class="portal-detail-purchase-panel">
                    <div class="portal-detail-purchase-main">
                        <div class="portal-detail-qty-box">
                            <label for="detailQuantity">购买数量</label>
                            <div class="qty-stepper qty-stepper-detail">
                                <button class="qty-stepper-btn js-qty-dec" type="button">-</button>
                                <input id="detailQuantity" class="form-control portal-detail-qty-input js-qty-input" type="number" min="1" max="${product.stock}" value="1">
                                <button class="qty-stepper-btn js-qty-inc" type="button">+</button>
                            </div>
                        </div>
                        <div class="portal-detail-actions">
                            <form class="portal-detail-primary-form" method="get" action="${pageContext.request.contextPath}/user/checkout/direct" onsubmit="this.quantity.value=document.getElementById('detailQuantity').value;">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="quantity" value="1">
                                <button class="btn btn-success portal-detail-primary-btn" type="submit">立即购买</button>
                            </form>
                            <form class="d-inline-block" method="post" action="${pageContext.request.contextPath}/user/cart/add" onsubmit="this.quantity.value=document.getElementById('detailQuantity').value;">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="quantity" value="1">
                                <button class="btn btn-outline-success portal-detail-secondary-btn" type="submit">加入购物车</button>
                            </form>
                            <a class="btn btn-outline-secondary portal-detail-secondary-btn d-inline-block" href="${pageContext.request.contextPath}/user/favorites/add/${product.id}">加入收藏</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="portal-detail-side-card">
                <h3>周期概览</h3>
                <c:choose>
                    <c:when test="${not empty cycle}">
                        <ul class="portal-detail-side-list">
                            <li><span>周期名称</span><strong>${cycle.cycleName}</strong></li>
                            <li><span>主体</span><strong>${cycle.ownerName}</strong></li>
<%--                            <li><span>品类</span><strong>${cycle.itemName}</strong></li>--%>
                            <li><span>规模</span><strong><fmt:formatNumber value="${cycle.scaleValue}" pattern="0.##"/>${cycle.scaleUnit}</strong></li>
                            <li><span>开始日期</span><strong><fmt:formatDate value="${cycle.startDate}" pattern="yyyy-MM-dd"/></strong></li>
                            <li><span>预计结束</span><strong><fmt:formatDate value="${cycle.expectedEndDate}" pattern="yyyy-MM-dd"/></strong></li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="portal-inline-empty">暂无关联周期信息</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="portal-detail-section-grid">
            <div class="portal-detail-section portal-detail-section-timeline">
                <div class="section-head">
                    <h2>周期时间线</h2>
                    <p>展示该产品关联周期的公开记录，方便用户了解生产过程。</p>
                </div>

                <c:choose>
                    <c:when test="${empty records}">
                        <div class="portal-empty-state">
                            <h4>暂无时间线记录</h4>
                            <p>当前产品还没有公开的周期环节记录。</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="portal-detail-timeline-shell">
                            <div class="timeline-wrap portal-detail-timeline">
                                <c:forEach items="${records}" var="record">
                                    <div class="timeline-item">
                                        <span class="timeline-dot"></span>
                                        <div class="timeline-card cycle-timeline-card portal-detail-timeline-card">
                                            <div class="cycle-timeline-top">
                                                <span class="cycle-timeline-tag">
                                                    <c:out value="${empty record.templateName ? record.recordTitle : record.templateName}"/>
                                                </span>
                                                <span class="cycle-timeline-time">
                                                    <fmt:formatDate value="${record.recordTime}" pattern="yyyy-MM-dd HH:mm"/>
                                                </span>
                                            </div>
                                            <h5>${record.recordTitle}</h5>
                                            <p>${record.recordContent}</p>
                                            <c:if test="${not empty record.imageUrl}">
                                                <div class="portal-detail-record-image">
                                                    <img src="${record.imageUrl}" alt="${record.recordTitle}">
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="portal-detail-section portal-detail-section-comments">
                <div class="section-head">
                    <h2>用户评价</h2>
                    <p>展示购买该产品的用户评价与商家回复。</p>
                </div>

                <c:choose>
                    <c:when test="${empty commentList}">
                        <div class="portal-empty-state">
                            <h4>暂无评价</h4>
                            <p>当前产品还没有公开评价，可以先查看周期时间线。</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="portal-comment-list">
                            <c:forEach items="${commentList}" var="comment">
                                <div class="portal-comment-card">
                                    <div class="portal-comment-head">
                                        <div class="portal-comment-user">
                                            <div class="portal-comment-avatar">
                                                <c:choose>
                                                    <c:when test="${not empty comment.userAvatar}">
                                                        <img src="${comment.userAvatar}" alt="${comment.userName}">
                                                    </c:when>
                                                    <c:when test="${empty comment.userName}">评</c:when>
                                                    <c:otherwise>${comment.userName.substring(0, 1)}</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <h4>${comment.userName}</h4>
                                                <div class="portal-comment-stars">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <span class="portal-comment-star ${star <= comment.score ? 'active' : ''}">&#9733;</span>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                        <span class="portal-comment-time">
                                            <fmt:formatDate value="${comment.commentTime}" pattern="yyyy-MM-dd HH:mm"/>
                                        </span>
                                    </div>
                                    <p class="portal-comment-content">${comment.content}</p>
                                    <c:if test="${not empty comment.replyContent}">
                                        <div class="portal-comment-reply">
                                            <strong>商家回复</strong>
                                            <p>${comment.replyContent}</p>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
