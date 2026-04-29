<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${pageResult.total > 0}">
    <nav class="mt-3">
        <ul class="pagination justify-content-end mb-0">
            <li class="page-item ${pageResult.hasPrev ? '' : 'disabled'}">
                <a class="page-link" href="javascript:void(0)" onclick="goPage(${pageResult.pageNum - 1})">上一页</a>
            </li>
            <li class="page-item disabled">
                <span class="page-link">第 ${pageResult.pageNum} / ${pageResult.totalPages} 页</span>
            </li>
            <li class="page-item ${pageResult.hasNext ? '' : 'disabled'}">
                <a class="page-link" href="javascript:void(0)" onclick="goPage(${pageResult.pageNum + 1})">下一页</a>
            </li>
        </ul>
    </nav>
    <script>
        function goPage(pageNum) {
            if (pageNum < 1) {
                return;
            }
            var url = new URL(window.location.href);
            url.searchParams.set('pageNum', pageNum);
            window.location.href = url.toString();
        }
    </script>
</c:if>
