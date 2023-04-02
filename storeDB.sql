/*
 Navicat MySQL Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : storedb

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 02/04/2023 21:11:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

drop database IF EXISTS  `storeDB`;
create database `storeDB`;
use `storeDB`;

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
  `carousel_id` int NOT NULL AUTO_INCREMENT,
  `imgPath` char(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `describes` char(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`carousel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carousel
-- ----------------------------
INSERT INTO `carousel` VALUES (1, 'public/imgs/cms_1.jpg', NULL);
INSERT INTO `carousel` VALUES (2, 'public/imgs/cms_2.jpg', NULL);
INSERT INTO `carousel` VALUES (3, 'public/imgs/cms_3.jpg', NULL);
INSERT INTO `carousel` VALUES (4, 'public/imgs/cms_4.jpg', NULL);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `isDel` tinyint(1) NOT NULL DEFAULT (false),
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '手机', 0);
INSERT INTO `category` VALUES (2, '电视机', 0);
INSERT INTO `category` VALUES (3, '空调', 0);
INSERT INTO `category` VALUES (4, '洗衣机', 0);
INSERT INTO `category` VALUES (5, '保护套', 0);
INSERT INTO `category` VALUES (6, '保护膜', 0);
INSERT INTO `category` VALUES (7, '充电器', 0);
INSERT INTO `category` VALUES (8, '充电宝', 0);

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `collect_time` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_collect_user_id`(`user_id` ASC) USING BTREE,
  INDEX `FK_collect_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `FK_collect_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_collect_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (1, 15, 1, 1679823461732);
INSERT INTO `collect` VALUES (3, 1, 3, 1680259168448);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_num` int NOT NULL,
  `product_price` double NOT NULL,
  `order_status` tinyint(1) NOT NULL DEFAULT 0,
  `order_time` bigint NOT NULL,
  `isDel` tinyint(1) NOT NULL DEFAULT (false),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_order_user_id`(`user_id` ASC) USING BTREE,
  INDEX `FK_order_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `FK_order_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 11679733091873, 1, 5, 3, 699, 0, 1679733091873, 0);
INSERT INTO `orders` VALUES (2, 11679733091873, 1, 10, 3, 1899, 0, 1679733091873, 0);
INSERT INTO `orders` VALUES (3, 11679733091873, 1, 18, 3, 2999, 0, 1679733091873, 0);
INSERT INTO `orders` VALUES (4, 11679811089620, 1, 2, 2, 2599, 0, 1679811089620, 1);
INSERT INTO `orders` VALUES (5, 11679811089620, 1, 34, 3, 49, 0, 1679811089620, 1);
INSERT INTO `orders` VALUES (6, 11679811089620, 1, 23, 4, 59, 0, 1679811089620, 1);
INSERT INTO `orders` VALUES (7, 11679811089620, 1, 22, 3, 19, 0, 1679811089620, 1);
INSERT INTO `orders` VALUES (8, 11679811579313, 1, 30, 1, 129, 0, 1679811579313, 0);
INSERT INTO `orders` VALUES (9, 11679811680227, 1, 31, 2, 69, 0, 1679811680227, 0);
INSERT INTO `orders` VALUES (10, 11679818217848, 1, 2, 4, 2599, 0, 1679818217848, 0);
INSERT INTO `orders` VALUES (11, 11679818238911, 1, 3, 1, 2599, 0, 1679818238911, 0);
INSERT INTO `orders` VALUES (12, 11679818238911, 1, 23, 1, 59, 0, 1679818238911, 0);
INSERT INTO `orders` VALUES (13, 11679818263010, 1, 22, 1, 19, 0, 1679818263010, 0);
INSERT INTO `orders` VALUES (14, 11679818263010, 1, 4, 1, 699, 0, 1679818263010, 0);
INSERT INTO `orders` VALUES (15, 11679818285463, 1, 10, 1, 1899, 0, 1679818285463, 1);
INSERT INTO `orders` VALUES (16, 11679818296045, 1, 22, 2, 19, 0, 1679818296045, 0);
INSERT INTO `orders` VALUES (17, 11679818307119, 1, 9, 1, 799, 0, 1679818307119, 1);
INSERT INTO `orders` VALUES (18, 11679818326528, 1, 9, 1, 799, 0, 1679818326528, 0);
INSERT INTO `orders` VALUES (19, 11679818337654, 1, 4, 1, 699, 0, 1679818337654, 0);
INSERT INTO `orders` VALUES (20, 11679818358616, 1, 34, 1, 49, 0, 1679818358616, 1);
INSERT INTO `orders` VALUES (21, 11679818358616, 1, 33, 1, 49, 0, 1679818358616, 1);
INSERT INTO `orders` VALUES (22, 11679832917418, 4, 6, 1, 1199, 0, 1678032000000, 0);
INSERT INTO `orders` VALUES (23, 11679832952912, 9, 10, 3, 1899, 0, 1679673600000, 1);
INSERT INTO `orders` VALUES (24, 11679832952912, 9, 28, 4, 49, 0, 1679673600000, 1);
INSERT INTO `orders` VALUES (25, 11679832952912, 9, 6, 5, 1199, 0, 1679673600000, 1);
INSERT INTO `orders` VALUES (26, 11679832952912, 9, 5, 6, 699, 0, 1679673600000, 1);
INSERT INTO `orders` VALUES (27, 11679818307119, 1, 9, 10, 799, 0, 1679818307119, 0);
INSERT INTO `orders` VALUES (28, 11679818307119, 1, 3, 2, 2599, 0, 1679818307119, 0);
INSERT INTO `orders` VALUES (29, 11679818307119, 1, 6, 3, 1199, 0, 1679818307119, 0);
INSERT INTO `orders` VALUES (30, 11680250804140, 7, 29, 3, 99, 0, 1680250803000, 0);
INSERT INTO `orders` VALUES (31, 11680250832207, 17, 32, 44, 39, 1, 1680250831000, 0);
INSERT INTO `orders` VALUES (32, 11680250832207, 17, 16, 4, 2599, 1, 1680250831000, 0);
INSERT INTO `orders` VALUES (33, 11679818358616, 1, 34, 1, 49, 1, 1679818358616, 0);
INSERT INTO `orders` VALUES (34, 11679818358616, 1, 33, 1, 49, 1, 1679818358616, 0);
INSERT INTO `orders` VALUES (35, 11679818285463, 1, 10, 1, 1899, 1, 1679818285463, 0);
INSERT INTO `orders` VALUES (36, 11680258994230, 1, 19, 10, 39, 0, 1680258994230, 0);
INSERT INTO `orders` VALUES (37, 11680258994230, 1, 30, 10, 129, 0, 1680258994230, 0);
INSERT INTO `orders` VALUES (38, 11680258994230, 1, 7, 10, 999, 0, 1680258994230, 0);
INSERT INTO `orders` VALUES (39, 11680259118437, 1, 5, 1, 699, 0, 1680259118437, 0);
INSERT INTO `orders` VALUES (40, 11680432819980, 2, 3, 3, 2599, 0, 1680432819000, 1);
INSERT INTO `orders` VALUES (41, 11680432819980, 4, 3, 3, 2599, 1, 1680432819000, 1);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` char(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `category_id` int NOT NULL,
  `product_title` char(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `product_intro` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `product_picture` char(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `product_price` double NOT NULL,
  `product_selling_price` double NOT NULL,
  `product_sales` int NOT NULL,
  `isDel` tinyint(1) NOT NULL DEFAULT (false),
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `FK_product_category`(`category_id` ASC) USING BTREE,
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 'Redmi K30', 1, '120Hz流速屏，全速热爱', '120Hz高帧率流速屏/ 索尼6400万前后六摄 / 6.67\'小孔径全面屏 / 最高可选8GB+256GB大存储 / 高通骁龙730G处理器 / 3D四曲面玻璃机身 / 4500mAh+27W快充 / 多功能NFC', 'public/imgs/phone/Redmi-k30.png', 2000, 1599, 0, 0);
INSERT INTO `product` VALUES (2, 'Redmi K30 5G', 1, '双模5G,120Hz流速屏', '双模5G / 三路并发 / 高通骁龙765G / 7nm 5G低功耗处理器 / 120Hz高帧率流速屏 / 6.67\'小孔径全面屏 / 索尼6400万前后六摄 / 最高可选8GB+256GB大存储 / 4500mAh+30W快充 / 3D四曲面玻璃机身 / 多功能NFC', 'public/imgs/phone/Redmi-k30-5G.png', 2599, 2599, 0, 0);
INSERT INTO `product` VALUES (3, '小米CC9 Pro', 1, '1亿像素,五摄四闪', '1亿像素主摄 / 全场景五摄像头 / 四闪光灯 / 3200万自拍 / 10 倍混合光学变焦，50倍数字变焦 / 5260mAh ⼤电量 / 标配 30W疾速快充 / ⼩米⾸款超薄屏下指纹 / 德国莱茵低蓝光认证 / 多功能NFC / 红外万能遥控 / 1216超线性扬声器', 'public/imgs/phone/Mi-CC9.png', 2799, 2599, 0, 0);
INSERT INTO `product` VALUES (4, 'Redmi 8', 1, '5000mAh超长续航', '5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB', 'public/imgs/phone/Redmi-8.png', 799, 699, 0, 0);
INSERT INTO `product` VALUES (5, 'Redmi 8A', 1, '5000mAh超长续航', '5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB / 1200万AI后置相机', 'public/imgs/phone/Redmi-8A.png', 599, 699, 0, 0);
INSERT INTO `product` VALUES (6, 'Redmi Note8 Pro', 1, '6400万全场景四摄', '6400万四摄小金刚拍照新旗舰超强解析力，超震撼', 'public/imgs/phone/Redmi-Note8-pro.png', 1399, 1199, 0, 0);
INSERT INTO `product` VALUES (7, 'Redmi Note8', 1, '千元4800万四摄', '千元4800万四摄 | 高通骁龙665 | 小金刚品质保证', 'public/imgs/phone/Redmi-Note8.png', 999, 999, 0, 0);
INSERT INTO `product` VALUES (8, 'Redmi 7A', 1, '小巧大电量 持久流畅', '小巧大电量，持久又流畅骁龙8核高性能处理器 | 4000mAh超长续航 | AI人脸解锁 | 整机防泼溅', 'public/imgs/phone/Redmi-7A.png', 599, 539, 0, 0);
INSERT INTO `product` VALUES (9, '小米电视4A 32英寸', 2, '人工智能系统，高清液晶屏', '小米电视4A 32英寸 | 64位四核处理器 | 1GB+4GB大内存 | 人工智能系统', 'public/imgs/appliance/MiTv-4A-32.png', 799, 799, 0, 0);
INSERT INTO `product` VALUES (10, '小米全面屏电视E55A', 2, '全面屏设计，人工智能语音', '全面屏设计 | 内置小爱同学 | 4K + HDR | 杜比DTS | PatchWall | 海量内容 | 2GB + 8GB大存储 | 64位四核处理器', 'public/imgs/appliance/MiTv-E55A.png', 2099, 1899, 0, 0);
INSERT INTO `product` VALUES (11, '小米全面屏电视E65A', 2, '全面屏设计，人工智能语音', '人工智能语音系统 | 海量影视内容 | 4K 超高清屏 | 杜比音效 | 64位四核处理器 | 2GB + 8GB大存储', 'public/imgs/appliance/MiTv-E65A.png', 3999, 2799, 0, 0);
INSERT INTO `product` VALUES (12, '小米电视4X 43英寸', 2, 'FHD全高清屏，人工智能语音', '人工智能语音系统 | FHD全高清屏 | 64位四核处理器 | 海量片源 | 1GB+8GB大内存 | 钢琴烤漆', 'public/imgs/appliance/MiTv-4X-43.png', 1499, 1299, 0, 0);
INSERT INTO `product` VALUES (13, '小米电视4C 55英寸', 2, '4K HDR，人工智能系统', '人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆', 'public/imgs/appliance/MiTv-4C-55.png', 1999, 1799, 0, 0);
INSERT INTO `product` VALUES (14, '小米电视4A 65英寸', 2, '4K HDR，人工智能系统', '人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆', 'public/imgs/appliance/MiTv-4A-65.png', 2999, 2799, 0, 0);
INSERT INTO `product` VALUES (15, '小米壁画电视 65英寸', 2, '壁画外观，全面屏，远场语音', '纯平背板 | 通体13.9mm | 远场语音 | 4K+HDR | 杜比+DTS | 画框模式 | 内置小爱同学 | PatchWall | SoundBar+低音炮 | 四核处理器+大存储', 'public/imgs/appliance/MiTv-ArtTv-65.png', 6999, 6999, 0, 0);
INSERT INTO `product` VALUES (16, '米家互联网空调C1（一级能效）', 3, '变频节能省电，自清洁', '一级能效 | 1.5匹 | 全直流变频 | 高效制冷/热 | 静音设计 | 自清洁 | 全屋互联', 'public/imgs/appliance/AirCondition-V1C1.png', 2699, 2599, 10, 0);
INSERT INTO `product` VALUES (17, '米家空调', 3, '出众静音，快速制冷热', '大1匹 | 三级能效 | 静音 | 快速制冷热 | 广角送风 | 除湿功能 | 高密度过滤网 | 典雅外观', 'public/imgs/appliance/AirCondition-F3W1.png', 1799, 1699, 8, 0);
INSERT INTO `product` VALUES (18, '米家互联网洗烘一体机 Pro 10kg', 4, '智能洗烘，省心省力', '国标双A+级洗烘能力 / 22种洗烘模式 / 智能投放洗涤剂 / 支持小爱同学语音遥控 / 支持OTA在线智能升级 / 智能空气洗 / 除菌率达99.9%+', 'public/imgs/appliance/Washer-Pro-10.png', 2999, 2999, 7, 0);
INSERT INTO `product` VALUES (19, 'Redmi K20/ K20 Pro 怪力魔王保护壳', 5, '怪力魔王专属定制', '优选PC材料，强韧张力，经久耐用 / 精选开孔，全面贴合机身 / 手感轻薄细腻，舒适无负担 / 三款颜色可选，彰显个性，与众不同', 'public/imgs/accessory/protectingShell-RedMi-K20&pro.png', 39, 39, 10, 0);
INSERT INTO `product` VALUES (20, '小米9 ARE U OK保护壳', 5, '一个与众不同的保护壳', '彰显独特个性 / 轻薄无负担 / 优选PC材料 / 贴合机身 / 潮流五色', 'public/imgs/accessory/protectingShell-Mi-9.png', 49, 39, 10, 0);
INSERT INTO `product` VALUES (21, '小米CC9&小米CC9美图定制版 标准高透贴膜', 6, '高清透亮，耐磨性强', '耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感', 'public/imgs/accessory/protectingMen-Mi-CC9.png', 19, 19, 9, 0);
INSERT INTO `product` VALUES (22, '小米CC9e 标准高透贴膜', 6, '高清透亮，耐磨性强', '耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感', 'public/imgs/accessory/protectingMen-Mi-CC9e.png', 19, 19, 9, 0);
INSERT INTO `product` VALUES (23, '小米USB充电器30W快充版（1A1C）', 7, '多一种接口，多一种选择', '双口输出 / 30W 输出 / 可折叠插脚 / 小巧便携', 'public/imgs/accessory/charger-30w.png', 59, 59, 8, 0);
INSERT INTO `product` VALUES (24, '小米USB充电器快充版（18W）', 7, '安卓、苹果设备均可使用', '支持QC3.0设备充电 / 支持iOS设备充电/ 美观耐用', 'public/imgs/accessory/charger-18w.png', 29, 29, 8, 0);
INSERT INTO `product` VALUES (25, '小米USB充电器60W快充版（6口）', 7, '6口输出，USB-C输出接口', '6口输出 / USB-C输出接口 / 支持QC3.0快充协议 / 总输出功率60W', 'public/imgs/accessory/charger-60w.png', 129, 129, 0, 0);
INSERT INTO `product` VALUES (26, '小米USB充电器36W快充版（2口）', 7, '6多重安全保护，小巧便携', '双USB输出接口 / 支持QC3.0快充协议 / 多重安全保护 / 小巧便携', 'public/imgs/accessory/charger-36w.png', 59, 59, 0, 0);
INSERT INTO `product` VALUES (27, '小米车载充电器快充版', 7, '让爱车成为移动充电站', 'QC3.0 双口输出 / 智能温度控制 / 5重安全保护 / 兼容iOS&Android设备', 'public/imgs/accessory/charger-car.png', 69, 69, 0, 0);
INSERT INTO `product` VALUES (28, '小米车载充电器快充版(37W)', 7, '双口快充，车载充电更安全', '单口27W 快充 / 双口输出 / 多重安全保护', 'public/imgs/accessory/charger-car-37w.png', 49, 49, 0, 0);
INSERT INTO `product` VALUES (29, '小米二合一移动电源（充电器）', 7, '一个设备多种用途', '5000mAh充沛电量 / 多协议快充 / USB 口输出', 'public/imgs/accessory/charger-tio.png', 99, 99, 0, 0);
INSERT INTO `product` VALUES (30, '小米无线充电宝青春版10000mAh', 8, '能量满满，无线有线都能充', '10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充', 'public/imgs/accessory/charger-10000mAh.png', 129, 129, 8, 0);
INSERT INTO `product` VALUES (31, '小米CC9 Pro/尊享版 撞色飘带保护壳', 5, '全面贴合，无感更舒适', '优选环保PC材质，强韧张力，全面贴合，无感更舒适', 'public/imgs/accessory/protectingShell-Mi-CC9Pro.png', 69, 69, 0, 0);
INSERT INTO `product` VALUES (32, 'Redmi K20系列 幻境之心保护壳', 5, '柔软坚韧,全面贴合', '优质环保材质，柔软坚韧 / 全面贴合，有效抵抗灰尘 / 鲜亮三种颜色可选，为爱机随时换装', 'public/imgs/accessory/protectingShell-RedMi-K20.png', 39, 39, 0, 0);
INSERT INTO `product` VALUES (33, '小米9 SE 街头风保护壳黑色', 5, '个性时尚,细节出众', '个性时尚 / 细节出众 / 纤薄轻巧 / 多彩时尚', 'public/imgs/accessory/protectingShell-Mi-9SE.png', 49, 49, 0, 0);
INSERT INTO `product` VALUES (34, '小米9 街头风保护壳 红色', 5, '个性时尚,细节出众', '时尚多彩 / 细节出众 / 纤薄轻巧 / 是腕带也是支架', 'public/imgs/accessory/protectingShell-Mi-9-red.png', 49, 49, 0, 0);
INSERT INTO `product` VALUES (35, '小米MIX 3 极简保护壳蓝色', 5, '时尚简约设计，手感细腻顺滑', '时尚简约设计，手感细腻顺滑 / 优质环保PC原材料，强韧张力，经久耐用 / 超薄 0.8MM厚度', 'public/imgs/accessory/protectingShell-Mix-3.png', 49, 12.9, 0, 0);
INSERT INTO `product` VALUES (36, '小米13', 1, '小米13大降价', '小米13大降价，年度旗舰手机', 'public/imgs/upload/upload_a21a0aa66282f1df9488d6b4203b1d45.png', 3999, 2999, 0, 0);

-- ----------------------------
-- Table structure for product_picture
-- ----------------------------
DROP TABLE IF EXISTS `product_picture`;
CREATE TABLE `product_picture`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `product_picture` char(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `intro` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `isDel` tinyint(1) NOT NULL DEFAULT (false),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_picture
-- ----------------------------
INSERT INTO `product_picture` VALUES (1, 1, 'public/imgs/phone/picture/Redmi-k30-1.png', NULL, 0);
INSERT INTO `product_picture` VALUES (2, 1, 'public/imgs/phone/picture/Redmi-k30-2.png', NULL, 0);
INSERT INTO `product_picture` VALUES (3, 1, 'public/imgs/phone/picture/Redmi-k30-3.png', NULL, 0);
INSERT INTO `product_picture` VALUES (4, 1, 'public/imgs/phone/picture/Redmi-k30-4.png', NULL, 0);
INSERT INTO `product_picture` VALUES (5, 1, 'public/imgs/phone/picture/Redmi-k30-5.png', NULL, 0);
INSERT INTO `product_picture` VALUES (6, 2, 'public/imgs/phone/picture/Redmi K30 5G-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (7, 2, 'public/imgs/phone/picture/Redmi K30 5G-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (8, 2, 'public/imgs/phone/picture/Redmi K30 5G-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (9, 2, 'public/imgs/phone/picture/Redmi K30 5G-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (10, 2, 'public/imgs/phone/picture/Redmi K30 5G-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (11, 3, 'public/imgs/phone/picture/MI CC9 Pro-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (12, 3, 'public/imgs/phone/picture/MI CC9 Pro-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (13, 3, 'public/imgs/phone/picture/MI CC9 Pro-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (14, 3, 'public/imgs/phone/picture/MI CC9 Pro-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (15, 3, 'public/imgs/phone/picture/MI CC9 Pro-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (16, 3, 'public/imgs/phone/picture/MI CC9 Pro-6.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (17, 4, 'public/imgs/phone/picture/Redmi 8-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (18, 4, 'public/imgs/phone/picture/Redmi 8-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (19, 4, 'public/imgs/phone/picture/Redmi 8-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (20, 4, 'public/imgs/phone/picture/Redmi 8-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (21, 4, 'public/imgs/phone/picture/Redmi 8-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (22, 5, 'public/imgs/phone/picture/Redmi 8A-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (23, 6, 'public/imgs/phone/picture/Redmi Note8 Pro-1.png', NULL, 0);
INSERT INTO `product_picture` VALUES (24, 6, 'public/imgs/phone/picture/Redmi Note8 Pro-2.png', NULL, 0);
INSERT INTO `product_picture` VALUES (25, 6, 'public/imgs/phone/picture/Redmi Note8 Pro-3.png', NULL, 0);
INSERT INTO `product_picture` VALUES (26, 6, 'public/imgs/phone/picture/Redmi Note8 Pro-4.png', NULL, 0);
INSERT INTO `product_picture` VALUES (27, 6, 'public/imgs/phone/picture/Redmi Note8 Pro-5.png', NULL, 0);
INSERT INTO `product_picture` VALUES (28, 7, 'public/imgs/phone/picture/Redmi Note8-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (29, 7, 'public/imgs/phone/picture/Redmi Note8-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (30, 7, 'public/imgs/phone/picture/Redmi Note8-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (31, 7, 'public/imgs/phone/picture/Redmi Note8-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (32, 7, 'public/imgs/phone/picture/Redmi Note8-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (33, 8, 'public/imgs/phone/picture/Redmi 7A-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (34, 8, 'public/imgs/phone/picture/Redmi 7A-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (35, 8, 'public/imgs/phone/picture/Redmi 7A-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (36, 8, 'public/imgs/phone/picture/Redmi 7A-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (37, 8, 'public/imgs/phone/picture/Redmi 7A-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (38, 9, 'public/imgs/phone/picture/MiTv-4A-32-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (39, 9, 'public/imgs/phone/picture/MiTv-4A-32-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (40, 9, 'public/imgs/phone/picture/MiTv-4A-32-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (41, 9, 'public/imgs/phone/picture/MiTv-4A-32-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (42, 10, 'public/imgs/phone/picture/MiTv-E55A-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (43, 10, 'public/imgs/phone/picture/MiTv-E55A-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (44, 10, 'public/imgs/phone/picture/MiTv-E55A-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (45, 10, 'public/imgs/phone/picture/MiTv-E55A-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (46, 11, 'public/imgs/phone/picture/MiTv-E65A-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (47, 11, 'public/imgs/phone/picture/MiTv-E65A-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (48, 11, 'public/imgs/phone/picture/MiTv-E65A-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (49, 11, 'public/imgs/phone/picture/MiTv-E65A-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (50, 12, 'public/imgs/phone/picture/MiTv-4X 43-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (51, 12, 'public/imgs/phone/picture/MiTv-4X 43-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (52, 12, 'public/imgs/phone/picture/MiTv-4X 43-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (53, 13, 'public/imgs/phone/picture/MiTv-4C 55-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (54, 13, 'public/imgs/phone/picture/MiTv-4C 55-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (55, 13, 'public/imgs/phone/picture/MiTv-4C 55-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (56, 14, 'public/imgs/phone/picture/MiTv-4A 65-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (57, 15, 'public/imgs/phone/picture/MiTv-ArtTv-65-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (58, 16, 'public/imgs/phone/picture/AirCondition-V1C1-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (59, 17, 'public/imgs/phone/picture/AirCondition-F3W1-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (60, 18, 'public/imgs/phone/picture/Washer-Pro-10-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (61, 18, 'public/imgs/phone/picture/Washer-Pro-10-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (62, 18, 'public/imgs/phone/picture/Washer-Pro-10-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (63, 18, 'public/imgs/phone/picture/Washer-Pro-10-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (64, 19, 'public/imgs/phone/picture/protectingShell-RedMi-K20&pro-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (65, 20, 'public/imgs/phone/picture/protectingShell-Mi-9-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (66, 20, 'public/imgs/phone/picture/protectingShell-Mi-9-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (67, 21, 'public/imgs/phone/picture/protectingMen-Mi-CC9-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (68, 22, 'public/imgs/phone/picture/protectingMen-Mi-CC9e-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (69, 23, 'public/imgs/phone/picture/charger-30w-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (70, 23, 'public/imgs/phone/picture/charger-30w-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (71, 23, 'public/imgs/phone/picture/charger-30w-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (72, 23, 'public/imgs/phone/picture/charger-30w-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (73, 24, 'public/imgs/phone/picture/charger-18w-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (74, 24, 'public/imgs/phone/picture/charger-18w-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (75, 24, 'public/imgs/phone/picture/charger-18w-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (76, 25, 'public/imgs/phone/picture/charger-60w-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (77, 25, 'public/imgs/phone/picture/charger-60w-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (78, 25, 'public/imgs/phone/picture/charger-60w-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (79, 25, 'public/imgs/phone/picture/charger-60w-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (80, 26, 'public/imgs/phone/picture/charger-36w-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (81, 26, 'public/imgs/phone/picture/charger-36w-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (82, 26, 'public/imgs/phone/picture/charger-36w-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (83, 26, 'public/imgs/phone/picture/charger-36w-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (84, 26, 'public/imgs/phone/picture/charger-36w-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (85, 27, 'public/imgs/phone/picture/charger-car-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (86, 27, 'public/imgs/phone/picture/charger-car-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (87, 27, 'public/imgs/phone/picture/charger-car-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (88, 27, 'public/imgs/phone/picture/charger-car-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (89, 27, 'public/imgs/phone/picture/charger-car-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (90, 27, 'public/imgs/phone/picture/charger-car-6.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (91, 28, 'public/imgs/phone/picture/charger-car-37w-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (92, 28, 'public/imgs/phone/picture/charger-car-37w-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (93, 28, 'public/imgs/phone/picture/charger-car-37w-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (94, 28, 'public/imgs/phone/picture/charger-car-37w-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (95, 28, 'public/imgs/phone/picture/charger-car-37w-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (96, 29, 'public/imgs/phone/picture/charger-tio-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (97, 29, 'public/imgs/phone/picture/charger-tio-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (98, 29, 'public/imgs/phone/picture/charger-tio-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (99, 29, 'public/imgs/phone/picture/charger-tio-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (100, 29, 'public/imgs/phone/picture/charger-tio-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (101, 30, 'public/imgs/phone/picture/charger-10000mAh-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (102, 30, 'public/imgs/phone/picture/charger-10000mAh-2.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (103, 30, 'public/imgs/phone/picture/charger-10000mAh-3.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (104, 30, 'public/imgs/phone/picture/charger-10000mAh-4.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (105, 30, 'public/imgs/phone/picture/charger-10000mAh-5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (106, 31, 'public/imgs/phone/picture/protectingShell-Mi-CC9Pro-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (107, 32, 'public/imgs/phone/picture/protectingShell-RedMi-K20-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (108, 33, 'public/imgs/phone/picture/protectingShell-Mi-9SE-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (109, 34, 'public/imgs/phone/picture/protectingShell-Mi-9-red-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (110, 35, 'public/imgs/phone/picture/protectingShell-Mix-3-1.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (111, 36, 'public/imgs/upload/upload_5d820d2c91cfb005eb5c9b593fe896f5.jpg', NULL, 0);
INSERT INTO `product_picture` VALUES (112, 36, 'public/imgs/upload/upload_a95853a3858a8252c3648126fe0a16b6.png', NULL, 0);
INSERT INTO `product_picture` VALUES (113, 36, 'public/imgs/upload/upload_22823b068777684b9eea9eeac3c5dae1.png', NULL, 0);
INSERT INTO `product_picture` VALUES (114, 36, 'public/imgs/upload/upload_e7701a91df547e9301647b5b726a4c22.png', NULL, 0);

-- ----------------------------
-- Table structure for shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `shoppingcart`;
CREATE TABLE `shoppingcart`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `num` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_user_id`(`user_id` ASC) USING BTREE,
  INDEX `FK_shoppingCart_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `FK_shoppingCart_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shoppingcart
-- ----------------------------
INSERT INTO `shoppingcart` VALUES (22, 15, 6, 1);
INSERT INTO `shoppingcart` VALUES (23, 15, 17, 2);
INSERT INTO `shoppingcart` VALUES (28, 1, 3, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `userName` char(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` char(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `isAdmin` tinyint(1) NULL DEFAULT (false),
  `userPhoneNumber` char(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `address` char(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `isDel` tinyint(1) NOT NULL DEFAULT (false),
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `userName`(`userName` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'admin123', 1, '18756845432', '杭州市萧山区琳琳', 0);
INSERT INTO `users` VALUES (2, 'test22', 'test77', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (3, 'test444', 'test33', 0, '18945456456', '杭州市上城区', 0);
INSERT INTO `users` VALUES (4, 'test99', 'test99', 0, '18888899999', '', 0);
INSERT INTO `users` VALUES (5, 'sdfsfsf', 'd7342344', 0, '13232435678', '北京市', 0);
INSERT INTO `users` VALUES (6, 'z999999', 'z1833453', 0, '15457896785', '额呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃', 1);
INSERT INTO `users` VALUES (7, 'test555', 'test555', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (8, 'test543', 'test543', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (9, 'test7777', 'test7777', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (10, 'test53676', 'test7777', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (11, 'test868', 'test868', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (12, 'tttfsfsf88', 'tttfsfsf8', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (13, 'admin222', 'vvv7777', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (14, 'test5555', 'z123456', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (15, 'z8888888', 'z123456', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (16, 'd864646', 'z953545', 0, '18753535646', 'kkk', 0);
INSERT INTO `users` VALUES (17, 'fff546667467', 'dddwww', 0, '18953566555', '43535', 0);
INSERT INTO `users` VALUES (18, 'z8843535636', 'z88888', 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (19, 'z8888j', 'z8888j', 0, '18535354445', '32435', 0);
INSERT INTO `users` VALUES (20, 'z8888j6', 'z8888j6', 0, '18756674564', 'fff', 1);

SET FOREIGN_KEY_CHECKS = 1;
