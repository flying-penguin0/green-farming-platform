<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <div class="text-muted">${businessType == 'BREED' ? '养殖商品评价' : '种植商品评价'}</div>
        <form class="table-search-form" method="get" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/comments">
            <input class="form-control" type="text" name="keyword" value="${keyword}" placeholder="搜索商品、买家、评价内容、订单号">
            <button class="btn btn-outline-success" type="submit">搜索</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/comments">重置</a>
        </form>
    </div>

    <c:choose>
        <c:when test="${empty pageResult.records}">
            <div class="portal-inline-empty">暂无用户评价</div>
        </c:when>
        <c:otherwise>
            <div class="farmer-comment-list">
                <c:forEach items="${pageResult.records}" var="item" varStatus="status">
                    <div class="farmer-comment-card">
                        <div class="farmer-comment-product">
                            <div class="farmer-comment-seq">${status.index + 1}</div>
                            <div class="farmer-comment-image">
                                <c:choose>
                                    <c:when test="${not empty item.productImage}">
                                        <img src="${item.productImage}" alt="${item.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/static/img/default-avatar.svg" alt="${item.productName}">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="farmer-comment-product-meta">
                                <h4>${item.productName}</h4>
                                <div class="farmer-comment-buyer-row">
                                    <div class="farmer-comment-buyer-avatar">
                                        <c:choose>
                                            <c:when test="${not empty item.userAvatar}">
                                                <img src="${item.userAvatar}" alt="${item.userName}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="farmer-comment-buyer-placeholder">
                                                    <c:choose>
                                                        <c:when test="${not empty item.userName}">
                                                            ${item.userName.substring(0, 1)}
                                                        </c:when>
                                                        <c:otherwise>买</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="farmer-comment-buyer-meta">
                                        <strong>${item.userName}</strong>
                                        <span>买家昵称</span>
                                    </div>
                                </div>
                                <div class="farmer-comment-meta-row">
                                    <span>订单号：${item.orderNo}</span>
                                    <span>评分：${item.score} 分</span>
                                </div>
                                <div class="farmer-comment-meta-row">
                                    <span>评价时间：<fmt:formatDate value="${item.commentTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                </div>
                            </div>
                        </div>

                        <div class="farmer-comment-body">
                            <div class="farmer-comment-block">
                                <label>用户评价</label>
                                <p>${item.content}</p>
                            </div>
                            <div class="farmer-comment-block">
                                <label>商家回复</label>
                                <form class="farmer-comment-reply-form" method="post" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/comments/reply/${item.id}">
                                    <textarea class="form-control" name="replyContent" rows="3" placeholder="请输入回复内容">${item.replyContent}</textarea>
                                    <div class="farmer-comment-actions">
                                        <button class="btn btn-success btn-sm" type="submit">保存回复</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
