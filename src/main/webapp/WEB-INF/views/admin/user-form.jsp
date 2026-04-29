<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${formTitle}"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <form method="post" action="${pageContext.request.contextPath}/admin/users/save">
        <input type="hidden" name="id" value="${entity.id}">

        <div class="form-row">
            <div class="form-group col-md-12">
                <div class="upload-field">
                    <label class="mb-2">用户头像</label>
                    <input type="hidden" class="js-image-url-input" data-preview="#adminUserAvatarPreview" name="avatar" id="adminUserAvatar" value="${entity.avatar}">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="adminUserAvatarFile" accept="image/*">
                        <label class="custom-file-label" for="adminUserAvatarFile">选择头像图片</label>
                    </div>
                    <div class="upload-actions">
                        <button type="button" class="btn btn-success btn-sm js-upload-trigger" onclick="uploadImage('#adminUserAvatarFile','#adminUserAvatar','#adminUserAvatarPreview')">上传图片</button>
                        <p class="upload-tip">支持 jpg、png、gif、webp、bmp，大小不超过 10MB</p>
                    </div>
                    <div class="upload-preview-box admin-user-avatar-preview-box">
                        <img id="adminUserAvatarPreview" src="${entity.avatar}" alt="用户头像预览" class="${empty entity.avatar ? 'd-none' : ''}">
                    </div>
                </div>
            </div>

            <div class="form-group col-md-6">
                <label>用户名</label>
                <input type="text" class="form-control" name="username" value="${entity.username}" required>
            </div>
            <div class="form-group col-md-6">
                <label>密码</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="adminUserPassword" name="password" value="${entity.password}" ${empty entity.id ? 'required' : ''} placeholder="${empty entity.id ? '请输入密码' : ''}">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary js-password-toggle" type="button" data-target="adminUserPassword" title="显示或隐藏密码">&#128065;</button>
                    </div>
                </div>
                <small class="form-text text-muted">${empty entity.id ? '请设置登录密码' : '默认隐藏显示，点击右侧图标可查看'}</small>
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
            <div class="form-group col-md-4">
                <label>角色</label>
                <select class="form-control" name="roleType">
                    <c:choose>
                        <c:when test="${entity.roleType == 'ADMIN'}">
                            <option value="ADMIN" selected>管理员</option>
                        </c:when>
                        <c:otherwise>
                            <option value="USER" ${entity.roleType == 'USER' ? 'selected' : ''}>普通用户</option>
                            <option value="PLANTER" ${entity.roleType == 'PLANTER' ? 'selected' : ''}>种植户</option>
                            <option value="BREEDER" ${entity.roleType == 'BREEDER' ? 'selected' : ''}>养殖户</option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>
            <div class="form-group col-md-4">
                <label>状态</label>
                <select class="form-control" name="status">
                    <option value="ENABLED" ${entity.status == 'ENABLED' ? 'selected' : ''}>启用</option>
                    <option value="DISABLED" ${entity.status == 'DISABLED' ? 'selected' : ''}>禁用</option>
                    <option value="PENDING" ${entity.status == 'PENDING' ? 'selected' : ''}>待审核</option>
                </select>
            </div>
        </div>

        <div class="form-actions">
            <button class="btn btn-success" type="submit">保存</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/users">返回</a>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var toggles = document.querySelectorAll('.js-password-toggle');
        for (var i = 0; i < toggles.length; i++) {
            toggles[i].addEventListener('click', function () {
                var inputId = this.getAttribute('data-target');
                var input = document.getElementById(inputId);
                if (!input) {
                    return;
                }
                var isPassword = input.getAttribute('type') === 'password';
                input.setAttribute('type', isPassword ? 'text' : 'password');
                this.innerHTML = isPassword ? '&#128584;' : '&#128065;';
            });
        }
    });
</script>

<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
