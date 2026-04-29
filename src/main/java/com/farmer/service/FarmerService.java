package com.farmer.service;

import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.OrderInfo;
import com.farmer.entity.Product;
import com.farmer.entity.StageTemplate;

import java.util.List;

public interface FarmerService {
    List<FarmingCycle> getCycles(Long userId, String businessType);
    FarmingCycle getCycle(Long id, Long userId);
    void saveCycle(FarmingCycle cycle);
    void deleteCycle(Long id, Long userId);

    List<FarmingRecord> getRecords(Long userId, String businessType);
    FarmingRecord getRecord(Long id, Long userId);
    void saveRecord(FarmingRecord record);
    void deleteRecord(Long id, Long userId);

    List<Product> getProducts(Long sellerId, String sellerType);
    Product getProduct(Long id, Long sellerId);
    void saveProduct(Product product);
    void deleteProduct(Long id, Long sellerId);

    List<OrderInfo> getOrders(Long sellerId);

    List<StageTemplate> getTemplates(String businessType);
}
