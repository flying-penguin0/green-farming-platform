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
                <h1>我的评价</h1>
                <p>待评价商品和历史评价统一放在这里管理。</p>
            </div>
            <div class="table-toolbar-actions">
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/orders">返回订单</a>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/center">返回个人中心</a>
            </div>
        </div>

        <div class="user-comment-section">
            <div class="user-comment-section-head">
                <h3>待评价</h3>
                <span>${empty pendingCommentList ? 0 : pendingCommentList.size()} 条</span>
            </div>
            <c:choose>
                <c:when test="${empty pendingCommentList}">
                    <div class="user-empty-state user-empty-state-light">
                        <h4>当前没有待评价商品</h4>
                        <p>确认收货并完成订单后，可在这里统一提交评分和评价。</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="user-comment-list">
                        <c:forEach items="${pendingCommentList}" var="item">
                            <div class="user-comment-card">
                                <div class="user-comment-product">
                                    <div class="user-comment-cover">
                                        <img src="${item.productImage}" alt="${item.productName}">
                                    </div>
                                    <div class="user-comment-product-main">
                                        <div class="user-comment-top">
                                            <h3>${item.productName}</h3>
                                            <span>订单号：${item.orderNo}</span>
                                        </div>
                                        <div class="user-comment-time">购买数量：${item.quantity}</div>
                                    </div>
                                </div>

                                <form method="post" action="${pageContext.request.contextPath}/user/comments/save" class="user-comment-form">
                                    <input type="hidden" name="orderId" value="${item.orderId}">
                                    <input type="hidden" name="orderItemId" value="${item.orderItemId}">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <div class="user-comment-form-row">
                                        <div class="user-comment-score-box">
                                            <label>评分</label>
                                            <select class="form-control" name="score">
                                                <option value="5">5 分</option>
                                                <option value="4">4 分</option>
                                                <option value="3">3 分</option>
                                                <option value="2">2 分</option>
                                                <option value="1">1 分</option>
                                            </select>
                                        </div>
                                        <div class="user-comment-input-box">
                                            <label>评价内容</label>
                                            <input class="form-control" type="text" name="content" placeholder="写下你的真实评价" maxlength="200">
                                        </div>
                                        <div class="user-comment-submit-box">
                                            <button class="btn btn-success" type="submit">提交评价</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="user-comment-section">
            <div class="user-comment-section-head">
                <h3>我的评价</h3>
                <span>${empty commentList ? 0 : commentList.size()} 条</span>
            </div>
            <c:choose>
                <c:when test="${empty commentList}">
                    <div class="user-empty-state user-empty-state-light">
                        <h4>暂时没有评价记录</h4>
                        <p>完成订单并提交评价后，会在这里集中展示。</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="user-comment-list">
                        <c:forEach items="${commentList}" var="item">
                            <div class="user-comment-card">
                                <div class="user-comment-product">
                                    <div class="user-comment-cover">
                                        <img src="${item.productImage}" alt="${item.productName}">
                                    </div>
                                    <div class="user-comment-product-main">
                                        <div class="user-comment-top">
                                            <h3>${item.productName}</h3>
                                            <span>订单号：${item.orderNo}</span>
                                        </div>
                                        <div class="user-comment-stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <span class="portal-comment-star ${star <= item.score ? 'active' : ''}">&#9733;</span>
                                            </c:forEach>
                                        </div>
                                        <div class="user-comment-time">评价时间：<fmt:formatDate value="${item.commentTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                </div>

                                <div class="user-comment-content-block">
                                    <label>我的评价</label>
                                    <p>${item.content}</p>
                                </div>

                                <c:if test="${not empty item.replyContent}">
                                    <div class="user-comment-reply-block">
                                        <label>商家回复</label>
                                        <p>${item.replyContent}</p>
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

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
