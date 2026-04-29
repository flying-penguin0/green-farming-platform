/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80026 (8.0.26)
 Source Host           : localhost:3306
 Source Schema         : green_farming_platform

 Target Server Type    : MySQL
 Target Server Version : 80026 (8.0.26)
 File Encoding         : 65001

 Date: 09/06/2026 10:33:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banner_info
-- ----------------------------
DROP TABLE IF EXISTS `banner_info`;
CREATE TABLE `banner_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '轮播图标题',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片地址',
  `sort_no` int NOT NULL DEFAULT 1 COMMENT '排序号',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ENABLED' COMMENT '状态：ENABLED/DISABLED',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '轮播图表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner_info
-- ----------------------------
INSERT INTO `banner_info` VALUES (1, '绿色种植计划', 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?auto=format&fit=crop&w=1600&q=80', 1, 'ENABLED');
INSERT INTO `banner_info` VALUES (2, '生态养殖专区', 'https://images.unsplash.com/photo-1516467508483-a7212febe31a?auto=format&fit=crop&w=1600&q=80', 2, 'ENABLED');

-- ----------------------------
-- Table structure for cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_item`;
CREATE TABLE `cart_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `product_id` bigint NOT NULL COMMENT '产品ID',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '购买数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_item
-- ----------------------------
INSERT INTO `cart_item` VALUES (4, 4, 2, 12, '2026-04-26 12:54:22');
INSERT INTO `cart_item` VALUES (5, 4, 1, 9, '2026-04-26 15:33:02');
INSERT INTO `cart_item` VALUES (6, 5, 1, 1, '2026-05-14 07:36:38');

-- ----------------------------
-- Table structure for farming_cycle
-- ----------------------------
DROP TABLE IF EXISTS `farming_cycle`;
CREATE TABLE `farming_cycle`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '发布用户ID',
  `business_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型：PLANT/BREED',
  `cycle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '周期名称',
  `scale_value` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '规模数量',
  `scale_unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规模单位，如亩、只、头',
  `start_date` date NOT NULL COMMENT '开始日期',
  `expected_end_date` date NULL DEFAULT NULL COMMENT '预计结束日期',
  `actual_end_date` date NULL DEFAULT NULL COMMENT '实际结束日期',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ONGOING' COMMENT '状态：PENDING/ONGOING/FINISHED/CANCELLED',
  `is_public` tinyint NOT NULL DEFAULT 1 COMMENT '是否公开：0否1是',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '周期说明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '种植养殖周期表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of farming_cycle
-- ----------------------------
INSERT INTO `farming_cycle` VALUES (1, 2, 'PLANT', '春季番茄种植计划', 12.50, '亩', '2026-03-01', '2026-06-20', NULL, 'ONGOING', 1, '采用水肥一体化与生物防治技术，保障全程透明可追溯。', '2026-04-25 18:13:03', '2026-04-25 18:13:03');
INSERT INTO `farming_cycle` VALUES (2, 3, 'BREED', '林下土鸡生态养殖计划', 300.00, '只', '2026-02-15', '2026-06-30', NULL, 'ONGOING', 1, '全程防疫管理，记录投喂、消毒、防疫等关键环节。', '2026-04-25 18:13:03', '2026-04-25 18:13:03');

