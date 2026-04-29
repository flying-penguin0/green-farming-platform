package com.farmer.service.impl;

import com.farmer.entity.CartItem;
import com.farmer.entity.OrderInfo;
import com.farmer.entity.OrderItem;
import com.farmer.entity.Product;
import com.farmer.entity.ProductComment;
import com.farmer.entity.UserAddress;
import com.farmer.mapper.TradeMapper;
import com.farmer.service.TradeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class TradeServiceImpl implements TradeService {

    @Resource
    private TradeMapper tradeMapper;

    @Override
    @Transactional
    public void addCartItem(Long userId, Long productId, Integer quantity) {
        Integer realQuantity = quantity == null || quantity < 1 ? 1 : quantity;
        CartItem exists = tradeMapper.selectCartItemByUserAndProduct(userId, productId);
        if (exists == null) {
            CartItem cartItem = new CartItem();
            cartItem.setUserId(userId);
            cartItem.setProductId(productId);
            cartItem.setQuantity(realQuantity);
            tradeMapper.insertCartItem(cartItem);
        } else {
            tradeMapper.updateCartItemQuantity(exists.getId(), exists.getQuantity() + realQuantity);
        }
    }

    @Override
    public List<CartItem> getCartItems(Long userId) {
        return tradeMapper.selectCartItemsByUserId(userId);
    }

    @Override
    @Transactional
    public void updateCartItemQuantity(Long userId, Long cartItemId, Integer quantity) {
        CartItem cartItem = tradeMapper.selectCartItemById(cartItemId);
        if (cartItem == null || cartItem.getUserId() == null || !cartItem.getUserId().equals(userId)) {
            throw new IllegalArgumentException("购物车商品不存在");
        }
        int realQuantity = quantity == null ? 1 : quantity;
        if (realQuantity < 1) {
            realQuantity = 1;
        }
        if (cartItem.getStock() != null && realQuantity > cartItem.getStock()) {
            throw new IllegalArgumentException("购买数量不能超过库存");
        }
        tradeMapper.updateCartItemQuantity(cartItemId, realQuantity);
    }

    @Override
    @Transactional
    public void deleteCartItem(Long id) {
        tradeMapper.deleteCartItem(id);
    }

    @Override
    @Transactional
    public void submitCartAsOrders(Long userId, Long addressId) {
        List<CartItem> cartItems = tradeMapper.selectCartItemsByUserId(userId);
        if (cartItems == null || cartItems.isEmpty()) {
            throw new IllegalArgumentException("购物车中还没有商品");
        }
        createOrders(userId, cartItems, addressId, "购物车下单");
        tradeMapper.deleteCartItemsByUserId(userId);
    }

    @Override
    public Product getOrderProduct(Long productId) {
        return tradeMapper.selectProductForOrder(productId);
    }

    @Override
    @Transactional
    public void submitDirectOrder(Long userId, Long productId, Integer quantity, Long addressId) {
        Product product = tradeMapper.selectProductForOrder(productId);
        if (product == null) {
            throw new IllegalArgumentException("商品不存在");
        }
        Integer realQuantity = quantity == null || quantity < 1 ? 1 : quantity;
        if (product.getStock() == null || product.getStock() < realQuantity) {
            throw new IllegalArgumentException("商品库存不足");
        }

        CartItem item = new CartItem();
        item.setUserId(userId);
        item.setProductId(product.getId());
        item.setProductName(product.getProductName());
        item.setMainImage(product.getMainImage());
        item.setPrice(product.getPrice());
        item.setUnit(product.getUnit());
        item.setStock(product.getStock());
        item.setSellerId(product.getSellerId());
        item.setQuantity(realQuantity);

        List<CartItem> itemList = new ArrayList<CartItem>();
        itemList.add(item);
        createOrders(userId, itemList, addressId, "立即购买");
    }

    @Override
    public List<UserAddress> getUserAddresses(Long userId) {
        return tradeMapper.selectAddressesByUserId(userId);
    }

    @Override
    public UserAddress getUserAddress(Long userId, Long addressId) {
        if (addressId == null) {
            return null;
        }
        return tradeMapper.selectAddressById(addressId, userId);
    }

    @Override
    @Transactional
    public void saveUserAddress(Long userId, UserAddress address) {
        if (address == null) {
            throw new IllegalArgumentException("地址信息不能为空");
        }
        if (isBlank(address.getReceiverName()) || isBlank(address.getReceiverPhone()) || isBlank(address.getDetailAddress())) {
            throw new IllegalArgumentException("请填写完整的收货地址信息");
        }

        address.setUserId(userId);
        boolean makeDefault = address.getIsDefault() != null && address.getIsDefault() == 1;
        List<UserAddress> addressList = tradeMapper.selectAddressesByUserId(userId);
        if ((address.getId() == null && (addressList == null || addressList.isEmpty())) || makeDefault) {
            tradeMapper.clearDefaultAddressByUserId(userId);
            address.setIsDefault(1);
        } else if (address.getIsDefault() == null) {
            address.setIsDefault(0);
        }

        if (address.getId() == null) {
            tradeMapper.insertUserAddress(address);
        } else {
            UserAddress current = tradeMapper.selectAddressById(address.getId(), userId);
            if (current == null) {
                throw new IllegalArgumentException("收货地址不存在");
            }
            tradeMapper.updateUserAddress(address);
        }
    }

    @Override
    @Transactional
    public void deleteUserAddress(Long userId, Long addressId) {
        UserAddress current = tradeMapper.selectAddressById(addressId, userId);
        if (current == null) {
            return;
        }
        tradeMapper.deleteUserAddress(addressId, userId);
        if (current.getIsDefault() != null && current.getIsDefault() == 1) {
            List<UserAddress> addressList = tradeMapper.selectAddressesByUserId(userId);
            if (addressList != null && !addressList.isEmpty()) {
                tradeMapper.clearDefaultAddressByUserId(userId);
                UserAddress first = addressList.get(0);
                first.setIsDefault(1);
                tradeMapper.updateUserAddress(first);
            }
        }
    }

    @Override
    @Transactional
    public void setDefaultAddress(Long userId, Long addressId) {
        UserAddress current = tradeMapper.selectAddressById(addressId, userId);
        if (current == null) {
            throw new IllegalArgumentException("收货地址不存在");
        }
        tradeMapper.clearDefaultAddressByUserId(userId);
        current.setIsDefault(1);
        tradeMapper.updateUserAddress(current);
    }

    private void createOrders(Long userId, List<CartItem> cartItems, Long addressId, String remark) {
        UserAddress address = resolveOrderAddress(userId, addressId);
        Map<Long, List<CartItem>> sellerGroup = new LinkedHashMap<Long, List<CartItem>>();
        for (CartItem item : cartItems) {
            if (!sellerGroup.containsKey(item.getSellerId())) {
                sellerGroup.put(item.getSellerId(), new ArrayList<CartItem>());
            }
            sellerGroup.get(item.getSellerId()).add(item);
        }

        int index = 1;
        for (Map.Entry<Long, List<CartItem>> entry : sellerGroup.entrySet()) {
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (CartItem item : entry.getValue()) {
                totalAmount = totalAmount.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
            }

            OrderInfo orderInfo = new OrderInfo();
            orderInfo.setOrderNo(generateOrderNo(index++));
            orderInfo.setUserId(userId);
            orderInfo.setSellerId(entry.getKey());
            orderInfo.setTotalAmount(totalAmount);
            orderInfo.setOrderStatus("PENDING_SHIP");
            orderInfo.setReceiverName(address.getReceiverName());
            orderInfo.setReceiverPhone(address.getReceiverPhone());
            orderInfo.setReceiverAddress(buildFullAddress(address));
            orderInfo.setRemark(remark);
            orderInfo.setPayTime(new Date());
            tradeMapper.insertOrderInfo(orderInfo);

            for (CartItem item : entry.getValue()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderInfo.getId());
                orderItem.setProductId(item.getProductId());
                orderItem.setProductName(item.getProductName());
                orderItem.setProductImage(item.getMainImage());
                orderItem.setPrice(item.getPrice());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setAmount(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
                tradeMapper.insertOrderItem(orderItem);
                tradeMapper.updateProductStockAndSales(item.getProductId(), item.getQuantity());
            }
        }
    }

    @Override
    public List<OrderInfo> getUserOrders(Long userId, String status) {
        List<OrderInfo> orders = tradeMapper.selectOrdersByUserId(userId, status);
        fillItems(orders);
        return orders;
    }

    @Override
    public List<OrderInfo> getAdminOrders(String keyword, String status) {
        List<OrderInfo> orders = tradeMapper.selectAllOrders(keyword, status);
        fillItems(orders);
        return orders;
    }

    @Override
    @Transactional
    public void updateOrderStatus(Long id, String status) {
        tradeMapper.updateOrderStatus(id, status);
    }

    @Override
    public List<ProductComment> getPendingUserComments(Long userId) {
        return tradeMapper.selectPendingCommentsByUserId(userId);
    }

    @Override
    public List<ProductComment> getUserComments(Long userId) {
        return tradeMapper.selectCommentsByUserId(userId);
    }

    @Override
    public List<ProductComment> getAdminComments(String status, String keyword) {
        return tradeMapper.selectAllComments(status, keyword);
    }

    @Override
    public List<ProductComment> getSellerComments(Long sellerId) {
        return tradeMapper.selectCommentsBySellerId(sellerId);
    }

    @Override
    @Transactional
    public void saveComment(ProductComment comment) {
        ProductComment exists = tradeMapper.selectCommentByOrderItemId(comment.getOrderItemId());
        if (exists == null) {
            tradeMapper.insertComment(comment);
        }
    }

    @Override
    @Transactional
    public void updateCommentStatus(Long id, String status) {
        tradeMapper.updateCommentStatus(id, status);
    }

    @Override
    @Transactional
    public void replyComment(Long id, String replyContent) {
        tradeMapper.updateCommentReply(id, replyContent);
    }

    @Override
    public List<Product> getFavoriteProducts(Long userId) {
        return tradeMapper.selectFavoriteProductsByUserId(userId);
    }

    @Override
    @Transactional
    public boolean addFavorite(Long userId, Long productId) {
        Long existsId = tradeMapper.selectFavoriteIdByUserAndProduct(userId, productId);
        if (existsId != null) {
            return false;
        }
        tradeMapper.insertFavorite(userId, productId);
        return true;
    }

    @Override
    @Transactional
    public void deleteFavorite(Long userId, Long productId) {
        tradeMapper.deleteFavorite(userId, productId);
    }

    private void fillItems(List<OrderInfo> orders) {
        if (orders == null) {
            return;
        }
        for (OrderInfo order : orders) {
            order.setItemList(tradeMapper.selectOrderItemsByOrderId(order.getId()));
        }
    }

    private String generateOrderNo(int suffix) {
        return "GF" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + String.format("%02d", suffix);
    }

    private UserAddress resolveOrderAddress(Long userId, Long addressId) {
        UserAddress address = addressId == null
                ? tradeMapper.selectDefaultAddressByUserId(userId)
                : tradeMapper.selectAddressById(addressId, userId);
        if (address == null) {
            throw new IllegalArgumentException("请先选择收货地址");
        }
        return address;
    }

    private String buildFullAddress(UserAddress address) {
        return safe(address.getProvince()) + safe(address.getCity()) + safe(address.getArea()) + safe(address.getDetailAddress());
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
