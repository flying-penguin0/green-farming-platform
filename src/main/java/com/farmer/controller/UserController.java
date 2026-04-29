package com.farmer.controller;

import com.farmer.entity.ProductComment;
import com.farmer.entity.User;
import com.farmer.entity.UserAddress;
import com.farmer.mapper.UserMapper;
import com.farmer.service.TradeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private TradeService tradeService;
    @Resource
    private UserMapper userMapper;

    @GetMapping("/center")
    public String center() {
        return "user/center";
    }

    @GetMapping("/addresses")
    public String addresses(Long id, HttpSession session, Model model) {
        Long userId = getCurrentUserId(session);
        model.addAttribute("addressList", tradeService.getUserAddresses(userId));
        UserAddress entity = id == null ? new UserAddress() : tradeService.getUserAddress(userId, id);
        if (entity == null) {
            entity = new UserAddress();
        }
        model.addAttribute("entity", entity);
        return "user/address";
    }

    @PostMapping("/addresses/save")
    public String saveAddress(UserAddress entity, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            tradeService.saveUserAddress(getCurrentUserId(session), entity);
            redirectAttributes.addFlashAttribute("successMsg", "收货地址保存成功");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("errorMsg", ex.getMessage());
        }
        return "redirect:/user/addresses";
    }

    @GetMapping("/addresses/delete/{id}")
    public String deleteAddress(@PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        tradeService.deleteUserAddress(getCurrentUserId(session), id);
        redirectAttributes.addFlashAttribute("successMsg", "收货地址已删除");
        return "redirect:/user/addresses";
    }

    @GetMapping("/addresses/default/{id}")
    public String defaultAddress(@PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            tradeService.setDefaultAddress(getCurrentUserId(session), id);
            redirectAttributes.addFlashAttribute("successMsg", "默认地址已更新");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("errorMsg", ex.getMessage());
        }
        return "redirect:/user/addresses";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        model.addAttribute("entity", userMapper.selectById(getCurrentUserId(session)));
        return "user/profile";
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
        return "redirect:/user/profile";
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
            return "redirect:/user/profile";
        }
        if (oldPassword == null || !oldPassword.equals(current.getPassword())) {
            redirectAttributes.addFlashAttribute("errorMsg", "原密码输入错误");
            return "redirect:/user/profile";
        }
        if (newPassword == null || newPassword.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMsg", "请输入新密码");
            return "redirect:/user/profile";
        }
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("errorMsg", "两次输入的新密码不一致");
            return "redirect:/user/profile";
        }
        userMapper.updatePassword(userId, newPassword);
        session.setAttribute("loginUser", userMapper.selectById(userId));
        redirectAttributes.addFlashAttribute("successMsg", "密码修改成功");
        return "redirect:/user/profile";
    }

    @PostMapping("/cart/add")
    public String addCart(Long productId, Integer quantity, HttpSession session, RedirectAttributes redirectAttributes) {
        tradeService.addCartItem(getCurrentUserId(session), productId, quantity);
        redirectAttributes.addFlashAttribute("successMsg", "已加入购物车");
        return "redirect:/user/cart";
    }

    @PostMapping("/cart/update")
    public String updateCart(Long id, Integer quantity, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            tradeService.updateCartItemQuantity(getCurrentUserId(session), id, quantity);
            redirectAttributes.addFlashAttribute("successMsg", "购物车数量已更新");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("errorMsg", ex.getMessage());
        }
        return "redirect:/user/cart";
    }

    @PostMapping("/cart/update-ajax")
    @ResponseBody
    public Map<String, Object> updateCartAjax(Long id, Integer quantity, HttpSession session) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            Long userId = getCurrentUserId(session);
            tradeService.updateCartItemQuantity(userId, id, quantity);
            java.util.List<com.farmer.entity.CartItem> cartList = tradeService.getCartItems(userId);
            BigDecimal cartTotal = BigDecimal.ZERO;
            com.farmer.entity.CartItem current = null;
            for (com.farmer.entity.CartItem item : cartList) {
                cartTotal = cartTotal.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
                if (item.getId().equals(id)) {
                    current = item;
                }
            }
            result.put("success", true);
            result.put("message", "购物车数量已更新");
            result.put("cartSize", cartList.size());
            result.put("cartTotal", cartTotal);
            if (current != null) {
                result.put("quantity", current.getQuantity());
                result.put("subtotal", current.getPrice().multiply(new BigDecimal(current.getQuantity())));
            }
        } catch (IllegalArgumentException ex) {
            result.put("success", false);
            result.put("message", ex.getMessage());
        }
        return result;
    }

    @GetMapping("/checkout/direct")
    public String directCheckout(Long productId, Integer quantity, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (productId == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "请选择要购买的商品");
            return "redirect:/portal/products";
        }
        com.farmer.entity.Product product = tradeService.getOrderProduct(productId);
        if (product == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "商品不存在或已下架");
            return "redirect:/portal/products";
        }
        model.addAttribute("checkoutMode", "DIRECT");
        model.addAttribute("product", product);
        model.addAttribute("quantity", quantity == null || quantity < 1 ? 1 : quantity);
        model.addAttribute("addressList", tradeService.getUserAddresses(getCurrentUserId(session)));
        return "user/checkout";
    }

    @GetMapping("/favorites")
    public String favorites(HttpSession session, Model model) {
        model.addAttribute("favoriteList", tradeService.getFavoriteProducts(getCurrentUserId(session)));
        return "user/favorites";
    }

    @GetMapping("/favorites/add/{productId}")
    public String addFavorite(@PathVariable("productId") Long productId, HttpSession session, RedirectAttributes redirectAttributes) {
        boolean added = tradeService.addFavorite(getCurrentUserId(session), productId);
        redirectAttributes.addFlashAttribute("successMsg", added ? "收藏成功" : "该商品已在收藏列表中");
        return "redirect:/user/favorites";
    }

    @GetMapping("/favorites/delete/{productId}")
    public String deleteFavorite(@PathVariable("productId") Long productId, HttpSession session, RedirectAttributes redirectAttributes) {
        tradeService.deleteFavorite(getCurrentUserId(session), productId);
        redirectAttributes.addFlashAttribute("successMsg", "已取消收藏");
        return "redirect:/user/favorites";
    }

    @GetMapping("/cart")
    public String cart(HttpSession session, Model model) {
        model.addAttribute("cartList", tradeService.getCartItems(getCurrentUserId(session)));
        model.addAttribute("addressList", tradeService.getUserAddresses(getCurrentUserId(session)));
        return "user/cart";
    }

    @GetMapping("/cart/delete/{id}")
    public String deleteCart(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        tradeService.deleteCartItem(id);
        redirectAttributes.addFlashAttribute("successMsg", "购物车商品已删除");
        return "redirect:/user/cart";
    }

    @PostMapping("/cart/delete-ajax")
    @ResponseBody
    public Map<String, Object> deleteCartAjax(Long id, HttpSession session) {
        Map<String, Object> result = new HashMap<String, Object>();
        Long userId = getCurrentUserId(session);
        tradeService.deleteCartItem(id);
        java.util.List<com.farmer.entity.CartItem> cartList = tradeService.getCartItems(userId);
        BigDecimal cartTotal = BigDecimal.ZERO;
        for (com.farmer.entity.CartItem item : cartList) {
            cartTotal = cartTotal.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        result.put("success", true);
        result.put("message", "购物车商品已删除");
        result.put("cartSize", cartList.size());
        result.put("cartTotal", cartTotal);
        return result;
    }

    @PostMapping("/orders/submit")
    public String submitOrder(Long addressId,
                              String checkoutMode,
                              Long productId,
                              Integer quantity,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        try {
            Long userId = getCurrentUserId(session);
            if ("DIRECT".equals(checkoutMode)) {
                tradeService.submitDirectOrder(userId, productId, quantity, addressId);
            } else {
                tradeService.submitCartAsOrders(userId, addressId);
            }
            redirectAttributes.addFlashAttribute("successMsg", "订单提交成功");
            return "redirect:/user/orders";
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("errorMsg", ex.getMessage());
            if ("DIRECT".equals(checkoutMode)) {
                return "redirect:/user/checkout/direct?productId=" + productId + "&quantity=" + (quantity == null ? 1 : quantity);
            }
            return "redirect:/user/cart";
        }
    }

    @GetMapping("/orders")
    public String orders(String status, HttpSession session, Model model) {
        model.addAttribute("orderList", tradeService.getUserOrders(getCurrentUserId(session), status));
        model.addAttribute("status", status);
        return "user/orders";
    }

    @GetMapping("/orders/receive/{id}")
    public String receive(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        tradeService.updateOrderStatus(id, "FINISHED");
        redirectAttributes.addFlashAttribute("successMsg", "已确认收货");
        return "redirect:/user/orders";
    }

    @GetMapping("/comments")
    public String comments(HttpSession session, Model model) {
        model.addAttribute("pendingCommentList", tradeService.getPendingUserComments(getCurrentUserId(session)));
        model.addAttribute("commentList", tradeService.getUserComments(getCurrentUserId(session)));
        return "user/comments";
    }

    @PostMapping("/comments/save")
    public String saveComment(ProductComment comment, HttpSession session, RedirectAttributes redirectAttributes) {
        comment.setUserId(getCurrentUserId(session));
        tradeService.saveComment(comment);
        redirectAttributes.addFlashAttribute("successMsg", "评价提交成功");
        return "redirect:/user/comments";
    }

    private Long getCurrentUserId(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        return user == null ? 4L : user.getId();
    }
}
