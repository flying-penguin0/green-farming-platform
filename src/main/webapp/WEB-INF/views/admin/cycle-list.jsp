<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="种养殖周期管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/cycles">
            <select class="form-control mr-2" name="businessType">
                <option value="">全部业务</option>
                <option value="PLANT" ${businessType == 'PLANT' ? 'selected' : ''}>种植</option>
                <option value="BREED" ${businessType == 'BREED' ? 'selected' : ''}>养殖</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索周期名称/对象/负责人">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/cycles">重置</a>
        </form>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/cycles/add">新增周期</a>
    </div>

    <div class="table-responsive">
        <table class="table admin-table">
            <thead>
            <tr>
                <th>编号</th>
                <th>周期名称</th>
                <th>业务类型</th>
                <th>对象名称</th>
                <th>负责人</th>
                <th>规模</th>
                <th>状态</th>
                <th>公开</th>
                <th>开始日期</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageResult.records}" var="item" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${item.cycleName}</td>
                    <td>
                        <span class="table-tag ${item.businessType == 'PLANT' ? 'table-tag-role-planter' : 'table-tag-role-breeder'}">
                            ${item.businessType == 'PLANT' ? '种植' : '养殖'}
                        </span>
                    </td>
                    <td>${item.itemName}</td>
                    <td>${item.ownerName}</td>
                    <td><fmt:formatNumber value="${item.scaleValue}" pattern="0.##"/>${item.scaleUnit}</td>
                    <td>
                        <span class="status-chip ${item.status == 'ONGOING' ? 'status-enabled' : item.status == 'FINISHED' ? 'status-disabled' : 'status-pending'}">
                            ${item.status == 'ONGOING' ? '进行中' : item.status == 'FINISHED' ? '已完成' : item.status == 'PENDING' ? '待开始' : '已取消'}
                        </span>
                    </td>
                    <td>${item.isPublic == 1 ? '是' : '否'}</td>
                    <td><fmt:formatDate value="${item.startDate}" pattern="yyyy-MM-dd"/></td>
                    <td>
                        <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/cycles/edit/${item.id}">编辑</a>
                        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/cycles/delete/${item.id}" onclick="return confirm('确认删除该周期吗？');">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
