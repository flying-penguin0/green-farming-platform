package com.farmer.service;

import com.farmer.entity.CartItem;
import com.farmer.entity.OrderInfo;
import com.farmer.entity.Product;
import com.farmer.entity.ProductComment;
import com.farmer.entity.UserAddress;

import java.util.List;

public interface TradeService {
    void addCartItem(Long userId, Long productId, Integer quantity);
    List<CartItem> getCartItems(Long userId);
    void updateCartItemQuantity(Long userId, Long cartItemId, Integer quantity);
    void deleteCartItem(Long id);
    void submitCartAsOrders(Long userId, Long addressId);
    Product getOrderProduct(Long productId);
    void submitDirectOrder(Long userId, Long productId, Integer quantity, Long addressId);

    List<UserAddress> getUserAddresses(Long userId);
    UserAddress getUserAddress(Long userId, Long addressId);
    void saveUserAddress(Long userId, UserAddress address);
    void deleteUserAddress(Long userId, Long addressId);
    void setDefaultAddress(Long userId, Long addressId);

    List<OrderInfo> getUserOrders(Long userId, String status);
    List<OrderInfo> getAdminOrders(String keyword, String status);
    void updateOrderStatus(Long id, String status);

    List<ProductComment> getPendingUserComments(Long userId);
    List<ProductComment> getUserComments(Long userId);
    List<ProductComment> getAdminComments(String status, String keyword);
    List<ProductComment> getSellerComments(Long sellerId);
    void saveComment(ProductComment comment);
    void updateCommentStatus(Long id, String status);
    void replyComment(Long id, String replyContent);

    List<Product> getFavoriteProducts(Long userId);
    boolean addFavorite(Long userId, Long productId);
    void deleteFavorite(Long userId, Long productId);
}
