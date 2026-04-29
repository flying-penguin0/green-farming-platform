package com.farmer.mapper;

import com.farmer.entity.CartItem;
import com.farmer.entity.OrderInfo;
import com.farmer.entity.OrderItem;
import com.farmer.entity.Product;
import com.farmer.entity.ProductComment;
import com.farmer.entity.UserAddress;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TradeMapper {
    List<CartItem> selectCartItemsByUserId(@Param("userId") Long userId);
    CartItem selectCartItemByUserAndProduct(@Param("userId") Long userId, @Param("productId") Long productId);
    CartItem selectCartItemById(@Param("id") Long id);
    int insertCartItem(CartItem cartItem);
    int updateCartItemQuantity(@Param("id") Long id, @Param("quantity") Integer quantity);
    int deleteCartItem(@Param("id") Long id);
    int deleteCartItemsByUserId(@Param("userId") Long userId);

    List<UserAddress> selectAddressesByUserId(@Param("userId") Long userId);
    UserAddress selectDefaultAddressByUserId(@Param("userId") Long userId);
    UserAddress selectAddressById(@Param("id") Long id, @Param("userId") Long userId);
    int clearDefaultAddressByUserId(@Param("userId") Long userId);
    int insertUserAddress(UserAddress address);
    int updateUserAddress(UserAddress address);
    int deleteUserAddress(@Param("id") Long id, @Param("userId") Long userId);
    Product selectProductForOrder(@Param("productId") Long productId);

    int insertOrderInfo(OrderInfo orderInfo);
    int insertOrderItem(OrderItem orderItem);
    List<OrderInfo> selectOrdersByUserId(@Param("userId") Long userId, @Param("status") String status);
    List<OrderInfo> selectAllOrders(@Param("keyword") String keyword, @Param("status") String status);
    OrderInfo selectOrderById(@Param("id") Long id);
    List<OrderItem> selectOrderItemsByOrderId(@Param("orderId") Long orderId);
    int updateOrderStatus(@Param("id") Long id, @Param("status") String status);

    int updateProductStockAndSales(@Param("productId") Long productId, @Param("quantity") Integer quantity);

    List<ProductComment> selectPendingCommentsByUserId(@Param("userId") Long userId);
    List<ProductComment> selectCommentsByUserId(@Param("userId") Long userId);
    List<ProductComment> selectAllComments(@Param("status") String status, @Param("keyword") String keyword);
    List<ProductComment> selectCommentsBySellerId(@Param("sellerId") Long sellerId);
    ProductComment selectCommentByOrderItemId(@Param("orderItemId") Long orderItemId);
    int insertComment(ProductComment comment);
    int updateCommentStatus(@Param("id") Long id, @Param("status") String status);
    int updateCommentReply(@Param("id") Long id, @Param("replyContent") String replyContent);

    List<Product> selectFavoriteProductsByUserId(@Param("userId") Long userId);
    Long selectFavoriteIdByUserAndProduct(@Param("userId") Long userId, @Param("productId") Long productId);
    int insertFavorite(@Param("userId") Long userId, @Param("productId") Long productId);
    int deleteFavorite(@Param("userId") Long userId, @Param("productId") Long productId);
}
