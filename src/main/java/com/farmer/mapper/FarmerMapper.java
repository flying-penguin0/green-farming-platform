package com.farmer.mapper;

import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.OrderInfo;
import com.farmer.entity.Product;
import com.farmer.entity.StageTemplate;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FarmerMapper {
    List<FarmingCycle> selectCyclesByUser(@Param("userId") Long userId, @Param("businessType") String businessType);
    FarmingCycle selectCycleByIdAndUser(@Param("id") Long id, @Param("userId") Long userId);
    int insertCycle(FarmingCycle cycle);
    int updateCycle(FarmingCycle cycle);
    int deleteCycle(@Param("id") Long id, @Param("userId") Long userId);

    List<FarmingRecord> selectRecordsByUser(@Param("userId") Long userId, @Param("businessType") String businessType);
    FarmingRecord selectRecordById(@Param("id") Long id, @Param("userId") Long userId);
    int insertRecord(FarmingRecord record);
    int updateRecord(FarmingRecord record);
    int deleteRecord(@Param("id") Long id, @Param("userId") Long userId);

    List<Product> selectProductsBySeller(@Param("sellerId") Long sellerId, @Param("sellerType") String sellerType);
    Product selectProductByIdAndSeller(@Param("id") Long id, @Param("sellerId") Long sellerId);
    int insertProduct(Product product);
    int updateProduct(Product product);
    int deleteProduct(@Param("id") Long id, @Param("sellerId") Long sellerId);

    List<OrderInfo> selectOrdersBySeller(@Param("sellerId") Long sellerId);

    List<StageTemplate> selectTemplatesByBusinessType(@Param("businessType") String businessType);
}
