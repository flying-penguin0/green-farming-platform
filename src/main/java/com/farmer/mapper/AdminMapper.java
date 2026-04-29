package com.farmer.mapper;

import com.farmer.entity.Banner;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.Notice;
import com.farmer.entity.Product;
import com.farmer.entity.ProductCategory;
import com.farmer.entity.StageTemplate;
import com.farmer.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {
    List<User> selectAllUsers(@Param("roleType") String roleType, @Param("keyword") String keyword);
    User selectUserById(@Param("id") Long id);
    int insertUser(User user);
    int updateUser(User user);
    int deleteUser(@Param("id") Long id);

    List<StageTemplate> selectAllStageTemplates(@Param("businessType") String businessType, @Param("keyword") String keyword);
    StageTemplate selectStageTemplateById(@Param("id") Long id);
    int insertStageTemplate(StageTemplate stageTemplate);
    int updateStageTemplate(StageTemplate stageTemplate);
    int deleteStageTemplate(@Param("id") Long id);

    List<FarmingCycle> selectAllFarmingCycles(@Param("businessType") String businessType, @Param("keyword") String keyword);
    FarmingCycle selectFarmingCycleById(@Param("id") Long id);
    int insertFarmingCycle(FarmingCycle farmingCycle);
    int updateFarmingCycle(FarmingCycle farmingCycle);
    int deleteFarmingCycle(@Param("id") Long id);

    List<ProductCategory> selectAllProductCategories();
    List<ProductCategory> selectAdminProductCategories(@Param("keyword") String keyword, @Param("status") String status);
    ProductCategory selectProductCategoryById(@Param("id") Long id);
    int insertProductCategory(ProductCategory productCategory);
    int updateProductCategory(ProductCategory productCategory);
    int deleteProductCategory(@Param("id") Long id);
    List<Product> selectAllProducts(@Param("keyword") String keyword, @Param("status") String status);
    Product selectProductById(@Param("id") Long id);
    int insertProduct(Product product);
    int updateProduct(Product product);
    int deleteProduct(@Param("id") Long id);

    List<Banner> selectAllBanners(@Param("keyword") String keyword, @Param("status") String status);
    Banner selectBannerById(@Param("id") Long id);
    int insertBanner(Banner banner);
    int updateBanner(Banner banner);
    int deleteBanner(@Param("id") Long id);

    List<Notice> selectAllNotices(@Param("keyword") String keyword, @Param("publishStatus") String publishStatus);
    Notice selectNoticeById(@Param("id") Long id);
    int insertNotice(Notice notice);
    int updateNotice(Notice notice);
    int deleteNotice(@Param("id") Long id);
}
