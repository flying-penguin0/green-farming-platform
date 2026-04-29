<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="用户管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/users">
            <select class="form-control mr-2" name="roleType">
                <option value="">全部角色</option>
                <option value="ADMIN" ${roleType == 'ADMIN' ? 'selected' : ''}>管理员</option>
                <option value="USER" ${roleType == 'USER' ? 'selected' : ''}>普通用户</option>
                <option value="PLANTER" ${roleType == 'PLANTER' ? 'selected' : ''}>种植户</option>
                <option value="BREEDER" ${roleType == 'BREEDER' ? 'selected' : ''}>养殖户</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索用户名/姓名/手机号">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/users">重置</a>
        </form>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/users/add">新增用户</a>
    </div>

    <div class="table-responsive">
        <table class="table admin-table">
            <thead>
            <tr>
                <th>编号</th>
                <th>用户信息</th>
                <th>手机号</th>
                <th>角色</th>
                <th>状态</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageResult.records}" var="item" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>
                        <div class="admin-user-cell">
                            <div class="admin-user-avatar">
                                <c:choose>
                                    <c:when test="${not empty item.avatar}">
                                        <img src="${item.avatar}" alt="${item.realName}">
                                    </c:when>
                                    <c:otherwise>
                                        <span>${empty item.realName ? fn:substring(item.username, 0, 1) : fn:substring(item.realName, 0, 1)}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="admin-user-meta">
                                <strong>${item.username}</strong>
                                <span>${item.realName}</span>
                            </div>
                        </div>
                    </td>
                    <td>${empty item.phone ? '未填写' : item.phone}</td>
                    <td>
                        <span class="table-tag ${item.roleType == 'ADMIN' ? 'table-tag-role-admin' : item.roleType == 'PLANTER' ? 'table-tag-role-planter' : item.roleType == 'BREEDER' ? 'table-tag-role-breeder' : 'table-tag-role-user'}">
                            ${item.roleType == 'ADMIN' ? '管理员' : item.roleType == 'PLANTER' ? '种植户' : item.roleType == 'BREEDER' ? '养殖户' : '普通用户'}
                        </span>
                    </td>
                    <td>
                        <span class="status-chip ${item.status == 'ENABLED' ? 'status-enabled' : item.status == 'DISABLED' ? 'status-disabled' : 'status-pending'}">
                            ${item.status == 'ENABLED' ? '启用' : item.status == 'DISABLED' ? '禁用' : '待审核'}
                        </span>
                    </td>
                    <td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/users/edit/${item.id}">编辑</a>
                        <c:choose>
                            <c:when test="${item.roleType == 'ADMIN'}">
                                <span class="btn btn-sm btn-outline-secondary disabled">不可删除</span>
                            </c:when>
                            <c:otherwise>
                                <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/users/delete/${item.id}" onclick="return confirm('确认删除该用户吗？');">删除</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
