<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="溯源详情"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/portal-navbar.jsp" %>

<div class="container py-5">
    <a href="${pageContext.request.contextPath}/portal/${cycle.businessType == 'BREED' ? 'breed-cycles' : 'plant-cycles'}" class="btn btn-link px-0 mb-3">
        返回${cycle.businessType == 'BREED' ? '养殖周期' : '种植周期'}
    </a>
    <div class="trace-detail-header">
        <span class="trace-type ${cycle.businessType == 'BREED' ? 'trace-type-breed' : ''}">
            ${cycle.businessType == 'BREED' ? '养殖' : '种植'}
        </span>
        <h2 class="mt-3">${cycle.cycleName}</h2>
        <p class="text-muted">
            负责人：${cycle.ownerName}
            | 对象：${cycle.itemName}
            | 状态：${cycle.status}
        </p>
        <p>${cycle.description}</p>
    </div>
    <div class="timeline-wrap mt-4">
        <c:forEach items="${records}" var="record">
            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-card">
                    <small class="text-success">${record.templateName}</small>
                    <h5>${record.recordTitle}</h5>
                    <p>${record.recordContent}</p>
                    <div class="text-muted small">${record.recordTime}</div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
