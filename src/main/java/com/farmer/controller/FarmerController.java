package com.farmer.controller;

import com.farmer.config.PaginationUtils;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.Product;
import com.farmer.entity.User;
import com.farmer.mapper.UserMapper;
import com.farmer.service.AdminService;
import com.farmer.service.DashboardService;
import com.farmer.service.FarmerService;
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
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/farmer")
public class FarmerController {

    @Resource
    private DashboardService dashboardService;
    @Resource
    private FarmerService farmerService;
    @Resource
    private AdminService adminService;
    @Resource
    private TradeService tradeService;
    @Resource
    private UserMapper userMapper;

    @GetMapping("/plant/dashboard")
    public String plantDashboard(HttpSession session, Model model) {
        Long userId = getCurrentUserId(session, 2L);
        model.addAttribute("stats", dashboardService.getSellerStats(userId, "PLANT"));
        model.addAttribute("businessTitle", "种植户数据看台");
        model.addAttribute("businessType", "PLANT");
        return "farmer/dashboard";
    }

    @GetMapping("/breed/dashboard")
    public String breedDashboard(HttpSession session, Model model) {
        Long userId = getCurrentUserId(session, 3L);
        model.addAttribute("stats", dashboardService.getSellerStats(userId, "BREED"));
        model.addAttribute("businessTitle", "养殖户数据看台");
        model.addAttribute("businessType", "BREED");
        return "farmer/dashboard";
    }

    @GetMapping("/{businessType}/cycles")
    public String cycles(@PathVariable("businessType") String businessType, Integer pageNum, String keyword, HttpSession session, Model model) {
        List<FarmingCycle> cycleList = farmerService.getCycles(getCurrentUserId(session, defaultUserId(businessType)), businessType.toUpperCase());
        cycleList = filterCycles(cycleList, keyword);
        model.addAttribute("pageResult", PaginationUtils.paginate(
                cycleList,
                pageNum,
                8
        ));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("keyword", normalizeKeyword(keyword));
        model.addAttribute("pageTitle", titlePrefix(businessType) + "周期管理");
        return "farmer/cycle-list";
    }

    @GetMapping("/{businessType}/cycles/add")
    public String addCyclePage(@PathVariable("businessType") String businessType, HttpSession session, Model model) {
        FarmingCycle entity = new FarmingCycle();
        entity.setBusinessType(businessType.toUpperCase());
        entity.setUserId(getCurrentUserId(session, defaultUserId(businessType)));
        entity.setStatus("ONGOING");
        entity.setIsPublic(1);
        model.addAttribute("entity", entity);
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("pageTitle", "新增" + titlePrefix(businessType) + "周期");
        return "farmer/cycle-form";
    }

    @GetMapping("/{businessType}/cycles/edit/{id}")
    public String editCyclePage(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, HttpSession session, Model model) {
        model.addAttribute("entity", farmerService.getCycle(id, getCurrentUserId(session, defaultUserId(businessType))));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("pageTitle", "编辑" + titlePrefix(businessType) + "周期");
        return "farmer/cycle-form";
    }

    @PostMapping("/{businessType}/cycles/save")
    public String saveCycle(@PathVariable("businessType") String businessType, FarmingCycle entity, HttpSession session, RedirectAttributes redirectAttributes) {
        entity.setBusinessType(businessType.toUpperCase());
        entity.setUserId(getCurrentUserId(session, defaultUserId(businessType)));
        entity.setItemId(null);
        farmerService.saveCycle(entity);
        redirectAttributes.addFlashAttribute("successMsg", "周期保存成功");
        return "redirect:/farmer/" + businessType + "/cycles";
    }

    @GetMapping("/{businessType}/cycles/delete/{id}")
    public String deleteCycle(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        farmerService.deleteCycle(id, getCurrentUserId(session, defaultUserId(businessType)));
        redirectAttributes.addFlashAttribute("successMsg", "周期删除成功");
        return "redirect:/farmer/" + businessType + "/cycles";
    }

    @GetMapping("/{businessType}/records")
    public String records(@PathVariable("businessType") String businessType, Integer pageNum, String keyword, HttpSession session, Model model) {
        List<FarmingRecord> recordList = farmerService.getRecords(getCurrentUserId(session, defaultUserId(businessType)), businessType.toUpperCase());
        recordList = filterRecords(recordList, keyword);
        model.addAttribute("pageResult", PaginationUtils.paginate(
                recordList,
                pageNum,
                8
        ));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("keyword", normalizeKeyword(keyword));
        model.addAttribute("pageTitle", titlePrefix(businessType) + "环节记录");
        return "farmer/record-list";
    }

