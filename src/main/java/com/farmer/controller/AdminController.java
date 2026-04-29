package com.farmer.controller;

import com.farmer.config.PaginationUtils;
import com.farmer.dto.PageResult;
import com.farmer.entity.Banner;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.Notice;
import com.farmer.entity.Product;
import com.farmer.entity.ProductCategory;
import com.farmer.entity.StageTemplate;
import com.farmer.entity.User;
import com.farmer.mapper.UserMapper;
import com.farmer.service.AdminService;
import com.farmer.service.DashboardService;
import com.farmer.service.TradeService;
import com.farmer.util.ExcelExportUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource
    private DashboardService dashboardService;
    @Resource
    private AdminService adminService;
    @Resource
    private TradeService tradeService;
    @Resource
    private UserMapper userMapper;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("stats", dashboardService.getAdminStats());
        model.addAttribute("activeMenu", "dashboard");
        model.addAttribute("pageTitle", "数据看台");
        return "admin/dashboard";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        model.addAttribute("entity", userMapper.selectById(getCurrentUserId(session)));
        model.addAttribute("activeMenu", "profile");
        model.addAttribute("pageTitle", "个人信息");
        return "admin/profile";
    }

    @PostMapping("/profile/save")
    public String saveProfile(User entity, HttpSession session, RedirectAttributes redirectAttributes) {
        Long userId = getCurrentUserId(session);
        User current = userMapper.selectById(userId);
        if (current != null) {
            current.setRealName(entity.getRealName());
            current.setPhone(entity.getPhone());
            current.setEmail(entity.getEmail());
            current.setAvatar(entity.getAvatar());
            current.setGender(entity.getGender());
            userMapper.updateProfile(current);
            session.setAttribute("loginUser", userMapper.selectById(userId));
        }
        redirectAttributes.addFlashAttribute("successMsg", "个人信息保存成功");
        return "redirect:/admin/profile";
    }

    @PostMapping("/profile/password")
    public String updatePassword(String oldPassword,
                                 String newPassword,
                                 String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        Long userId = getCurrentUserId(session);
        User current = userMapper.selectById(userId);
        if (current == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "用户信息不存在");
            return "redirect:/admin/profile";
        }
        if (oldPassword == null || !oldPassword.equals(current.getPassword())) {
            redirectAttributes.addFlashAttribute("errorMsg", "原密码输入错误");
            return "redirect:/admin/profile";
        }
        if (newPassword == null || newPassword.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMsg", "请输入新密码");
            return "redirect:/admin/profile";
        }
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("errorMsg", "两次输入的新密码不一致");
            return "redirect:/admin/profile";
        }
        userMapper.updatePassword(userId, newPassword);
        session.setAttribute("loginUser", userMapper.selectById(userId));
        redirectAttributes.addFlashAttribute("successMsg", "密码修改成功");
        return "redirect:/admin/profile";
    }

    @GetMapping("/users")
    public String users(String roleType, String keyword, Integer pageNum, Model model) {
        PageResult<User> pageResult = PaginationUtils.paginate(adminService.getUsers(roleType, keyword), pageNum, 8);
        model.addAttribute("pageResult", pageResult);
        model.addAttribute("roleType", roleType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "users");
        return "admin/user-list";
    }

    @GetMapping("/users/add")
    public String addUserPage(Model model) {
        User user = new User();
        user.setStatus("ENABLED");
        user.setRoleType("USER");
        model.addAttribute("entity", user);
        model.addAttribute("formTitle", "新增用户");
        model.addAttribute("activeMenu", "users");
        return "admin/user-form";
    }

    @GetMapping("/users/edit/{id}")
    public String editUserPage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("entity", adminService.getUserById(id));
        model.addAttribute("formTitle", "编辑用户");
        model.addAttribute("activeMenu", "users");
        return "admin/user-form";
    }

    @PostMapping("/users/save")
    public String saveUser(User user, RedirectAttributes redirectAttributes) {
        if (user.getId() == null) {
            if ("ADMIN".equals(user.getRoleType())) {
                user.setRoleType("USER");
            }
        } else {
            User original = adminService.getUserById(user.getId());
            if (original != null) {
                if ("ADMIN".equals(original.getRoleType())) {
                    user.setRoleType("ADMIN");
                } else if ("ADMIN".equals(user.getRoleType())) {
                    user.setRoleType(original.getRoleType());
                }
            }
        }
        adminService.saveUser(user);
        redirectAttributes.addFlashAttribute("successMsg", "用户信息保存成功");
        return "redirect:/admin/users";
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        User user = adminService.getUserById(id);
        if (user != null && "ADMIN".equals(user.getRoleType())) {
            redirectAttributes.addFlashAttribute("errorMsg", "管理员账号不允许删除");
            return "redirect:/admin/users";
        }
        adminService.deleteUser(id);
        redirectAttributes.addFlashAttribute("successMsg", "用户删除成功");
        return "redirect:/admin/users";
    }

    @GetMapping("/templates")
    public String stageTemplates(String businessType, String keyword, Integer pageNum, Model model) {
        model.addAttribute("pageResult", PaginationUtils.paginate(adminService.getStageTemplates(businessType, keyword), pageNum, 8));
        model.addAttribute("businessType", businessType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "templates");
        return "admin/template-list";
    }

    @GetMapping("/templates/add")
    public String addStageTemplatePage(Model model) {
        StageTemplate entity = new StageTemplate();
        entity.setStatus("ENABLED");
        entity.setBusinessType("PLANT");
        model.addAttribute("entity", entity);
        model.addAttribute("formTitle", "新增环节模板");
        model.addAttribute("activeMenu", "templates");
        return "admin/template-form";
    }

    @GetMapping("/templates/edit/{id}")
    public String editStageTemplatePage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("entity", adminService.getStageTemplateById(id));
        model.addAttribute("formTitle", "编辑环节模板");
        model.addAttribute("activeMenu", "templates");
        return "admin/template-form";
    }

    @PostMapping("/templates/save")
    public String saveStageTemplate(StageTemplate entity, RedirectAttributes redirectAttributes) {
        adminService.saveStageTemplate(entity);
        redirectAttributes.addFlashAttribute("successMsg", "环节模板保存成功");
        return "redirect:/admin/templates";
    }

    @GetMapping("/templates/delete/{id}")
    public String deleteStageTemplate(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        adminService.deleteStageTemplate(id);
        redirectAttributes.addFlashAttribute("successMsg", "环节模板删除成功");
        return "redirect:/admin/templates";
    }

    @GetMapping("/cycles")
    public String farmingCycles(String businessType, String keyword, Integer pageNum, Model model) {
        model.addAttribute("pageResult", PaginationUtils.paginate(adminService.getFarmingCycles(businessType, keyword), pageNum, 8));
        model.addAttribute("businessType", businessType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "cycles");
        return "admin/cycle-list";
    }

    @GetMapping("/cycles/add")
    public String addFarmingCyclePage(Model model) {
        FarmingCycle entity = new FarmingCycle();
        entity.setBusinessType("PLANT");
        entity.setStatus("ONGOING");
        entity.setIsPublic(1);
        model.addAttribute("entity", entity);
        model.addAttribute("sellerOptions", adminService.getUsers(null, null));
        model.addAttribute("formTitle", "新增种养殖周期");
        model.addAttribute("activeMenu", "cycles");
        return "admin/cycle-form";
    }

    @GetMapping("/cycles/edit/{id}")
    public String editFarmingCyclePage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("entity", adminService.getFarmingCycleById(id));
        model.addAttribute("sellerOptions", adminService.getUsers(null, null));
        model.addAttribute("formTitle", "编辑种养殖周期");
        model.addAttribute("activeMenu", "cycles");
        return "admin/cycle-form";
    }

    @PostMapping("/cycles/save")
    public String saveFarmingCycle(FarmingCycle entity, RedirectAttributes redirectAttributes) {
        entity.setItemId(null);
        adminService.saveFarmingCycle(entity);
        redirectAttributes.addFlashAttribute("successMsg", "种养殖周期保存成功");
        return "redirect:/admin/cycles";
    }

    @GetMapping("/cycles/delete/{id}")
    public String deleteFarmingCycle(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        adminService.deleteFarmingCycle(id);
        redirectAttributes.addFlashAttribute("successMsg", "种养殖周期删除成功");
        return "redirect:/admin/cycles";
    }

    @GetMapping("/product-categories")
    public String productCategories(String keyword, String status, Integer pageNum, Model model) {
        model.addAttribute("pageResult", PaginationUtils.paginate(adminService.getAdminProductCategories(keyword, status), pageNum, 8));
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("activeMenu", "productCategories");
        model.addAttribute("pageTitle", "产品分类管理");
        return "admin/product-category-list";
    }

    @GetMapping("/product-categories/add")
    public String addProductCategoryPage(Model model) {
        ProductCategory entity = new ProductCategory();
        entity.setStatus("ENABLED");
        model.addAttribute("entity", entity);
        model.addAttribute("formTitle", "新增产品分类");
        model.addAttribute("activeMenu", "productCategories");
        model.addAttribute("pageTitle", "产品分类管理");
        return "admin/product-category-form";
    }

    @GetMapping("/product-categories/edit/{id}")
    public String editProductCategoryPage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("entity", adminService.getProductCategoryById(id));
        model.addAttribute("formTitle", "编辑产品分类");
        model.addAttribute("activeMenu", "productCategories");
        model.addAttribute("pageTitle", "产品分类管理");
        return "admin/product-category-form";
    }

    @PostMapping("/product-categories/save")
    public String saveProductCategory(ProductCategory entity, RedirectAttributes redirectAttributes) {
        adminService.saveProductCategory(entity);
        redirectAttributes.addFlashAttribute("successMsg", "产品分类保存成功");
        return "redirect:/admin/product-categories";
    }

    @GetMapping("/product-categories/delete/{id}")
    public String deleteProductCategory(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        adminService.deleteProductCategory(id);
        redirectAttributes.addFlashAttribute("successMsg", "产品分类删除成功");
        return "redirect:/admin/product-categories";
    }

    @GetMapping("/products")
    public String products(String keyword, String status, Integer pageNum, Model model) {
        model.addAttribute("pageResult", PaginationUtils.paginate(adminService.getProducts(keyword, status), pageNum, 8));
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("activeMenu", "products");
        return "admin/product-list";
    }

    @GetMapping("/products/add")
    public String addProductPage(Model model) {
        Product entity = new Product();
        entity.setStatus("ON_SALE");
        entity.setSellerType("PLANT");
        entity.setUnit("斤");
        entity.setSalesCount(0);
        model.addAttribute("entity", entity);
        model.addAttribute("categoryOptions", adminService.getProductCategories());
        model.addAttribute("sellerOptions", adminService.getUsers(null, null));
        model.addAttribute("cycleOptions", adminService.getFarmingCycles(null, null));
        model.addAttribute("formTitle", "新增产品");
        model.addAttribute("activeMenu", "products");
        return "admin/product-form";
    }

    @GetMapping("/products/edit/{id}")
    public String editProductPage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("entity", adminService.getProductById(id));
        model.addAttribute("categoryOptions", adminService.getProductCategories());
        model.addAttribute("sellerOptions", adminService.getUsers(null, null));
        model.addAttribute("cycleOptions", adminService.getFarmingCycles(null, null));
        model.addAttribute("formTitle", "编辑产品");
        model.addAttribute("activeMenu", "products");
        return "admin/product-form";
    }

    @PostMapping("/products/save")
    public String saveProduct(Product entity, RedirectAttributes redirectAttributes) {
        adminService.saveProduct(entity);
        redirectAttributes.addFlashAttribute("successMsg", "产品保存成功");
        return "redirect:/admin/products";
    }

    @GetMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        adminService.deleteProduct(id);
        redirectAttributes.addFlashAttribute("successMsg", "产品删除成功");
        return "redirect:/admin/products";
    }

    @GetMapping("/banners")
    public String banners(String keyword, String status, Integer pageNum, Model model) {
        PageResult<Banner> pageResult = PaginationUtils.paginate(adminService.getBanners(keyword, status), pageNum, 8);
        model.addAttribute("pageResult", pageResult);
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("activeMenu", "operations");
        model.addAttribute("pageTitle", "首页运营管理");
        return "admin/banner-list";
    }

    @GetMapping("/banners/add")
    public String addBannerPage(Model model) {
        Banner entity = new Banner();
        entity.setStatus("ENABLED");
        entity.setSortNo(1);
        model.addAttribute("entity", entity);
        model.addAttribute("formTitle", "新增轮播图");
        model.addAttribute("activeMenu", "operations");
        return "admin/banner-form";
    }

    @GetMapping("/banners/edit/{id}")
    public String editBannerPage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("entity", adminService.getBannerById(id));
        model.addAttribute("formTitle", "编辑轮播图");
        model.addAttribute("activeMenu", "operations");
        return "admin/banner-form";
    }

    @PostMapping("/banners/save")
    public String saveBanner(Banner entity, RedirectAttributes redirectAttributes) {
        adminService.saveBanner(entity);
        redirectAttributes.addFlashAttribute("successMsg", "首页轮播图保存成功");
        return "redirect:/admin/banners";
    }

    @GetMapping("/banners/delete/{id}")
    public String deleteBanner(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        adminService.deleteBanner(id);
        redirectAttributes.addFlashAttribute("successMsg", "首页轮播图删除成功");
        return "redirect:/admin/banners";
    }

    @GetMapping("/notices")
    public String notices(String keyword, String publishStatus, Integer pageNum, Model model) {
        model.addAttribute("pageResult", PaginationUtils.paginate(adminService.getNotices(keyword, publishStatus), pageNum, 8));
        model.addAttribute("keyword", keyword);
        model.addAttribute("publishStatus", publishStatus);
        model.addAttribute("activeMenu", "notices");
        return "admin/notice-list";
    }

    @GetMapping("/notices/add")
    public String addNoticePage(Model model) {
        Notice entity = new Notice();
        entity.setPublishStatus("PUBLISHED");
        model.addAttribute("entity", entity);
        model.addAttribute("formTitle", "新增公告");
        model.addAttribute("activeMenu", "notices");
        return "admin/notice-form";
    }

    @GetMapping("/notices/edit/{id}")
    public String editNoticePage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("entity", adminService.getNoticeById(id));
        model.addAttribute("formTitle", "编辑公告");
        model.addAttribute("activeMenu", "notices");
        return "admin/notice-form";
    }

    @PostMapping("/notices/save")
    public String saveNotice(Notice entity, RedirectAttributes redirectAttributes) {
        adminService.saveNotice(entity);
        redirectAttributes.addFlashAttribute("successMsg", "公告保存成功");
        return "redirect:/admin/notices";
    }

    @GetMapping("/notices/delete/{id}")
    public String deleteNotice(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        adminService.deleteNotice(id);
        redirectAttributes.addFlashAttribute("successMsg", "公告删除成功");
        return "redirect:/admin/notices";
    }

    @GetMapping("/orders")
    public String orders(String keyword, String status, Integer pageNum, Model model) {
        model.addAttribute("pageResult", PaginationUtils.paginate(tradeService.getAdminOrders(keyword, status), pageNum, 6));
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("activeMenu", "orders");
        return "admin/order-list";
    }

    @GetMapping("/orders/export")
    public void exportOrders(String keyword, String status, HttpServletResponse response) throws IOException {
        ExcelExportUtils.exportOrders("管理员订单数据", tradeService.getAdminOrders(keyword, status), true, response);
    }

    @GetMapping("/orders/status/{id}")
    public String updateOrderStatus(@PathVariable("id") Long id, String status, RedirectAttributes redirectAttributes) {
        tradeService.updateOrderStatus(id, status);
        redirectAttributes.addFlashAttribute("successMsg", "订单状态更新成功");
        return "redirect:/admin/orders";
    }

    private Long getCurrentUserId(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        return user == null ? 1L : user.getId();
    }
}
