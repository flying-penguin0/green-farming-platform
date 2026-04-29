package com.farmer.mapper;

import com.farmer.dto.DashboardStatsDTO;
import org.apache.ibatis.annotations.Param;

public interface DashboardMapper {
    DashboardStatsDTO selectAdminStats();
    DashboardStatsDTO selectSellerStats(@Param("sellerId") Long sellerId, @Param("businessType") String businessType);
}
