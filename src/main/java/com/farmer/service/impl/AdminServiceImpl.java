package com.farmer.service.impl;

import com.farmer.entity.Banner;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.Notice;
import com.farmer.entity.Product;
import com.farmer.entity.ProductCategory;
import com.farmer.entity.StageTemplate;
import com.farmer.entity.User;
import com.farmer.mapper.AdminMapper;
import com.farmer.service.AdminService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Resource
    private AdminMapper adminMapper;

    @Override
    public List<User> getUsers(String roleType, String keyword) {
        return adminMapper.selectAllUsers(roleType, keyword);
    }

    @Override
    public User getUserById(Long id) {
        return adminMapper.selectUserById(id);
    }

    @Override
    @Transactional
    public void saveUser(User user) {
        if (user.getId() == null) {
            adminMapper.insertUser(user);
        } else {
            User original = adminMapper.selectUserById(user.getId());
            if (original != null && (user.getPassword() == null || user.getPassword().trim().isEmpty())) {
                user.setPassword(original.getPassword());
            }
            adminMapper.updateUser(user);
        }
    }

    @Override
    @Transactional
    public void deleteUser(Long id) {
        adminMapper.deleteUser(id);
    }

    @Override
    public List<StageTemplate> getStageTemplates(String businessType, String keyword) {
        return adminMapper.selectAllStageTemplates(businessType, keyword);
    }

    @Override
    public StageTemplate getStageTemplateById(Long id) {
        return adminMapper.selectStageTemplateById(id);
    }

    @Override
    @Transactional
    public void saveStageTemplate(StageTemplate stageTemplate) {
        if (stageTemplate.getId() == null) {
            adminMapper.insertStageTemplate(stageTemplate);
        } else {
            adminMapper.updateStageTemplate(stageTemplate);
        }
    }

    @Override
    @Transactional
    public void deleteStageTemplate(Long id) {
        adminMapper.deleteStageTemplate(id);
    }

    @Override
    public List<FarmingCycle> getFarmingCycles(String businessType, String keyword) {
        return adminMapper.selectAllFarmingCycles(businessType, keyword);
    }

    @Override
    public FarmingCycle getFarmingCycleById(Long id) {
        return adminMapper.selectFarmingCycleById(id);
    }

    @Override
    @Transactional
    public void saveFarmingCycle(FarmingCycle farmingCycle) {
        if (farmingCycle.getId() == null) {
            adminMapper.insertFarmingCycle(farmingCycle);
        } else {
            adminMapper.updateFarmingCycle(farmingCycle);
        }
    }

    @Override
    @Transactional
    public void deleteFarmingCycle(Long id) {
        adminMapper.deleteFarmingCycle(id);
    }

    @Override
    public List<ProductCategory> getProductCategories() {
        return adminMapper.selectAllProductCategories();
    }

    @Override
    public List<ProductCategory> getAdminProductCategories(String keyword, String status) {
        return adminMapper.selectAdminProductCategories(keyword, status);
    }

    @Override
    public ProductCategory getProductCategoryById(Long id) {
        return adminMapper.selectProductCategoryById(id);
    }

    @Override
    @Transactional
    public void saveProductCategory(ProductCategory productCategory) {
        if (productCategory.getId() == null) {
            adminMapper.insertProductCategory(productCategory);
        } else {
            adminMapper.updateProductCategory(productCategory);
        }
    }

    @Override
    @Transactional
    public void deleteProductCategory(Long id) {
        adminMapper.deleteProductCategory(id);
    }

    @Override
    public List<Product> getProducts(String keyword, String status) {
        return adminMapper.selectAllProducts(keyword, status);
    }

    @Override
    public Product getProductById(Long id) {
        return adminMapper.selectProductById(id);
    }

    @Override
    @Transactional
    public void saveProduct(Product product) {
        if (product.getId() == null) {
            adminMapper.insertProduct(product);
        } else {
            adminMapper.updateProduct(product);
        }
    }

    @Override
    @Transactional
    public void deleteProduct(Long id) {
        adminMapper.deleteProduct(id);
    }

    @Override
    public List<Banner> getBanners(String keyword, String status) {
        return adminMapper.selectAllBanners(keyword, status);
    }

    @Override
    public Banner getBannerById(Long id) {
        return adminMapper.selectBannerById(id);
    }

    @Override
    @Transactional
    public void saveBanner(Banner banner) {
        if (banner.getId() == null) {
            adminMapper.insertBanner(banner);
        } else {
            adminMapper.updateBanner(banner);
        }
    }

    @Override
    @Transactional
    public void deleteBanner(Long id) {
        adminMapper.deleteBanner(id);
    }

    @Override
    public List<Notice> getNotices(String keyword, String publishStatus) {
        return adminMapper.selectAllNotices(keyword, publishStatus);
    }

    @Override
    public Notice getNoticeById(Long id) {
        return adminMapper.selectNoticeById(id);
    }

    @Override
    @Transactional
    public void saveNotice(Notice notice) {
        if (notice.getId() == null) {
            adminMapper.insertNotice(notice);
        } else {
            adminMapper.updateNotice(notice);
        }
    }

    @Override
    @Transactional
    public void deleteNotice(Long id) {
        adminMapper.deleteNotice(id);
    }
}
