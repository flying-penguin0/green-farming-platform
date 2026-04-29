<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-start.jsp" %>

<div class="panel-card">
    <div class="table-toolbar">
        <div class="text-muted">${businessType == 'BREED' ? '养殖环节记录' : '种植环节记录'}</div>
        <div class="table-toolbar-actions">
            <form class="table-search-form" method="get" action="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/records">
                <input class="form-control" type="text" name="keyword" value="${keyword}" placeholder="搜索周期、环节、标题、说明">
                <button class="btn btn-outline-success" type="submit">搜索</button>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/records">重置</a>
            </form>
            <a class="btn btn-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/records/add">新增记录</a>
        </div>
    </div>
    <table class="table admin-table">
        <thead>
        <tr>
            <th>编号</th>
            <th>周期计划</th>
            <th>环节</th>
            <th>标题</th>
            <th>记录时间</th>
            <th>说明</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.records}" var="item" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${item.cycleName}</td>
                <td>${item.templateName}</td>
                <td>${item.recordTitle}</td>
                <td><fmt:formatDate value="${item.recordTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>${item.recordContent}</td>
                <td>
                    <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/records/edit/${item.id}">编辑</a>
                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/farmer/${businessType == 'BREED' ? 'breed' : 'plant'}/records/delete/${item.id}">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<%@ include file="/WEB-INF/views/common/farmer-layout-end.jsp" %>
