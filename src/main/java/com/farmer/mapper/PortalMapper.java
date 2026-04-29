package com.farmer.mapper;

import com.farmer.dto.PortalStatsDTO;
import com.farmer.entity.Banner;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.Notice;
import com.farmer.entity.Product;
import com.farmer.entity.ProductComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PortalMapper {
    PortalStatsDTO selectPortalStats();
    List<Banner> selectActiveBanners();
    List<Notice> selectPublishedNotices();
    List<Product> selectHotProducts();
    List<Product> selectPortalProducts(@Param("keyword") String keyword);
    List<Product> selectSellerProducts(@Param("sellerId") Long sellerId, @Param("sellerType") String sellerType);
    List<ProductComment> selectProductComments(@Param("productId") Long productId);
    List<FarmingCycle> selectPublicCycles(@Param("businessType") String businessType);
    Product selectProductById(@Param("id") Long id);
    FarmingCycle selectCycleById(@Param("id") Long id);
    List<FarmingRecord> selectRecordsByCycleId(@Param("cycleId") Long cycleId);
}
