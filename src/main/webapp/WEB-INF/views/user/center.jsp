<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
    <div class="user-center-shell">
        <section class="panel-card user-center-hero">
            <div class="user-center-profile">
                <div class="user-center-avatar">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loginUser.avatar}">
                            <img src="${sessionScope.loginUser.avatar}" alt="${sessionScope.loginUser.realName}">
                        </c:when>
                        <c:when test="${not empty sessionScope.loginUser.realName}">
                            <span>${sessionScope.loginUser.realName.substring(0, 1)}</span>
                        </c:when>
                        <c:otherwise>
                            <span>${sessionScope.loginUser.username.substring(0, 1)}</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="user-center-profile-main">
                    <div class="user-center-title-row">
                        <div>
                            <h1>${empty sessionScope.loginUser.realName ? sessionScope.loginUser.username : sessionScope.loginUser.realName}</h1>
                            <p>欢迎回来，这里可以集中查看订单、购物车、收藏和评价。</p>
                        </div>
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/portal/home">返回首页</a>
                    </div>

                    <div class="user-center-meta">
                        <div class="user-center-meta-item">
                            <span>用户名</span>
                            <strong>${sessionScope.loginUser.username}</strong>
                        </div>
                        <div class="user-center-meta-item">
                            <span>手机号</span>
                            <strong>${empty sessionScope.loginUser.phone ? '未填写' : sessionScope.loginUser.phone}</strong>
                        </div>
                        <div class="user-center-meta-item">
                            <span>邮箱</span>
                            <strong>${empty sessionScope.loginUser.email ? '未填写' : sessionScope.loginUser.email}</strong>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="user-center-grid">
            <a class="panel-card user-center-entry user-center-entry-primary" href="${pageContext.request.contextPath}/user/cart">
                <div class="user-center-entry-icon">购</div>
                <div>
                    <h3>购物车</h3>
                    <p>查看待下单商品，统一提交订单。</p>
                </div>
            </a>

            <a class="panel-card user-center-entry" href="${pageContext.request.contextPath}/user/orders">
                <div class="user-center-entry-icon">单</div>
                <div>
                    <h3>我的订单</h3>
                    <p>查看订单进度、收货状态和历史记录。</p>
                </div>
            </a>

            <a class="panel-card user-center-entry" href="${pageContext.request.contextPath}/user/favorites">
                <div class="user-center-entry-icon">藏</div>
                <div>
                    <h3>我的收藏</h3>
                    <p>快速回看感兴趣的农产品与商户。</p>
                </div>
            </a>

            <a class="panel-card user-center-entry" href="${pageContext.request.contextPath}/user/comments">
                <div class="user-center-entry-icon">评</div>
                <div>
                    <h3>我的评价</h3>
                    <p>管理已提交评价，查看商家回复内容。</p>
                </div>
            </a>

            <a class="panel-card user-center-entry" href="${pageContext.request.contextPath}/user/profile">
                <div class="user-center-entry-icon">我</div>
                <div>
                    <h3>个人信息</h3>
                    <p>修改头像、基本资料，并更新登录密码。</p>
                </div>
            </a>

            <a class="panel-card user-center-entry" href="${pageContext.request.contextPath}/user/addresses">
                <div class="user-center-entry-icon">址</div>
                <div>
                    <h3>收货地址</h3>
                    <p>管理常用收货人、联系电话和配送地址。</p>
                </div>
            </a>
        </section>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
