<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
    </c:if>

    <div class="user-address-layout">
        <div class="panel-card user-page-shell">
            <div class="user-page-head">
                <div>
                    <h1>收货地址</h1>
                    <p>维护常用收货信息，下单时可以快速选择。</p>
                </div>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/center">返回个人中心</a>
            </div>

            <c:choose>
                <c:when test="${empty addressList}">
                    <div class="user-empty-state">
                        <h4>还没有收货地址</h4>
                        <p>先添加一个常用地址，后续购买会更方便。</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="address-card-list">
                        <c:forEach items="${addressList}" var="item">
                            <div class="address-card-item ${item.isDefault == 1 ? 'address-card-default' : ''}">
                                <div class="address-card-head">
                                    <div>
                                        <h3>${item.receiverName}</h3>
                                        <span>${item.receiverPhone}</span>
                                    </div>
                                    <c:if test="${item.isDefault == 1}">
                                        <span class="table-tag">默认地址</span>
                                    </c:if>
                                </div>
                                <p>${item.province}${item.city}${item.area}${item.detailAddress}</p>
                                <div class="address-card-actions">
                                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/user/addresses?id=${item.id}">编辑</a>
                                    <c:if test="${item.isDefault != 1}">
                                        <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/user/addresses/default/${item.id}">设为默认</a>
                                    </c:if>
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/user/addresses/delete/${item.id}">删除</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="panel-card user-page-shell">
            <div class="user-page-head">
                <div>
                    <h1>${empty entity.id ? '新增地址' : '编辑地址'}</h1>
                    <p>请填写准确的收货人、电话和详细地址。</p>
                </div>
<%--                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/center">返回个人中心</a>--%>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/user/addresses/save">
                <input type="hidden" name="id" value="${entity.id}">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>收货人</label>
                        <input class="form-control" type="text" name="receiverName" value="${entity.receiverName}" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label>联系电话</label>
                        <input class="form-control" type="text" name="receiverPhone" value="${entity.receiverPhone}" required>
                    </div>
                    <div class="form-group col-md-4">
                        <label>省份</label>
                        <input class="form-control" type="text" name="province" value="${entity.province}" placeholder="如：广东省">
                    </div>
                    <div class="form-group col-md-4">
                        <label>城市</label>
                        <input class="form-control" type="text" name="city" value="${entity.city}" placeholder="如：广州市">
                    </div>
                    <div class="form-group col-md-4">
                        <label>区县</label>
                        <input class="form-control" type="text" name="area" value="${entity.area}" placeholder="如：天河区">
                    </div>
                    <div class="form-group col-12">
                        <label>详细地址</label>
                        <input class="form-control" type="text" name="detailAddress" value="${entity.detailAddress}" placeholder="街道、小区、门牌号等" required>
                    </div>
                    <div class="form-group col-12 mb-0">
                        <div class="custom-control custom-checkbox">
                            <input class="custom-control-input" type="checkbox" id="addressDefault" name="isDefault" value="1" ${entity.isDefault == 1 ? 'checked' : ''}>
                            <label class="custom-control-label" for="addressDefault">设为默认收货地址</label>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <button class="btn btn-success" type="submit">保存地址</button>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/user/addresses">重置</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