-- ----------------------------
-- Table structure for farming_record
-- ----------------------------
DROP TABLE IF EXISTS `farming_record`;
CREATE TABLE `farming_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `cycle_id` bigint NOT NULL COMMENT '所属周期ID',
  `template_id` bigint NULL DEFAULT NULL COMMENT '环节模板ID',
  `record_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '记录标题',
  `record_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '记录内容',
  `record_time` datetime NOT NULL COMMENT '记录时间',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '记录图片地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '种植养殖环节记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of farming_record
-- ----------------------------
INSERT INTO `farming_record` VALUES (1, 1, 1, '完成番茄播种', '已完成第一批有机番茄育苗和播种，采用无公害基质土。', '2026-03-01 09:00:00', 'https://images.unsplash.com/photo-1592928302636-c83cf1e1fc64?auto=format&fit=crop&w=1200&q=80', '2026-04-25 18:13:03');
INSERT INTO `farming_record` VALUES (2, 1, 2, '进行有机施肥', '施用有机肥并记录用量，保障苗期生长。', '2026-03-20 10:30:00', 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?auto=format&fit=crop&w=1200&q=80', '2026-04-25 18:13:03');
INSERT INTO `farming_record` VALUES (3, 1, 3, '病虫害绿色防治', '采用黄板和生物药剂进行预防。', '2026-04-05 14:00:00', 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=1200&q=80', '2026-04-25 18:13:03');
INSERT INTO `farming_record` VALUES (4, 2, 5, '完成鸡苗引种', '首批土鸡鸡苗完成入栏并建立养殖档案。', '2026-02-15 08:00:00', 'https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?auto=format&fit=crop&w=1200&q=80', '2026-04-25 18:13:03');
INSERT INTO `farming_record` VALUES (5, 2, 6, '日常生态投喂', '按照阶段饲料比例进行投喂，并补充青草饲料。', '2026-03-08 07:30:00', 'https://images.unsplash.com/photo-1516467508483-a7212febe31a?auto=format&fit=crop&w=1200&q=80', '2026-04-25 18:13:03');
INSERT INTO `farming_record` VALUES (6, 2, 7, '例行防疫处理', '完成重点疫病预防接种并记录编号。', '2026-04-02 16:10:00', 'https://images.unsplash.com/photo-1589923188900-85dae523342b?auto=format&fit=crop&w=1200&q=80', '2026-04-25 18:13:03');

-- ----------------------------
-- Table structure for notice_info
-- ----------------------------
DROP TABLE IF EXISTS `notice_info`;
CREATE TABLE `notice_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告内容',
  `publish_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PUBLISHED' COMMENT '发布状态：PUBLISHED/DRAFT',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice_info
-- ----------------------------
INSERT INTO `notice_info` VALUES (1, '平台试运行公告', '绿色农产品种养殖平台已进入试运行阶段，欢迎体验产品溯源与在线下单功能。', 'PUBLISHED', '2026-04-10 09:00:00');
INSERT INTO `notice_info` VALUES (2, '春季种植专题上线', '新增春季种植周期展示专区，支持查看播种、施肥、病虫害防治等环节记录。', 'PUBLISHED', '2026-04-15 10:00:00');
INSERT INTO `notice_info` VALUES (3, '养殖防疫信息公开提醒', '鼓励养殖户及时维护防疫记录，提升平台透明化展示水平。', 'PUBLISHED', '2026-04-22 11:00:00');

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '下单用户ID',
  `seller_id` bigint NOT NULL COMMENT '卖家ID',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `order_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING_PAY' COMMENT '订单状态：PENDING_PAY/PENDING_SHIP/PENDING_RECEIVE/FINISHED/CANCELLED',
  `receiver_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人电话',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_info_order_no`(`order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_info
-- ----------------------------
INSERT INTO `order_info` VALUES (1, 'GF202604250001', 4, 2, 25.60, 'FINISHED', '王小购', '13800000004', '广东省广州市天河区绿色家园8栋1202', '请尽快发货', '2026-04-20 10:15:00', '2026-04-20 10:20:00', NULL, '2026-04-26 10:42:24');
INSERT INTO `order_info` VALUES (2, 'GF202604250002', 4, 3, 98.00, 'FINISHED', '王小购', '13800000004', '广东省广州市天河区绿色家园8栋1202', '周末配送', '2026-04-18 14:40:00', '2026-04-18 14:45:00', NULL, NULL);
INSERT INTO `order_info` VALUES (3, 'GF2026042611392601', 4, 3, 98.00, 'PENDING_SHIP', '王小购', '13800000004', '广东省广州市天河区绿色家园8栋1202', '购物车下单', '2026-04-26 11:39:26', '2026-04-26 11:39:27', NULL, NULL);
INSERT INTO `order_info` VALUES (4, 'GF2026042611392602', 4, 2, 25.60, 'PENDING_SHIP', '王小购', '13800000004', '广东省广州市天河区绿色家园8栋1202', '购物车下单', '2026-04-26 11:39:26', '2026-04-26 11:39:27', NULL, NULL);
INSERT INTO `order_info` VALUES (5, 'GF2026042612394301', 4, 2, 12.80, 'PENDING_RECEIVE', '王小购', '13800000004', '广东省广州市天河区绿色家园8栋1202', '购物车下单', '2026-04-26 12:39:43', '2026-04-26 12:39:44', '2026-05-14 07:33:52', NULL);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `product_id` bigint NOT NULL COMMENT '产品ID',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `product_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品图片',
  `price` decimal(10, 2) NOT NULL COMMENT '购买单价',
  `quantity` int NOT NULL COMMENT '购买数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '小计金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 1, 1, '绿色有机番茄', 'https://images.unsplash.com/photo-1546470427-e5d9b0d45f17?auto=format&fit=crop&w=1200&q=80', 12.80, 2, 25.60);
