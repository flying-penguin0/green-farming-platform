<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>
<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/products/save">
        <input type="hidden" name="id" value="${entity.id}">
        <input type="hidden" name="sellerId" value="${entity.sellerId}">
        <input type="hidden" name="sellerType" value="${entity.sellerType}">
        <div class="form-row">
            <div class="form-group col-md-4">
                <label>产品名称</label>
                <input class="form-control" name="productName" value="${entity.productName}" required>
            </div>
            <div class="form-group col-md-4">
                <label>产品分类</label>
                <select class="form-control" name="categoryId">
                    <c:forEach items="${categoryOptions}" var="item">
                        <option value="${item.id}" ${entity.categoryId == item.id ? 'selected' : ''}>${item.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group col-md-4">
                <label>来源周期</label>
                <select class="form-control" name="sourceCycleId">
                    <option value="">请选择</option>
                    <c:forEach items="${cycleOptions}" var="item">
                        <option value="${item.id}" ${entity.sourceCycleId == item.id ? 'selected' : ''}>${item.cycleName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group col-md-3">
                <label>价格</label>
                <input class="form-control" name="price" value="${entity.price}">
            </div>
            <div class="form-group col-md-3">
                <label>库存</label>
                <input class="form-control" name="stock" value="${entity.stock}">
            </div>
            <div class="form-group col-md-2">
                <label>单位</label>
                <input class="form-control" name="unit" value="${entity.unit}" placeholder="如 斤、只、盒">
            </div>
            <div class="form-group col-md-2">
                <label>销量</label>
                <input class="form-control" name="salesCount" value="${entity.salesCount}">
            </div>
            <div class="form-group col-md-2">
                <label>状态</label>
                <select class="form-control" name="status">
                    <option value="ON_SALE" ${entity.status == 'ON_SALE' ? 'selected' : ''}>上架</option>
                    <option value="OFF_SHELF" ${entity.status == 'OFF_SHELF' ? 'selected' : ''}>下架</option>
                </select>
            </div>

            <div class="form-group col-md-12">
                <label>主图地址</label>
                <input class="form-control js-image-url-input" data-preview="#farmerPreview" name="mainImage" id="farmerMainImage" value="${entity.mainImage}" placeholder="可粘贴图片地址，或使用下方上传">
            </div>
            <div class="form-group col-md-12">
                <div class="upload-field">
                    <label class="mb-2">上传产品主图</label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="farmerImageFile" accept="image/*">
                        <label class="custom-file-label" for="farmerImageFile">选择图片文件</label>
                    </div>
                    <div class="upload-actions">
                        <button type="button" class="btn btn-success btn-sm js-upload-trigger" onclick="uploadImage('#farmerImageFile','#farmerMainImage','#farmerPreview')">上传图片</button>
                        <p class="upload-tip">支持 jpg、png、gif、webp、bmp，大小不超过 10MB。</p>
                    </div>
                    <div class="upload-preview-box">
                        <img id="farmerPreview" src="${entity.mainImage}" alt="产品主图预览" class="${empty entity.mainImage ? 'd-none' : ''}">
                    </div>
                </div>
            </div>

            <div class="form-group col-md-12">
                <label>描述</label>
                <textarea class="form-control" rows="4" name="description">${entity.description}</textarea>
            </div>
        </div>
        <div class="form-actions">
            <button class="btn btn-success" type="submit">保存</button>
        </div>
    </form>
</div>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
