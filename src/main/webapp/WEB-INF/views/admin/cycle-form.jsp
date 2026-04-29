<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd" var="startDateValue"/>
<fmt:formatDate value="${entity.expectedEndDate}" pattern="yyyy-MM-dd" var="expectedEndDateValue"/>
<fmt:formatDate value="${entity.actualEndDate}" pattern="yyyy-MM-dd" var="actualEndDateValue"/>
<c:set var="pageTitle" value="${formTitle}"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/admin/cycles/save">
        <input type="hidden" name="id" value="${entity.id}">
        <input type="hidden" name="itemId" value="">
        <div class="form-row">
            <div class="form-group col-md-4">
                <label>业务类型</label>
                <select class="form-control" name="businessType" id="businessTypeSelect">
                    <option value="PLANT" ${entity.businessType == 'PLANT' ? 'selected' : ''}>种植</option>
                    <option value="BREED" ${entity.businessType == 'BREED' ? 'selected' : ''}>养殖</option>
                </select>
            </div>
            <div class="form-group col-md-4">
                <label>负责人</label>
                <select class="form-control" name="userId" id="sellerSelect">
                    <c:forEach items="${sellerOptions}" var="seller">
                        <c:if test="${seller.roleType == 'PLANTER' || seller.roleType == 'BREEDER'}">
                            <option value="${seller.id}" data-role-type="${seller.roleType}" ${entity.userId == seller.id ? 'selected' : ''}>
                                ${seller.realName}（${seller.roleType == 'PLANTER' ? '种植户' : '养殖户'}）
                            </option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group col-md-4">
                <label>周期名称</label>
                <input type="text" class="form-control" name="cycleName" value="${entity.cycleName}" required>
            </div>

            <div class="form-group col-md-6">
                <label id="itemNameLabel">${entity.businessType == 'BREED' ? '养殖对象' : '作物名称'}</label>
                <input type="text" class="form-control" name="itemName" id="itemNameInput" value="${entity.itemName}" placeholder="请输入具体名称" required>
            </div>
            <div class="form-group col-md-3">
                <label>规模数量</label>
                <input type="text" class="form-control" name="scaleValue" value="${entity.scaleValue}">
            </div>
            <div class="form-group col-md-3">
                <label>规模单位</label>
                <input type="text" class="form-control" name="scaleUnit" value="${entity.scaleUnit}" placeholder="如亩、只、头">
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
                    <option value="PENDING" ${entity.status == 'PENDING' ? 'selected' : ''}>待开始</option>
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
            <button class="btn btn-success" type="submit">保存</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/cycles">返回</a>
        </div>
    </form>
</div>

<script>
    (function () {
        function syncFormState() {
            var businessType = $('#businessTypeSelect').val();
            var itemLabel = businessType === 'BREED' ? '养殖对象' : '作物名称';
            $('#itemNameLabel').text(itemLabel);
            $('#itemNameInput').attr('placeholder', businessType === 'BREED' ? '如黑猪、土鸡、蛋鸭' : '如番茄、水稻、草莓');

            $('#sellerSelect option').each(function () {
                var roleType = $(this).data('role-type');
                var visible = (businessType === 'PLANT' && roleType === 'PLANTER')
                    || (businessType === 'BREED' && roleType === 'BREEDER');
                $(this).prop('hidden', !visible);
            });

            var current = $('#sellerSelect option:selected');
            if (current.prop('hidden')) {
                $('#sellerSelect option:not([hidden]):first').prop('selected', true);
            }
        }

        $(function () {
            $('#businessTypeSelect').on('change', syncFormState);
            syncFormState();
        });
    })();
</script>

<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
