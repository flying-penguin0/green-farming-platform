package com.farmer.dto;

import com.farmer.entity.Product;

import java.util.ArrayList;
import java.util.List;

public class PortalSellerGroupDTO {
    private static final int DEFAULT_PREVIEW_LIMIT = 8;

    private Long sellerId;
    private String sellerName;
    private String sellerType;
    private String sellerAvatar;
    private Integer totalCount = 0;
    private Boolean hasMore = false;
    private List<Product> products = new ArrayList<Product>();

    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    public String getSellerType() {
        return sellerType;
    }

    public void setSellerType(String sellerType) {
        this.sellerType = sellerType;
    }

    public String getSellerAvatar() {
        return sellerAvatar;
    }

    public void setSellerAvatar(String sellerAvatar) {
        this.sellerAvatar = sellerAvatar;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public Boolean getHasMore() {
        return hasMore;
    }

    public void setHasMore(Boolean hasMore) {
        this.hasMore = hasMore;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public void addProduct(Product product) {
        totalCount = totalCount + 1;
        if (products.size() < DEFAULT_PREVIEW_LIMIT) {
            products.add(product);
        }
        hasMore = totalCount > DEFAULT_PREVIEW_LIMIT;
    }
}
