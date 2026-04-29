package com.farmer.service.impl;

import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.OrderInfo;
import com.farmer.entity.Product;
import com.farmer.entity.StageTemplate;
import com.farmer.mapper.FarmerMapper;
import com.farmer.mapper.TradeMapper;
import com.farmer.service.FarmerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FarmerServiceImpl implements FarmerService {

    @Resource
    private FarmerMapper farmerMapper;
    @Resource
    private TradeMapper tradeMapper;

    @Override
    public List<FarmingCycle> getCycles(Long userId, String businessType) {
        return farmerMapper.selectCyclesByUser(userId, businessType);
    }

    @Override
    public FarmingCycle getCycle(Long id, Long userId) {
        return farmerMapper.selectCycleByIdAndUser(id, userId);
    }

    @Override
    @Transactional
    public void saveCycle(FarmingCycle cycle) {
        if (cycle.getId() == null) {
            farmerMapper.insertCycle(cycle);
        } else {
            farmerMapper.updateCycle(cycle);
        }
    }

    @Override
    @Transactional
    public void deleteCycle(Long id, Long userId) {
        farmerMapper.deleteCycle(id, userId);
    }

    @Override
    public List<FarmingRecord> getRecords(Long userId, String businessType) {
        return farmerMapper.selectRecordsByUser(userId, businessType);
    }

    @Override
    public FarmingRecord getRecord(Long id, Long userId) {
        return farmerMapper.selectRecordById(id, userId);
    }

    @Override
    @Transactional
    public void saveRecord(FarmingRecord record) {
        if (record.getId() == null) {
            farmerMapper.insertRecord(record);
        } else {
            farmerMapper.updateRecord(record);
        }
    }

    @Override
    @Transactional
    public void deleteRecord(Long id, Long userId) {
        farmerMapper.deleteRecord(id, userId);
    }

    @Override
    public List<Product> getProducts(Long sellerId, String sellerType) {
        return farmerMapper.selectProductsBySeller(sellerId, sellerType);
    }

    @Override
    public Product getProduct(Long id, Long sellerId) {
        return farmerMapper.selectProductByIdAndSeller(id, sellerId);
    }

    @Override
    @Transactional
    public void saveProduct(Product product) {
        if (product.getId() == null) {
            farmerMapper.insertProduct(product);
        } else {
            farmerMapper.updateProduct(product);
        }
    }

    @Override
    @Transactional
    public void deleteProduct(Long id, Long sellerId) {
        farmerMapper.deleteProduct(id, sellerId);
    }

    @Override
    public List<OrderInfo> getOrders(Long sellerId) {
        List<OrderInfo> orders = farmerMapper.selectOrdersBySeller(sellerId);
        for (OrderInfo order : orders) {
            order.setItemList(tradeMapper.selectOrderItemsByOrderId(order.getId()));
        }
        return orders;
    }

    @Override
    public List<StageTemplate> getTemplates(String businessType) {
        return farmerMapper.selectTemplatesByBusinessType(businessType);
    }
}
