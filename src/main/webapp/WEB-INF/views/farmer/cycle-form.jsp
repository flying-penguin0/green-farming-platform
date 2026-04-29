<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd" var="startDateValue"/>
<fmt:formatDate value="${entity.expectedEndDate}" pattern="yyyy-MM-dd" var="expectedEndDateValue"/>
<fmt:formatDate value="${entity.actualEndDate}" pattern="yyyy-MM-dd" var="actualEndDateValue"/>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>
<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/cycles/save">
        <input type="hidden" name="id" value="${entity.id}">
        <input type="hidden" name="userId" value="${entity.userId}">
        <input type="hidden" name="businessType" value="${businessType}">
        <input type="hidden" name="itemId" value="">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label>${businessType == 'BREED' ? '养殖对象' : '作物名称'}</label>
                <input
                    type="text"
                    class="form-control"
                    name="itemName"
                    value="${entity.itemName}"
                    placeholder="${businessType == 'BREED' ? '如黑猪、土鸡、蛋鸭' : '如番茄、水稻、草莓'}"
                    required>
            </div>
            <div class="form-group col-md-6">
                <label>周期名称</label>
                <input class="form-control" name="cycleName" value="${entity.cycleName}" required>
            </div>
            <div class="form-group col-md-3">
                <label>规模数量</label>
                <input class="form-control" name="scaleValue" value="${entity.scaleValue}">
            </div>
            <div class="form-group col-md-3">
                <label>规模单位</label>
                <input class="form-control" name="scaleUnit" value="${entity.scaleUnit}" placeholder="${businessType == 'BREED' ? '只、头、箱' : '亩、棚、株'}">
            </div>
            <div class="form-group col-md-3">
                <label>开始日期</label>
                <input type="date" class="form-control" name="startDate" value="${startDateValue}">
            </div>
            <div class="form-group col-md-3">
                <label>预计结束日期</label>
                <input type="date" class="form-control" name="expectedEndDate" value="${expectedEndDateValue}">
            </div>
            <div class="form-group col-md-3">
                <label>实际结束日期</label>
                <input type="date" class="form-control" name="actualEndDate" value="${actualEndDateValue}">
            </div>
            <div class="form-group col-md-3">
                <label>状态</label>
                <select class="form-control" name="status">
                    <option value="ONGOING" ${entity.status == 'ONGOING' ? 'selected' : ''}>进行中</option>
                    <option value="FINISHED" ${entity.status == 'FINISHED' ? 'selected' : ''}>已完成</option>
                    <option value="CANCELLED" ${entity.status == 'CANCELLED' ? 'selected' : ''}>已取消</option>
                </select>
            </div>
            <div class="form-group col-md-3">
                <label>是否公开</label>
                <select class="form-control" name="isPublic">
                    <option value="1" ${entity.isPublic == 1 ? 'selected' : ''}>公开</option>
                    <option value="0" ${entity.isPublic == 0 ? 'selected' : ''}>不公开</option>
                </select>
            </div>
            <div class="form-group col-md-12">
                <label>周期说明</label>
                <textarea class="form-control" rows="4" name="description">${entity.description}</textarea>
            </div>
        </div>
        <div class="form-actions">
            <button class="btn btn-success">保存</button>
        </div>
    </form>
</div>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
