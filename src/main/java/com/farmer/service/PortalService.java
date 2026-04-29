package com.farmer.service;

import com.farmer.dto.PortalStatsDTO;
import com.farmer.entity.Banner;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.Notice;
import com.farmer.entity.Product;
import com.farmer.entity.ProductComment;

import java.util.List;

public interface PortalService {
    PortalStatsDTO getPortalStats();
    List<Banner> getBanners();
    List<Notice> getNotices();
    List<Product> getHotProducts();
    List<Product> getPortalProducts(String keyword);
    List<Product> getSellerProducts(Long sellerId, String sellerType);
    List<ProductComment> getProductComments(Long productId);
    List<FarmingCycle> getPublicCycles(String businessType);
    Product getProductDetail(Long productId);
    FarmingCycle getCycleDetail(Long cycleId);
    List<FarmingRecord> getCycleRecords(Long cycleId);
}
