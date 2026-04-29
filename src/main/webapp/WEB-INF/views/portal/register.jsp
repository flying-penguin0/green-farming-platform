<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="用户注册"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="login-page register-page">
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100 py-4">
            <div class="col-xl-11 col-lg-11">
                <div class="login-shell register-shell">
                    <div class="row no-gutters register-main-row">
                        <div class="col-lg-4 register-side-panel">
                            <div class="register-side-content">
                                <h2>注册普通用户账号</h2>
                                <p>注册后可浏览农产品、加入购物车、提交订单、查看物流与评价，完整体验平台前台功能。</p>
                                <ul class="register-side-points">
                                    <li>透明溯源，查看种植与养殖过程</li>
                                    <li>便捷下单，管理购物车与订单</li>
                                    <li>查看用户评论，掌握真实反馈</li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-lg-8 register-form-pane">
                            <div class="register-form-card">
                                <div class="register-form-head">
                                    <h3>用户注册</h3>
                                    <p>请填写基础信息，带 <span>*</span> 为必填项。</p>
                                </div>

                                <c:if test="${not empty errorMsg}">
                                    <div class="alert alert-danger">${errorMsg}</div>
                                </c:if>

                                <form method="post" action="${pageContext.request.contextPath}/auth/register">
                                    <input type="hidden" name="avatar" id="registerAvatar" value="${form.avatar}">

                                    <div class="register-avatar-block">
                                        <div class="register-avatar-preview">
                                            <img id="registerAvatarPreview" src="${form.avatar}" alt="头像预览" class="${empty form.avatar ? 'd-none' : ''}">
                                            <div id="registerAvatarEmpty" class="register-avatar-empty ${empty form.avatar ? '' : 'd-none'}">头像</div>
                                        </div>
                                        <div class="register-avatar-tools">
                                            <label class="register-field-label">上传头像</label>
                                            <div class="upload-field register-upload-field">
                                                <div class="custom-file">
                                                    <input type="file" class="custom-file-input" id="registerAvatarFile" accept="image/*">
                                                    <label class="custom-file-label" for="registerAvatarFile">选择头像图片</label>
                                                </div>
                                                <div class="upload-actions">
                                                    <button type="button" class="btn btn-success btn-sm js-upload-trigger" onclick="uploadImage('#registerAvatarFile','#registerAvatar','#registerAvatarPreview')">上传图片</button>
                                                    <p class="upload-tip">支持 jpg、png、gif、webp、bmp，大小不超过 10MB</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-row register-form-row">
                                        <div class="form-group col-md-6">
                                            <label class="register-field-label">用户名 <span>*</span></label>
                                            <input type="text" name="username" class="form-control" value="${form.username}" placeholder="请输入用户名" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="register-field-label">姓名 <span>*</span></label>
                                            <input type="text" name="realName" class="form-control" value="${form.realName}" placeholder="请输入真实姓名" required>
                                        </div>
                                    </div>

                                    <div class="form-row register-form-row">
                                        <div class="form-group col-md-6">
                                            <label class="register-field-label">手机号</label>
                                            <input type="text" name="phone" class="form-control" value="${form.phone}" placeholder="选填">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="register-field-label">邮箱</label>
                                            <input type="text" name="email" class="form-control" value="${form.email}" placeholder="选填">
                                        </div>
                                    </div>

                                    <div class="form-row register-form-row">
                                        <div class="form-group col-md-6">
                                            <label class="register-field-label">性别</label>
                                            <select name="gender" class="form-control">
                                                <option value="男" ${form.gender == '男' ? 'selected' : ''}>男</option>
                                                <option value="女" ${form.gender == '女' ? 'selected' : ''}>女</option>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="register-field-label">密码 <span>*</span></label>
                                            <input type="password" name="password" class="form-control" placeholder="请输入密码" required>
                                        </div>
                                    </div>

                                    <div class="form-row register-form-row">
                                        <div class="form-group col-md-6">
                                            <label class="register-field-label">确认密码 <span>*</span></label>
                                            <input type="password" name="confirmPassword" class="form-control" placeholder="请再次输入密码" required>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-success btn-block register-submit-btn">注册用户</button>
                                </form>

                                <div class="register-action-row">
                                    <a href="${pageContext.request.contextPath}/portal/home">返回首页</a>
                                    <a class="text-success" href="${pageContext.request.contextPath}/auth/login">已有账号？去登录</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function () {
        $('#registerAvatar').on('input', function () {
            var value = $.trim($(this).val());
            if (value) {
                $('#registerAvatarPreview').attr('src', value).removeClass('d-none');
                $('#registerAvatarEmpty').addClass('d-none');
            } else {
                $('#registerAvatarPreview').addClass('d-none');
                $('#registerAvatarEmpty').removeClass('d-none');
            }
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
