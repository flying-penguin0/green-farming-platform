<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/portal-navbar.jsp" %>

<section class="section-block">
    <div class="container">
        <div class="section-head">
            <h2>养殖周期</h2>
            <p>展示公开的养殖计划、养殖对象、负责人和全过程记录入口。</p>
        </div>
        <div class="cycle-horizontal-list">
            <c:forEach items="${cycles}" var="cycle">
                <div class="cycle-horizontal-card">
                    <div class="cycle-horizontal-main cycle-horizontal-main-inline">
                        <div class="cycle-horizontal-head cycle-horizontal-head-inline">
                            <div class="cycle-title-row">
                                <span class="trace-type trace-type-breed">养殖</span>
                                <h4>${cycle.cycleName}</h4>
                            </div>
                            <p>${cycle.description}</p>
                        </div>
                        <div class="cycle-inline-meta">
                            <span class="cycle-inline-chip"><em>养殖对象</em><strong>${cycle.itemName}</strong></span>
                            <span class="cycle-inline-chip"><em>负责人</em><strong>${cycle.ownerName}</strong></span>
                            <span class="cycle-inline-chip"><em>规模</em><strong><fmt:formatNumber value="${cycle.scaleValue}" pattern="0.##"/>${cycle.scaleUnit}</strong></span>
                            <span class="cycle-inline-chip">
                                <em>状态</em>
                                <strong>
                                    <span class="status-badge status-${cycle.status}">
                                        <c:choose>
                                            <c:when test="${cycle.status == 'ONGOING'}">进行中</c:when>
                                            <c:when test="${cycle.status == 'FINISHED'}">已完成</c:when>
                                            <c:when test="${cycle.status == 'PENDING'}">待开始</c:when>
                                            <c:when test="${cycle.status == 'CANCELLED'}">已取消</c:when>
                                            <c:otherwise>${cycle.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </strong>
                            </span>
                        </div>
                        <div class="cycle-horizontal-side cycle-horizontal-side-inline">
                            <button type="button" class="btn btn-success btn-sm js-toggle-timeline" data-target="timeline-${cycle.id}">
                                查看时间线
                            </button>
                        </div>
                    </div>
                    <div class="cycle-inline-timeline d-none" id="timeline-${cycle.id}">
                        <div class="timeline-wrap cycle-inline-timeline-wrap">
                            <c:forEach items="${recordMap[cycle.id]}" var="record">
                                <div class="timeline-item">
                                    <div class="timeline-dot"></div>
                                    <div class="timeline-card cycle-timeline-card">
                                        <div class="cycle-timeline-top">
                                            <span class="cycle-timeline-tag">${record.templateName}</span>
                                            <span class="cycle-timeline-time">
                                                <fmt:formatDate value="${record.recordTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            </span>
                                        </div>
                                        <h5>${record.recordTitle}</h5>
                                        <p>${record.recordContent}</p>
                                        <c:if test="${not empty record.imageUrl}">
                                            <div class="cycle-timeline-image">
                                                <img src="${record.imageUrl}" alt="${record.recordTitle}">
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty recordMap[cycle.id]}">
                                <div class="text-muted">暂无时间线记录</div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var buttons = document.querySelectorAll('.js-toggle-timeline');
        buttons.forEach(function (button) {
            button.addEventListener('click', function () {
                var id = button.getAttribute('data-target');
                var target = document.getElementById(id);
                if (!target) {
                    return;
                }
                target.classList.toggle('d-none');
                button.textContent = target.classList.contains('d-none') ? '查看时间线' : '收起时间线';
            });
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
