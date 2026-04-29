package com.farmer.service.impl;

import com.farmer.dto.PortalStatsDTO;
import com.farmer.entity.Banner;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.Notice;
import com.farmer.entity.Product;
import com.farmer.entity.ProductComment;
import com.farmer.mapper.PortalMapper;
import com.farmer.service.PortalService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PortalServiceImpl implements PortalService {

    @Resource
    private PortalMapper portalMapper;

    @Override
    public PortalStatsDTO getPortalStats() {
        return portalMapper.selectPortalStats();
    }

    @Override
    public List<Banner> getBanners() {
        return portalMapper.selectActiveBanners();
    }

    @Override
    public List<Notice> getNotices() {
        return portalMapper.selectPublishedNotices();
    }

    @Override
    public List<Product> getHotProducts() {
        return portalMapper.selectHotProducts();
    }

    @Override
    public List<Product> getPortalProducts(String keyword) {
        return portalMapper.selectPortalProducts(keyword);
    }

    @Override
    public List<Product> getSellerProducts(Long sellerId, String sellerType) {
        return portalMapper.selectSellerProducts(sellerId, sellerType);
    }

    @Override
    public List<ProductComment> getProductComments(Long productId) {
        return portalMapper.selectProductComments(productId);
    }

    @Override
    public List<FarmingCycle> getPublicCycles(String businessType) {
        return portalMapper.selectPublicCycles(businessType);
    }

    @Override
    public Product getProductDetail(Long productId) {
        return portalMapper.selectProductById(productId);
    }

    @Override
    public FarmingCycle getCycleDetail(Long cycleId) {
        return portalMapper.selectCycleById(cycleId);
    }

    @Override
    public List<FarmingRecord> getCycleRecords(Long cycleId) {
        return portalMapper.selectRecordsByCycleId(cycleId);
    }
}