    @GetMapping("/{businessType}/records/add")
    public String addRecordPage(@PathVariable("businessType") String businessType, HttpSession session, Model model) {
        FarmingRecord entity = new FarmingRecord();
        model.addAttribute("entity", entity);
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("cycleOptions", farmerService.getCycles(getCurrentUserId(session, defaultUserId(businessType)), businessType.toUpperCase()));
        model.addAttribute("templateOptions", farmerService.getTemplates(businessType.toUpperCase()));
        model.addAttribute("pageTitle", "新增" + titlePrefix(businessType) + "记录");
        return "farmer/record-form";
    }

    @GetMapping("/{businessType}/records/edit/{id}")
    public String editRecordPage(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, HttpSession session, Model model) {
        model.addAttribute("entity", farmerService.getRecord(id, getCurrentUserId(session, defaultUserId(businessType))));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("cycleOptions", farmerService.getCycles(getCurrentUserId(session, defaultUserId(businessType)), businessType.toUpperCase()));
        model.addAttribute("templateOptions", farmerService.getTemplates(businessType.toUpperCase()));
        model.addAttribute("pageTitle", "编辑" + titlePrefix(businessType) + "记录");
        return "farmer/record-form";
    }

    @PostMapping("/{businessType}/records/save")
    public String saveRecord(@PathVariable("businessType") String businessType, FarmingRecord entity, RedirectAttributes redirectAttributes) {
        farmerService.saveRecord(entity);
        redirectAttributes.addFlashAttribute("successMsg", "记录保存成功");
        return "redirect:/farmer/" + businessType + "/records";
    }

    @GetMapping("/{businessType}/records/delete/{id}")
    public String deleteRecord(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        farmerService.deleteRecord(id, getCurrentUserId(session, defaultUserId(businessType)));
        redirectAttributes.addFlashAttribute("successMsg", "记录删除成功");
        return "redirect:/farmer/" + businessType + "/records";
    }

    @GetMapping("/{businessType}/products")
    public String products(@PathVariable("businessType") String businessType, Integer pageNum, String keyword, HttpSession session, Model model) {
        List<Product> productList = farmerService.getProducts(getCurrentUserId(session, defaultUserId(businessType)), businessType.toUpperCase());
        productList = filterProducts(productList, keyword);
        model.addAttribute("pageResult", PaginationUtils.paginate(
                productList,
                pageNum,
                8
        ));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("keyword", normalizeKeyword(keyword));
        model.addAttribute("pageTitle", "我的农产品");
        return "farmer/product-list";
    }

    @GetMapping("/{businessType}/products/add")
    public String addProductPage(@PathVariable("businessType") String businessType, HttpSession session, Model model) {
        Product entity = new Product();
        entity.setSellerId(getCurrentUserId(session, defaultUserId(businessType)));
        entity.setSellerType(businessType.toUpperCase());
        entity.setStatus("ON_SALE");
        entity.setSalesCount(0);
        entity.setUnit("斤");
        model.addAttribute("entity", entity);
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("categoryOptions", adminService.getProductCategories());
        model.addAttribute("cycleOptions", farmerService.getCycles(getCurrentUserId(session, defaultUserId(businessType)), businessType.toUpperCase()));
        model.addAttribute("pageTitle", "新增农产品");
        return "farmer/product-form";
    }

    @GetMapping("/{businessType}/products/edit/{id}")
    public String editProductPage(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, HttpSession session, Model model) {
        model.addAttribute("entity", farmerService.getProduct(id, getCurrentUserId(session, defaultUserId(businessType))));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("categoryOptions", adminService.getProductCategories());
        model.addAttribute("cycleOptions", farmerService.getCycles(getCurrentUserId(session, defaultUserId(businessType)), businessType.toUpperCase()));
        model.addAttribute("pageTitle", "编辑农产品");
        return "farmer/product-form";
    }

    @PostMapping("/{businessType}/products/save")
    public String saveProduct(@PathVariable("businessType") String businessType, Product entity, HttpSession session, RedirectAttributes redirectAttributes) {
        entity.setSellerId(getCurrentUserId(session, defaultUserId(businessType)));
        entity.setSellerType(businessType.toUpperCase());
        farmerService.saveProduct(entity);
        redirectAttributes.addFlashAttribute("successMsg", "产品保存成功");
        return "redirect:/farmer/" + businessType + "/products";
    }

