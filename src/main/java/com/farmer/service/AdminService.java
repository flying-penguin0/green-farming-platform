package com.farmer.service;

import com.farmer.entity.Banner;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.Notice;
import com.farmer.entity.Product;
import com.farmer.entity.ProductCategory;
import com.farmer.entity.StageTemplate;
import com.farmer.entity.User;

import java.util.List;

public interface AdminService {
    List<User> getUsers(String roleType, String keyword);
    User getUserById(Long id);
    void saveUser(User user);
    void deleteUser(Long id);

    List<StageTemplate> getStageTemplates(String businessType, String keyword);
    StageTemplate getStageTemplateById(Long id);
    void saveStageTemplate(StageTemplate stageTemplate);
    void deleteStageTemplate(Long id);

    List<FarmingCycle> getFarmingCycles(String businessType, String keyword);
    FarmingCycle getFarmingCycleById(Long id);
    void saveFarmingCycle(FarmingCycle farmingCycle);
    void deleteFarmingCycle(Long id);

    List<ProductCategory> getProductCategories();
    List<ProductCategory> getAdminProductCategories(String keyword, String status);
    ProductCategory getProductCategoryById(Long id);
    void saveProductCategory(ProductCategory productCategory);
    void deleteProductCategory(Long id);
    List<Product> getProducts(String keyword, String status);
    Product getProductById(Long id);
    void saveProduct(Product product);
    void deleteProduct(Long id);

    List<Banner> getBanners(String keyword, String status);
    Banner getBannerById(Long id);
    void saveBanner(Banner banner);
    void deleteBanner(Long id);

    List<Notice> getNotices(String keyword, String publishStatus);
    Notice getNoticeById(Long id);
    void saveNotice(Notice notice);
    void deleteNotice(Long id);
}
