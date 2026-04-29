package com.farmer.service;

import com.farmer.dto.DashboardStatsDTO;

public interface DashboardService {
    DashboardStatsDTO getAdminStats();
    DashboardStatsDTO getSellerStats(Long sellerId, String businessType);
}