    @GetMapping("/{businessType}/products/delete/{id}")
    public String deleteProduct(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        farmerService.deleteProduct(id, getCurrentUserId(session, defaultUserId(businessType)));
        redirectAttributes.addFlashAttribute("successMsg", "产品删除成功");
        return "redirect:/farmer/" + businessType + "/products";
    }

    @GetMapping("/{businessType}/orders")
    public String orders(@PathVariable("businessType") String businessType, Integer pageNum, String keyword, HttpSession session, Model model) {
        List<com.farmer.entity.OrderInfo> orderList = farmerService.getOrders(getCurrentUserId(session, defaultUserId(businessType)));
        orderList = filterOrders(orderList, keyword);
        model.addAttribute("pageResult", PaginationUtils.paginate(
                orderList,
                pageNum,
                6
        ));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("keyword", normalizeKeyword(keyword));
        model.addAttribute("pageTitle", "订单管理");
        return "farmer/order-list";
    }

    @GetMapping("/{businessType}/orders/export")
    public void exportOrders(@PathVariable("businessType") String businessType,
                             String keyword,
                             HttpSession session,
                             HttpServletResponse response) throws IOException {
        List<com.farmer.entity.OrderInfo> orderList = farmerService.getOrders(getCurrentUserId(session, defaultUserId(businessType)));
        orderList = filterOrders(orderList, keyword);
        ExcelExportUtils.exportOrders(titlePrefix(businessType) + "户订单数据", orderList, false, response);
    }

    @GetMapping("/{businessType}/comments")
    public String comments(@PathVariable("businessType") String businessType, Integer pageNum, String keyword, HttpSession session, Model model) {
        List<com.farmer.entity.ProductComment> commentList = tradeService.getSellerComments(getCurrentUserId(session, defaultUserId(businessType)));
        commentList = filterComments(commentList, keyword);
        model.addAttribute("pageResult", PaginationUtils.paginate(
                commentList,
                pageNum,
                8
        ));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("keyword", normalizeKeyword(keyword));
        model.addAttribute("pageTitle", "评价管理");
        return "farmer/comment-list";
    }

    @GetMapping("/{businessType}/profile")
    public String profile(@PathVariable("businessType") String businessType, HttpSession session, Model model) {
        Long userId = getCurrentUserId(session, defaultUserId(businessType));
        model.addAttribute("entity", userMapper.selectById(userId));
        model.addAttribute("businessType", businessType.toUpperCase());
        model.addAttribute("pageTitle", "个人信息");
        return "farmer/profile";
    }

    @PostMapping("/{businessType}/profile/save")
    public String saveProfile(@PathVariable("businessType") String businessType, User entity, HttpSession session, RedirectAttributes redirectAttributes) {
        Long userId = getCurrentUserId(session, defaultUserId(businessType));
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
        return "redirect:/farmer/" + businessType + "/profile";
    }

