<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="绿色农产品种养殖平台首页"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/portal-navbar.jsp" %>

<section class="home-single-screen">
    <div class="container">
        <div class="home-hero-grid">
            <div class="home-hero-main">
                <span class="hero-tag">绿色农业 · 全程可溯 · 产销一体</span>
                <h1 class="hero-title">让种植、养殖、销售与溯源在一个平台里完整联动</h1>

                <c:if test="${not empty banners}">
                    <div class="home-left-carousel home-left-carousel-top">
                        <div id="portalBannerCarousel" class="carousel slide home-banner-carousel" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <c:forEach items="${banners}" var="banner" varStatus="status">
                                    <li data-target="#portalBannerCarousel" data-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                                </c:forEach>
                            </ol>
                            <div class="carousel-inner">
                                <c:forEach items="${banners}" var="banner" varStatus="status">
                                    <div class="carousel-item ${status.first ? 'active' : ''}">
                                        <a href="${empty banner.linkUrl ? 'javascript:void(0)' : banner.linkUrl}" class="home-banner-link">
                                            <img src="${banner.imageUrl}" class="d-block w-100 home-banner-image" alt="${banner.title}">
                                            <div class="carousel-caption home-banner-caption">
                                                <h2>${banner.title}</h2>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                            <a class="carousel-control-prev" href="#portalBannerCarousel" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">上一张</span>
                            </a>
                            <a class="carousel-control-next" href="#portalBannerCarousel" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">下一张</span>
                            </a>
                        </div>
                    </div>
                </c:if>

                <p class="hero-desc">
                    面向种植户、养殖户、管理员与普通用户，围绕周期管理、过程记录、农产品展示、订单流转和透明溯源，
                    构建一套绿色农产品综合平台。
                </p>
<%--                <div class="hero-actions">--%>
<%--                    <a class="btn btn-success btn-lg mr-3" href="${pageContext.request.contextPath}/portal/products">浏览农产品</a>--%>
<%--                    <a class="btn btn-outline-success btn-lg" href="${pageContext.request.contextPath}/portal/plant-cycles">查看周期</a>--%>
<%--                </div>--%>
<%--                <div class="home-feature-row">--%>
<%--                    <div class="home-feature-pill">种植周期透明展示</div>--%>
<%--                    <div class="home-feature-pill">养殖过程可追溯</div>--%>
<%--                    <div class="home-feature-pill">平台订单统一管理</div>--%>
<%--                </div>--%>
            </div>

            <div class="home-hero-side">
                <div class="home-stat-panel">
                    <div class="home-stat-grid">
                        <div class="home-stat-item">
                            <h3>${stats.publicCycleCount}</h3>
                            <p>公开周期</p>
                        </div>
                        <div class="home-stat-item">
                            <h3>${stats.productCount}</h3>
                            <p>在售产品</p>
                        </div>
                        <div class="home-stat-item">
                            <h3>${stats.farmerCount}</h3>
                            <p>认证农户</p>
                        </div>
                        <div class="home-stat-item">
                            <h3>${stats.orderCount}</h3>
                            <p>累计订单</p>
                        </div>
                    </div>
                    <div id="portalTrendChart" class="chart-box home-chart-box"></div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    window.portalStats = {
        publicCycleCount: ${stats.publicCycleCount},
        productCount: ${stats.productCount},
        farmerCount: ${stats.farmerCount},
        orderCount: ${stats.orderCount}
    };
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
