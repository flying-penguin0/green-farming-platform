package com.farmer.controller;

import com.farmer.dto.PortalSellerGroupDTO;
import com.farmer.entity.FarmingCycle;
import com.farmer.entity.FarmingRecord;
import com.farmer.entity.Product;
import com.farmer.service.PortalService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/portal")
public class PortalController {

    @Resource
    private PortalService portalService;

    @GetMapping("/home")
    public String home(Model model) {
        model.addAttribute("stats", portalService.getPortalStats());
        model.addAttribute("banners", portalService.getBanners());
        model.addAttribute("notices", portalService.getNotices());
        model.addAttribute("portalNav", "home");
        return "portal/home";
    }

    @GetMapping("/plant-cycles")
    public String plantCycles(Model model) {
        List<FarmingCycle> cycles = portalService.getPublicCycles("PLANT");
        model.addAttribute("pageTitle", "\u79cd\u690d\u5468\u671f");
        model.addAttribute("portalNav", "plant");
        model.addAttribute("cycles", cycles);
        model.addAttribute("recordMap", buildRecordMap(cycles));
        return "portal/plant-cycle-list";
    }

    @GetMapping("/breed-cycles")
    public String breedCycles(Model model) {
        List<FarmingCycle> cycles = portalService.getPublicCycles("BREED");
        model.addAttribute("pageTitle", "\u517b\u6b96\u5468\u671f");
        model.addAttribute("portalNav", "breed");
        model.addAttribute("cycles", cycles);
        model.addAttribute("recordMap", buildRecordMap(cycles));
        return "portal/breed-cycle-list";
    }

    @GetMapping("/products")
    public String products(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        if (keyword != null) {
            keyword = keyword.trim();
            if (keyword.length() == 0) {
                keyword = null;
            }
        }
        List<Product> products = portalService.getPortalProducts(keyword);
        model.addAttribute("pageTitle", "\u519c\u4ea7\u54c1");
        model.addAttribute("portalNav", "products");
        model.addAttribute("keyword", keyword);
        model.addAttribute("productCount", products.size());
        model.addAttribute("sellerGroups", buildSellerGroups(products));
        return "portal/product-list";
    }

    @GetMapping("/notices")
    public String notices(Model model) {
        model.addAttribute("pageTitle", "\u5e73\u53f0\u516c\u544a");
        model.addAttribute("portalNav", "notices");
        model.addAttribute("notices", portalService.getNotices());
        return "portal/notice-list";
    }

    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable("id") Long id, Model model) {
        Product product = portalService.getProductDetail(id);
        FarmingCycle cycle = null;
        List<FarmingRecord> records = new ArrayList<FarmingRecord>();
        if (product != null && product.getSourceCycleId() != null) {
            cycle = portalService.getCycleDetail(product.getSourceCycleId());
            records = portalService.getCycleRecords(product.getSourceCycleId());
        }
        model.addAttribute("portalNav", "products");
        model.addAttribute("pageTitle", "\u4ea7\u54c1\u8be6\u60c5");
        model.addAttribute("product", product);
        model.addAttribute("cycle", cycle);
        model.addAttribute("records", records);
        model.addAttribute("commentList", portalService.getProductComments(id));
        return "portal/product-detail";
    }

    @GetMapping("/seller-products")
    public String sellerProducts(@RequestParam("sellerId") Long sellerId,
                                 @RequestParam(value = "sellerType", required = false) String sellerType,
                                 Model model) {
        String normalizedSellerType = normalizeSellerType(sellerType);
        List<Product> products = portalService.getSellerProducts(sellerId, normalizedSellerType);
        String sellerName = products.isEmpty() ? "\u672a\u547d\u540d\u7528\u6237" : products.get(0).getSellerName();
        String sellerAvatar = products.isEmpty() ? null : products.get(0).getSellerAvatar();

        model.addAttribute("pageTitle", "\u5546\u6237\u5546\u54c1");
        model.addAttribute("portalNav", "products");
        model.addAttribute("sellerId", sellerId);
        model.addAttribute("sellerType", normalizedSellerType);
        model.addAttribute("sellerName", sellerName);
        model.addAttribute("sellerAvatar", sellerAvatar);
        model.addAttribute("products", products);
        model.addAttribute("productCount", products.size());
        return "portal/seller-product-list";
    }

    @GetMapping("/trace/{cycleId}")
    public String traceDetail(@PathVariable("cycleId") Long cycleId, Model model) {
        FarmingCycle cycle = portalService.getCycleDetail(cycleId);
        model.addAttribute("portalNav", "BREED".equalsIgnoreCase(cycle.getBusinessType()) ? "breed" : "plant");
        model.addAttribute("cycle", cycle);
        model.addAttribute("records", portalService.getCycleRecords(cycleId));
        return "portal/trace-detail";
    }

    private Map<Long, List<FarmingRecord>> buildRecordMap(List<FarmingCycle> cycles) {
        Map<Long, List<FarmingRecord>> recordMap = new LinkedHashMap<Long, List<FarmingRecord>>();
        for (FarmingCycle cycle : cycles) {
            recordMap.put(cycle.getId(), portalService.getCycleRecords(cycle.getId()));
        }
        return recordMap;
    }

    private List<PortalSellerGroupDTO> buildSellerGroups(List<Product> products) {
        Map<String, PortalSellerGroupDTO> groupMap = new LinkedHashMap<String, PortalSellerGroupDTO>();
        for (Product product : products) {
            String sellerType = normalizeSellerType(product.getSellerType());
            Long sellerId = product.getSellerId() == null ? 0L : product.getSellerId();
            String key = sellerType + "_" + sellerId;
            PortalSellerGroupDTO group = groupMap.get(key);
            if (group == null) {
                group = new PortalSellerGroupDTO();
                group.setSellerId(product.getSellerId());
                group.setSellerType(sellerType);
                group.setSellerName(product.getSellerName() == null ? "\u672a\u547d\u540d\u7528\u6237" : product.getSellerName());
                group.setSellerAvatar(product.getSellerAvatar());
                groupMap.put(key, group);
            }
            group.addProduct(product);
        }
        return new ArrayList<PortalSellerGroupDTO>(groupMap.values());
    }

    private String normalizeSellerType(String sellerType) {
        if (sellerType == null) {
            return "";
        }
        if ("BREEDER".equalsIgnoreCase(sellerType)) {
            return "BREED";
        }
        if ("PLANTER".equalsIgnoreCase(sellerType)) {
            return "PLANT";
        }
        return sellerType.toUpperCase();
    }
}
