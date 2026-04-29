package com.farmer.service.impl;

import com.farmer.dto.DashboardStatsDTO;
import com.farmer.mapper.DashboardMapper;
import com.farmer.service.DashboardService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Resource
    private DashboardMapper dashboardMapper;

    @Override
    public DashboardStatsDTO getAdminStats() {
        return dashboardMapper.selectAdminStats();
    }

    @Override
    public DashboardStatsDTO getSellerStats(Long sellerId, String businessType) {
        return dashboardMapper.selectSellerStats(sellerId, businessType);
    }
}