    @PostMapping("/{businessType}/profile/password")
    public String updatePassword(@PathVariable("businessType") String businessType,
                                 String oldPassword,
                                 String newPassword,
                                 String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        Long userId = getCurrentUserId(session, defaultUserId(businessType));
        User current = userMapper.selectById(userId);
        if (current == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "用户信息不存在");
            return "redirect:/farmer/" + businessType + "/profile";
        }
        if (oldPassword == null || !oldPassword.equals(current.getPassword())) {
            redirectAttributes.addFlashAttribute("errorMsg", "原密码输入错误");
            return "redirect:/farmer/" + businessType + "/profile";
        }
        if (newPassword == null || newPassword.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMsg", "请输入新密码");
            return "redirect:/farmer/" + businessType + "/profile";
        }
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("errorMsg", "两次输入的新密码不一致");
            return "redirect:/farmer/" + businessType + "/profile";
        }
        userMapper.updatePassword(userId, newPassword);
        session.setAttribute("loginUser", userMapper.selectById(userId));
        redirectAttributes.addFlashAttribute("successMsg", "密码修改成功");
        return "redirect:/farmer/" + businessType + "/profile";
    }

    @GetMapping("/{businessType}/orders/status/{id}")
    public String updateOrderStatus(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, String status, RedirectAttributes redirectAttributes) {
        tradeService.updateOrderStatus(id, status);
        redirectAttributes.addFlashAttribute("successMsg", "订单状态已更新");
        return "redirect:/farmer/" + businessType + "/orders";
    }

    @PostMapping("/{businessType}/comments/reply/{id}")
    public String replyComment(@PathVariable("businessType") String businessType, @PathVariable("id") Long id, String replyContent, RedirectAttributes redirectAttributes) {
        tradeService.replyComment(id, replyContent);
        redirectAttributes.addFlashAttribute("successMsg", "评价回复成功");
        return "redirect:/farmer/" + businessType + "/comments";
    }

    private Long getCurrentUserId(HttpSession session, Long defaultId) {
        User user = (User) session.getAttribute("loginUser");
        return user == null ? defaultId : user.getId();
    }

    private Long defaultUserId(String businessType) {
        return "breed".equalsIgnoreCase(businessType) ? 3L : 2L;
    }

    private String titlePrefix(String businessType) {
        return "breed".equalsIgnoreCase(businessType) ? "养殖" : "种植";
    }

    private String normalizeKeyword(String keyword) {
        if (keyword == null) {
            return null;
        }
        keyword = keyword.trim();
        return keyword.isEmpty() ? null : keyword;
    }

    private List<FarmingCycle> filterCycles(List<FarmingCycle> source, String keyword) {
        String normalized = normalizeKeyword(keyword);
        if (normalized == null) {
            return source;
        }
        List<FarmingCycle> result = new ArrayList<FarmingCycle>();
        for (FarmingCycle item : source) {
            if (contains(item.getCycleName(), normalized) || contains(item.getItemName(), normalized) || contains(item.getStatus(), normalized)) {
                result.add(item);
            }
        }
        return result;
    }

    private List<FarmingRecord> filterRecords(List<FarmingRecord> source, String keyword) {
        String normalized = normalizeKeyword(keyword);
        if (normalized == null) {
            return source;
        }
        List<FarmingRecord> result = new ArrayList<FarmingRecord>();
        for (FarmingRecord item : source) {
            if (contains(item.getCycleName(), normalized) || contains(item.getTemplateName(), normalized)
                    || contains(item.getRecordTitle(), normalized) || contains(item.getRecordContent(), normalized)) {
                result.add(item);
            }
        }
        return result;
    }

    private List<Product> filterProducts(List<Product> source, String keyword) {
        String normalized = normalizeKeyword(keyword);
        if (normalized == null) {
            return source;
        }
        List<Product> result = new ArrayList<Product>();
        for (Product item : source) {
            if (contains(item.getProductName(), normalized) || contains(item.getCategoryName(), normalized)
                    || contains(item.getDescription(), normalized) || contains(item.getStatus(), normalized)) {
                result.add(item);
            }
        }
        return result;
    }

    private List<com.farmer.entity.OrderInfo> filterOrders(List<com.farmer.entity.OrderInfo> source, String keyword) {
        String normalized = normalizeKeyword(keyword);
        if (normalized == null) {
            return source;
        }
        List<com.farmer.entity.OrderInfo> result = new ArrayList<com.farmer.entity.OrderInfo>();
        for (com.farmer.entity.OrderInfo item : source) {
            boolean matched = contains(item.getOrderNo(), normalized) || contains(item.getUserName(), normalized) || contains(item.getOrderStatus(), normalized);
            if (!matched && item.getItemList() != null) {
                for (com.farmer.entity.OrderItem orderItem : item.getItemList()) {
                    if (contains(orderItem.getProductName(), normalized)) {
                        matched = true;
                        break;
                    }
                }
            }
            if (matched) {
                result.add(item);
            }
        }
        return result;
    }

    private List<com.farmer.entity.ProductComment> filterComments(List<com.farmer.entity.ProductComment> source, String keyword) {
        String normalized = normalizeKeyword(keyword);
        if (normalized == null) {
            return source;
        }
        List<com.farmer.entity.ProductComment> result = new ArrayList<com.farmer.entity.ProductComment>();
        for (com.farmer.entity.ProductComment item : source) {
            if (contains(item.getProductName(), normalized) || contains(item.getUserName(), normalized)
                    || contains(item.getContent(), normalized) || contains(item.getReplyContent(), normalized)
                    || contains(item.getOrderNo(), normalized)) {
                result.add(item);
            }
        }
        return result;
    }

    private boolean contains(String source, String keyword) {
        return source != null && source.contains(keyword);
    }
}
