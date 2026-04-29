<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="公告管理"/>
<%@ include file="/WEB-INF/views/common/admin-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin/notices">
            <select class="form-control mr-2" name="publishStatus">
                <option value="">全部状态</option>
                <option value="PUBLISHED" ${publishStatus == 'PUBLISHED' ? 'selected' : ''}>已发布</option>
                <option value="DRAFT" ${publishStatus == 'DRAFT' ? 'selected' : ''}>草稿</option>
            </select>
            <input class="form-control mr-2" type="text" name="keyword" value="${keyword}" placeholder="搜索公告标题">
            <button class="btn btn-success mr-2" type="submit">查询</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/notices">重置</a>
        </form>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/notices/add">新增公告</a>
    </div>

    <div class="table-responsive">
        <table class="table admin-table">
            <thead>
            <tr>
                <th>编号</th>
                <th>标题</th>
                <th>状态</th>
                <th>创建时间</th>
                <th>内容摘要</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageResult.records}" var="item" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${item.title}</td>
                    <td>
                        <span class="status-chip ${item.publishStatus == 'PUBLISHED' ? 'status-enabled' : 'status-pending'}">
                            ${item.publishStatus == 'PUBLISHED' ? '已发布' : '草稿'}
                        </span>
                    </td>
                    <td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="text-muted">${item.content}</td>
                    <td>
                        <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/admin/notices/edit/${item.id}">编辑</a>
                        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/notices/delete/${item.id}" onclick="return confirm('确认删除该公告吗？');">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/admin-layout-end.jsp" %>