INSERT INTO `order_item` VALUES (2, 2, 2, '生态散养土鸡', 'https://images.unsplash.com/photo-1606728035253-49e8a23146de?auto=format&fit=crop&w=1200&q=80', 98.00, 1, 98.00);
INSERT INTO `order_item` VALUES (3, 3, 2, '生态散养土鸡', 'https://images.unsplash.com/photo-1606728035253-49e8a23146de?auto=format&fit=crop&w=1200&q=80', 98.00, 1, 98.00);
INSERT INTO `order_item` VALUES (4, 4, 1, '绿色有机番茄', '/green_farming_platform_war_exploded/static/upload/20260425/07a46b5da9314ad7a3da0e161ea3f880.jpg', 12.80, 2, 25.60);
INSERT INTO `order_item` VALUES (5, 5, 1, '绿色有机番茄', '/green_farming_platform_war_exploded/static/upload/20260425/07a46b5da9314ad7a3da0e161ea3f880.jpg', 12.80, 1, 12.80);
INSERT INTO `order_item` VALUES (6, 6, 1, '绿色有机番茄', '/green_farming_platform_war_exploded/static/upload/20260425/07a46b5da9314ad7a3da0e161ea3f880.jpg', 12.80, 1, 12.80);

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ENABLED' COMMENT '状态：ENABLED/DISABLED',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '农产品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_category
-- ----------------------------
INSERT INTO `product_category` VALUES (1, '新鲜蔬菜', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `product_category` VALUES (2, '生态水果', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `product_category` VALUES (3, '禽蛋肉类', 'ENABLED', '2026-04-25 18:13:03');

-- ----------------------------
-- Table structure for product_comment
-- ----------------------------
DROP TABLE IF EXISTS `product_comment`;
CREATE TABLE `product_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_item_id` bigint NOT NULL COMMENT '订单明细ID',
  `product_id` bigint NOT NULL COMMENT '产品ID',
  `user_id` bigint NOT NULL COMMENT '评价用户ID',
  `score` int NOT NULL DEFAULT 5 COMMENT '评分',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评价内容',
  `reply_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商家回复内容',
  `comment_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'VISIBLE' COMMENT '状态：VISIBLE/HIDDEN',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_comment
-- ----------------------------
INSERT INTO `product_comment` VALUES (1, 2, 2, 2, 4, 5, '肉质结实，配送及时，还能看到防疫记录，买得放心。', '感谢支持，我们会继续做好绿色养殖。', '2026-04-25 18:13:03', 'VISIBLE');
INSERT INTO `product_comment` VALUES (2, 1, 1, 1, 4, 5, '好吃', NULL, '2026-04-26 17:08:42', 'VISIBLE');
INSERT INTO `product_comment` VALUES (3, 6, 6, 1, 5, 5, 'h好好吃', '好吃多买', '2026-05-14 07:37:14', 'VISIBLE');

-- ----------------------------
-- Table structure for product_favorite
-- ----------------------------
DROP TABLE IF EXISTS `product_favorite`;
CREATE TABLE `product_favorite`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `product_id` bigint NOT NULL COMMENT '产品ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_favorite
-- ----------------------------
INSERT INTO `product_favorite` VALUES (1, 4, 1, '2026-04-25 18:13:03');
INSERT INTO `product_favorite` VALUES (2, 4, 2, '2026-04-25 18:13:03');
INSERT INTO `product_favorite` VALUES (3, 5, 1, '2026-05-14 07:31:27');

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` bigint NOT NULL COMMENT '产品ID',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片地址',
  `sort_no` int NOT NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品图片表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_image
-- ----------------------------
INSERT INTO `product_image` VALUES (1, 1, 'https://images.unsplash.com/photo-1546470427-e5d9b0d45f17?auto=format&fit=crop&w=1200&q=80', 1);
INSERT INTO `product_image` VALUES (2, 2, 'https://images.unsplash.com/photo-1606728035253-49e8a23146de?auto=format&fit=crop&w=1200&q=80', 1);

-- ----------------------------
-- Table structure for product_info
-- ----------------------------
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `seller_id` bigint NOT NULL COMMENT '卖家ID',
  `seller_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '卖家类型：PLANT/BREED',
  `source_cycle_id` bigint NOT NULL COMMENT '来源周期ID',
  `price` decimal(10, 2) NOT NULL COMMENT '销售单价',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存数量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计量单位',
  `main_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主图地址',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品简介',
  `sales_count` int NOT NULL DEFAULT 0 COMMENT '销量',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ON_SALE' COMMENT '状态：ON_SALE/OFF_SHELF',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '农产品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_info
-- ----------------------------
INSERT INTO `product_info` VALUES (1, '绿色有机番茄', 1, 2, 'PLANT', 1, 12.80, 276, '斤', '/green_farming_platform_war_exploded/static/upload/20260425/07a46b5da9314ad7a3da0e161ea3f880.jpg', '来自公开种植周期，可查看播种、施肥、病虫害防治时间线。', 90, 'ON_SALE', '2026-04-25 18:13:03', '2026-05-14 07:31:05');
INSERT INTO `product_info` VALUES (2, '生态散养土鸡', 3, 3, 'BREED', 2, 98.00, 119, '只', 'https://images.unsplash.com/photo-1606728035253-49e8a23146de?auto=format&fit=crop&w=1200&q=80', '生态放养、规范防疫，支持查看养殖过程记录。', 55, 'ON_SALE', '2026-04-25 18:13:03', '2026-04-26 11:39:26');

-- ----------------------------
-- Table structure for stage_template
-- ----------------------------
DROP TABLE IF EXISTS `stage_template`;
CREATE TABLE `stage_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `template_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '环节模板名称',
  `business_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型：PLANT/BREED',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注说明',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ENABLED' COMMENT '状态：ENABLED/DISABLED',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '种植养殖环节模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stage_template
-- ----------------------------
INSERT INTO `stage_template` VALUES (1, '播种', 'PLANT', '种植初始环节', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `stage_template` VALUES (2, '施肥', 'PLANT', '记录施肥用量与方式', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `stage_template` VALUES (3, '病虫害防治', 'PLANT', '记录绿色防治措施', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `stage_template` VALUES (4, '采收', 'PLANT', '记录采收时间与品质', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `stage_template` VALUES (5, '引种', 'BREED', '养殖初始环节', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `stage_template` VALUES (6, '喂养', 'BREED', '记录投喂情况', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `stage_template` VALUES (7, '防疫', 'BREED', '记录疫苗与防疫措施', 'ENABLED', '2026-04-25 18:13:03');
INSERT INTO `stage_template` VALUES (8, '出栏', 'BREED', '记录出栏时间', 'ENABLED', '2026-04-25 18:13:03');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像地址',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `role_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色类型：ADMIN/USER/PLANTER/BREEDER',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ENABLED' COMMENT '状态：ENABLED/DISABLED/PENDING',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_sys_user_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '123456', '系统管理员', '13800000001', 'admin@farmer.com', '/green_farming_platform_war_exploded/static/upload/20260426/1e7671dbc5c347009425c4dd0a46ccbf.jpg', '男', 'ADMIN', 'ENABLED', '2026-04-25 18:13:03', '2026-04-26 17:31:40');
INSERT INTO `sys_user` VALUES (2, 'planter01', '123456', '张种植', '13800000002', 'planter@farmer.com', NULL, '男', 'PLANTER', 'ENABLED', '2026-04-25 18:13:03', '2026-04-25 18:13:03');
INSERT INTO `sys_user` VALUES (3, 'breeder01', '123456', '李养殖', '13800000003', 'breeder@farmer.com', '/green_farming_platform_war_exploded/static/upload/20260426/aa064886257741a8b02c0ea372f32adf.png', '男', 'BREEDER', 'ENABLED', '2026-04-25 18:13:03', '2026-04-26 00:31:39');
INSERT INTO `sys_user` VALUES (4, 'user01', '123456', '王小购', '13800000004', 'user@farmer.com', '/green_farming_platform_war_exploded/static/upload/20260426/e7eaaeee0ac84c7daa454a070b15f6fb.jpg', '男', 'USER', 'ENABLED', '2026-04-25 18:13:03', '2026-04-26 12:42:58');

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '所属用户ID',
  `receiver_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人电话',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '城市',
  `area` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区县',
  `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `is_default` tinyint NOT NULL DEFAULT 0 COMMENT '是否默认地址：0否1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_address
-- ----------------------------
INSERT INTO `user_address` VALUES (1, 4, '王小购', '13800000004', '广东省', '广州市', '天河区', '测试', 1, '2026-04-25 18:13:03');

SET FOREIGN_KEY_CHECKS = 1;
