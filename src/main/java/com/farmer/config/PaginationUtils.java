package com.farmer.config;

import com.farmer.dto.PageResult;

import java.util.Collections;
import java.util.List;

public class PaginationUtils {

    public static <T> PageResult<T> paginate(List<T> source, Integer pageNum, Integer pageSize) {
        List<T> safeList = source == null ? Collections.<T>emptyList() : source;
        int safePageSize = pageSize == null || pageSize < 1 ? 8 : pageSize;
        int safePageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
        int total = safeList.size();
        int totalPages = total == 0 ? 1 : (int) Math.ceil(total * 1.0 / safePageSize);
        if (safePageNum > totalPages) {
            safePageNum = totalPages;
        }
        int fromIndex = (safePageNum - 1) * safePageSize;
        int toIndex = Math.min(fromIndex + safePageSize, total);

        PageResult<T> result = new PageResult<T>();
        result.setPageNum(safePageNum);
        result.setPageSize(safePageSize);
        result.setTotal(total);
        result.setTotalPages(totalPages);
        result.setRecords(total == 0 ? Collections.<T>emptyList() : safeList.subList(fromIndex, toIndex));
        return result;
    }
}
