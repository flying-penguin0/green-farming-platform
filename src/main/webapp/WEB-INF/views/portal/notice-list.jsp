<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/portal-navbar.jsp" %>

<section class="section-block portal-notice-page">
    <div class="container">
        <div class="section-head portal-notice-head">
            <span class="portal-notice-kicker">平台动态</span>
            <h2>平台公告</h2>
            <p>发布平台动态、专题通知和运营公告。</p>
        </div>

        <div class="portal-notice-grid">
            <c:forEach items="${notices}" var="notice" varStatus="status">
                <article class="notice-card portal-notice-card ${status.first ? 'portal-notice-card-featured' : ''}">
                    <div class="portal-notice-meta">
                        <div class="portal-notice-meta-left">
                            <span class="portal-notice-index">${status.index + 1 < 10 ? '0' : ''}${status.index + 1}</span>
                            <span class="portal-notice-badge">${status.first ? '最新公告' : '平台公告'}</span>
                        </div>
                        <time class="notice-date" datetime="<fmt:formatDate value='${notice.createTime}' pattern='yyyy-MM-dd HH:mm'/>">
                            <fmt:formatDate value="${notice.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                        </time>
                    </div>
                    <h3>${notice.title}</h3>
                    <p>${notice.content}</p>
                </article>
            </c:forEach>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
