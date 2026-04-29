package com.farmer.dto;

import java.util.List;

public class PageResult<T> {
    private List<T> records;
    private int pageNum;
    private int pageSize;
    private int total;
    private int totalPages;

    public List<T> getRecords() { return records; }
    public void setRecords(List<T> records) { this.records = records; }
    public int getPageNum() { return pageNum; }
    public void setPageNum(int pageNum) { this.pageNum = pageNum; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }
    public int getTotalPages() { return totalPages; }
    public void setTotalPages(int totalPages) { this.totalPages = totalPages; }
    public boolean isHasPrev() { return pageNum > 1; }
    public boolean isHasNext() { return pageNum < totalPages; }
}
