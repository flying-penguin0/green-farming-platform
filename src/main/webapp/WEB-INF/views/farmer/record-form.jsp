<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${entity.recordTime}" pattern="yyyy-MM-dd'T'HH:mm" var="recordTimeValue"/>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>
<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/records/save">
        <input type="hidden" name="id" value="${entity.id}">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label>所属周期</label>
                <select class="form-control" name="cycleId">
                    <c:forEach items="${cycleOptions}" var="item">
                        <option value="${item.id}" ${entity.cycleId == item.id ? 'selected' : ''}>${item.cycleName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group col-md-6">
                <label>环节模板</label>
                <select class="form-control" name="templateId">
                    <c:forEach items="${templateOptions}" var="item">
                        <option value="${item.id}" ${entity.templateId == item.id ? 'selected' : ''}>${item.templateName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group col-md-6">
                <label>记录标题</label>
                <input class="form-control" name="recordTitle" value="${entity.recordTitle}" required>
            </div>
            <div class="form-group col-md-6">
                <label>记录时间</label>
                <input type="datetime-local" class="form-control" name="recordTime" value="${recordTimeValue}">
            </div>

            <div class="form-group col-md-12">
                <label>图片地址</label>
                <input class="form-control js-image-url-input" data-preview="#recordPreview" name="imageUrl" id="recordImageUrl" value="${entity.imageUrl}" placeholder="可粘贴图片地址，或使用下方上传">
            </div>
            <div class="form-group col-md-12">
                <div class="upload-field">
                    <label class="mb-2">上传环节图片</label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="recordImageFile" accept="image/*">
                        <label class="custom-file-label" for="recordImageFile">选择图片文件</label>
                    </div>
                    <div class="upload-actions">
                        <button type="button" class="btn btn-success btn-sm js-upload-trigger" onclick="uploadImage('#recordImageFile','#recordImageUrl','#recordPreview')">上传图片</button>
                        <p class="upload-tip">建议上传清晰现场图，便于前台时间线展示。</p>
                    </div>
                    <div class="upload-preview-box">
                        <img id="recordPreview" src="${entity.imageUrl}" alt="环节图片预览" class="${empty entity.imageUrl ? 'd-none' : ''}">
                    </div>
                </div>
            </div>

            <div class="form-group col-md-12">
                <label>记录内容</label>
                <textarea class="form-control" rows="4" name="recordContent">${entity.recordContent}</textarea>
            </div>
        </div>
        <div class="form-actions">
            <button class="btn btn-success">保存</button>
        </div>
    </form>
</div>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
