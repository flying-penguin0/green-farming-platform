<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>

<div class="panel-card farmer-profile-card">
    <div class="farmer-profile-layout">
        <div class="farmer-profile-side">
            <div class="farmer-profile-avatar-card">
                <div class="farmer-profile-avatar-box">
                    <img id="farmerProfileAvatarPreview" src="${entity.avatar}" alt="头像预览" class="${empty entity.avatar ? 'd-none' : ''}">
                    <div id="farmerProfileAvatarEmpty" class="register-avatar-empty ${empty entity.avatar ? '' : 'd-none'}">头像</div>
                </div>

                <input type="hidden"
                       id="farmerProfileAvatar"
                       class="js-image-url-input"
                       data-preview="#farmerProfileAvatarPreview"
                       data-empty="#farmerProfileAvatarEmpty"
                       data-sync-group="farmer-profile-avatar"
                       value="${entity.avatar}">

                <div class="custom-file mt-3 upload-field">
                    <input type="file" class="custom-file-input" id="farmerProfileAvatarFile" accept="image/*">
                    <label class="custom-file-label" for="farmerProfileAvatarFile">选择头像图片</label>
                </div>
                <button type="button"
                        class="btn btn-success btn-sm mt-3 js-upload-trigger"
                        onclick="uploadImage('#farmerProfileAvatarFile','#farmerProfileAvatar','#farmerProfileAvatarPreview','#farmerProfileAvatarEmpty')">上传图片</button>
                <p class="upload-tip mt-2">支持 jpg、jpeg、png、gif、webp、bmp，大小不超过 10MB</p>
            </div>

            <div class="farmer-profile-summary">
                <h3>${empty entity.realName ? entity.username : entity.realName}</h3>
                <span>${businessType == 'BREED' ? '养殖户' : '种植户'}</span>
            </div>
        </div>

        <div class="farmer-profile-main">
            <div class="farmer-profile-section">
                <div class="farmer-profile-section-head">
                    <h3>修改密码</h3>
                    <span>请输入原密码后，再设置新的登录密码</span>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/profile/password">
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label>原密码</label>
                            <input type="password" class="form-control" name="oldPassword" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label>新密码</label>
                            <input type="password" class="form-control" name="newPassword" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label>确认新密码</label>
                            <input type="password" class="form-control" name="confirmPassword" required>
                        </div>
                    </div>
                    <div class="form-actions farmer-inline-actions">
                        <button class="btn btn-outline-success" type="submit">修改密码</button>
                    </div>
                </form>
            </div>

            <div class="farmer-profile-divider"></div>

            <div class="farmer-profile-section">
                <div class="farmer-profile-section-head">
                    <h3>基本资料</h3>
                    <span>完善商户基础信息，便于平台展示和联系</span>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/profile/save">
                    <input type="hidden" name="id" value="${entity.id}">
                    <input type="hidden" name="avatar" data-sync-group="farmer-profile-avatar" value="${entity.avatar}">

                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>用户名</label>
                            <input type="text" class="form-control" value="${entity.username}" readonly>
                        </div>
                        <div class="form-group col-md-6">
                            <label>角色</label>
                            <input type="text" class="form-control" value="${businessType == 'BREED' ? '养殖户' : '种植户'}" readonly>
                        </div>
                        <div class="form-group col-md-6">
                            <label>姓名</label>
                            <input type="text" class="form-control" name="realName" value="${entity.realName}" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>手机号</label>
                            <input type="text" class="form-control" name="phone" value="${entity.phone}">
                        </div>
                        <div class="form-group col-md-6">
                            <label>邮箱</label>
                            <input type="text" class="form-control" name="email" value="${entity.email}">
                        </div>
                        <div class="form-group col-md-6">
                            <label>性别</label>
                            <select class="form-control" name="gender">
                                <option value="男" ${entity.gender == '男' ? 'selected' : ''}>男</option>
                                <option value="女" ${entity.gender == '女' ? 'selected' : ''}>女</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-actions farmer-inline-actions">
                        <button class="btn btn-success" type="submit">保存资料</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
