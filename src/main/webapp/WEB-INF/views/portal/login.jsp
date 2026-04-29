<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="用户登录"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="login-page">
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-lg-10">
                <div class="login-shell register-shell">
                    <div class="row no-gutters">
                        <div class="col-lg-4 register-side-panel">
                            <div class="register-side-content">
                                <h2>绿色农产品种养殖平台</h2>
                                <p>支持管理员、种植户、养殖户、普通用户多角色登录，围绕周期管理、订单管理、农产品溯源和数据看台展开。</p>

                                <ul class="register-side-points">
                                    <li>统一登录入口，快速进入对应业务后台</li>
                                    <li>查看周期、产品、订单与溯源信息</li>
                                    <li>平台公告、数据看板与经营信息一站掌握</li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-lg-8 register-form-pane">
                            <div class="register-form-card">
                                <div class="register-form-head">
                                    <h3>账号登录</h3>
                                </div>

                                <c:if test="${not empty errorMsg}">
                                    <div class="alert alert-danger">${errorMsg}</div>
                                </c:if>
                                <c:if test="${not empty successMsg}">
                                    <div class="alert alert-success">${successMsg}</div>
                                </c:if>

                                <form method="post" action="${pageContext.request.contextPath}/auth/login">
                                    <div class="form-row register-form-row">
                                        <div class="form-group col-12">
                                            <label class="register-field-label">用户名</label>
                                            <input type="text" name="username" class="form-control" placeholder="请输入用户名">
                                        </div>
                                    </div>
                                    <div class="form-row register-form-row">
                                        <div class="form-group col-12">
                                            <label class="register-field-label">密码</label>
                                            <input type="password" name="password" class="form-control" placeholder="请输入密码">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success btn-block register-submit-btn">登录系统</button>
                                </form>

                                <div class="demo-account mt-4">
                                    <h6>演示账号</h6>
                                    <p class="mb-1">管理员：admin / 123456</p>
                                    <p class="mb-1">种植户：planter01 / 123456</p>
                                    <p class="mb-1">养殖户：breeder01 / 123456</p>
                                    <p class="mb-0">普通用户：user01 / 123456</p>
                                </div>

                                <div class="register-action-row">
                                    <a href="${pageContext.request.contextPath}/portal/home">返回首页</a>
                                    <a class="text-success" href="${pageContext.request.contextPath}/auth/register">没有账号？去注册</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
