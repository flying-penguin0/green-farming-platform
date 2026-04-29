<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${formTitle}"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/admin/banners/save">
        <input type="hidden" name="id" value="${entity.id}">
        <input type="hidden" name="linkUrl" value="${entity.linkUrl}">

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>轮播图标题</label>
                <input type="text" class="form-control" name="title" value="${entity.title}" required>
            </div>
            <div class="form-group col-md-2">
                <label>排序号</label>
                <input type="number" class="form-control" name="sortNo" value="${entity.sortNo}">
            </div>
            <div class="form-group col-md-2">
                <label>状态</label>
                <select class="form-control" name="status">
                    <option value="ENABLED" ${entity.status == 'ENABLED' ? 'selected' : ''}>启用</option>
                    <option value="DISABLED" ${entity.status == 'DISABLED' ? 'selected' : ''}>停用</option>
                </select>
            </div>

            <div class="form-group col-md-12">
                <label>图片地址</label>
                <input type="text" class="form-control js-image-url-input" data-preview="#bannerPreview" id="bannerImageUrl" name="imageUrl" value="${entity.imageUrl}" required placeholder="可粘贴图片地址，或使用下方上传">
            </div>
            <div class="form-group col-md-12">
                <div class="upload-field">
                    <label class="mb-2">上传轮播图</label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="bannerImageFile" accept="image/*">
                        <label class="custom-file-label" for="bannerImageFile">选择图片文件</label>
                    </div>
                    <div class="upload-actions">
                        <button type="button" class="btn btn-success btn-sm js-upload-trigger" onclick="uploadImage('#bannerImageFile','#bannerImageUrl','#bannerPreview')">上传图片</button>
                        <p class="upload-tip">建议使用横版清晰大图，便于首页轮播展示。</p>
                    </div>
                    <div class="upload-preview-box">
                        <img id="bannerPreview" src="${entity.imageUrl}" alt="轮播图预览" class="${empty entity.imageUrl ? 'd-none' : ''}">
                    </div>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button class="btn btn-success" type="submit">保存</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/banners">返回</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
