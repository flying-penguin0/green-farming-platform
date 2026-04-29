<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="评价管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>
<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/comments">
            <select class="form-control mr-2" name="status">
                <option value="">全部状态</option>
                <option value="VISIBLE" ${status == 'VISIBLE' ? 'selected' : ''}>显示</option>
                <option value="HIDDEN" ${status == 'HIDDEN' ? 'selected' : ''}>隐藏</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索商品、买家、商家、订单号">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/comments">重置</a>
        </form>
    </div>
    <c:choose>
        <c:when test="${empty pageResult.records}">
            <div class="portal-inline-empty">暂无评价记录</div>
        </c:when>
        <c:otherwise>
            <div class="admin-comment-list">
                <c:forEach items="${pageResult.records}" var="item" varStatus="status">
                    <div class="admin-comment-card">
                        <div class="admin-comment-head">
                            <div class="admin-comment-product">
                                <div class="admin-comment-seq">${status.index + 1}</div>
                                <div class="admin-comment-product-image">
                                    <c:choose>
                                        <c:when test="${not empty item.productImage}">
                                            <img src="${item.productImage}" alt="${item.productName}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/static/img/default-avatar.svg" alt="${item.productName}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="admin-comment-product-main">
                                    <div class="admin-comment-topline">
                                        <h3>${item.productName}</h3>
                                        <div class="admin-comment-stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <span class="portal-comment-star ${star <= item.score ? 'active' : ''}">&#9733;</span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="admin-comment-meta-line">
                                        <span>订单号：${item.orderNo}</span>
                                        <span class="table-tag ${item.status == 'VISIBLE' ? '' : 'table-tag-muted'}">
                                            ${item.status == 'VISIBLE' ? '显示中' : '已隐藏'}
                                        </span>
                                        <span>评价时间：<fmt:formatDate value="${item.commentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    </div>
                                </div>
                            </div>
                            <div class="admin-comment-actions">
                                <c:if test="${item.status == 'VISIBLE'}">
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/comments/status/${item.id}?status=HIDDEN">隐藏评价</a>
                                </c:if>
                                <c:if test="${item.status == 'HIDDEN'}">
                                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/comments/status/${item.id}?status=VISIBLE">恢复显示</a>
                                </c:if>
                            </div>
                        </div>

                        <div class="admin-comment-party-row">
                            <div class="admin-comment-party-card">
                                <div class="admin-comment-party-avatar">
                                    <c:choose>
                                        <c:when test="${not empty item.userAvatar}">
                                            <img src="${item.userAvatar}" alt="${item.userName}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="admin-comment-party-placeholder">
                                                <c:choose>
                                                    <c:when test="${not empty item.userName}">${item.userName.substring(0, 1)}</c:when>
                                                    <c:otherwise>买</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="admin-comment-party-meta">
                                    <label>购买者</label>
                                    <strong>${item.userName}</strong>
                                </div>
                            </div>
                            <div class="admin-comment-party-card">
                                <div class="admin-comment-party-avatar">
                                    <c:choose>
                                        <c:when test="${not empty item.sellerAvatar}">
                                            <img src="${item.sellerAvatar}" alt="${item.sellerName}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="admin-comment-party-placeholder admin-comment-party-placeholder-seller">
                                                <c:choose>
                                                    <c:when test="${not empty item.sellerName}">${item.sellerName.substring(0, 1)}</c:when>
                                                    <c:otherwise>商</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="admin-comment-party-meta">
                                    <label>商家</label>
                                    <strong>${item.sellerName}</strong>
                                </div>
                            </div>
                        </div>

                        <div class="admin-comment-body">
                            <div class="admin-comment-block">
                                <label>用户评价</label>
                                <p>${empty item.content ? '暂无评价内容' : item.content}</p>
                            </div>
                            <div class="admin-comment-block">
                                <label>商家回复</label>
                                <p>${empty item.replyContent ? '商家暂未回复' : item.replyContent}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
