/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : chantingdiancai

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 29/05/2025 18:44:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人',
  `phone` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `isdefault` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否默认地址[是/否]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1614566611577 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '2021-01-25 11:42:19', 1, '宇宙银河系金星1号', '金某', '13823888881', '否');
INSERT INTO `address` VALUES (2, '2021-01-25 11:42:19', 2, '宇宙银河系木星1号', '木某', '13823888882', '是');
INSERT INTO `address` VALUES (3, '2021-01-25 11:42:19', 3, '宇宙银河系水星1号', '水某', '13823888883', '是');
INSERT INTO `address` VALUES (4, '2021-01-25 11:42:19', 4, '宇宙银河系火星1号', '火某', '13823888884', '是');
INSERT INTO `address` VALUES (5, '2021-01-25 11:42:19', 5, '宇宙银河系土星1号', '土某', '13823888885', '是');
INSERT INTO `address` VALUES (6, '2021-01-25 11:42:19', 6, '宇宙银河系月球1号', '月某', '13823888886', '是');
INSERT INTO `address` VALUES (1611546786896, '2021-01-25 11:53:06', 1611546730956, '广东省梅州市梅县区新城街道丽景湾(嘉应西二巷)', '1', '12312312312', '是');
INSERT INTO `address` VALUES (1614566611576, '2021-03-01 10:43:31', 11, '陕西省西安市蓝田县葛牌镇五凤山', '123', '12312312311', '否');

-- ----------------------------
-- Table structure for caipin
-- ----------------------------
DROP TABLE IF EXISTS `caipin`;
CREATE TABLE `caipin`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `caiming` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `hx_types` tinyint(4) NULL DEFAULT NULL COMMENT '菜品名称',
  `money` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品单价 Search',
  `img_photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品图片',
  `caipin_content` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品描述',
  `clicknum` int(11) NULL DEFAULT 0 COMMENT '点击次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '食物表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of caipin
-- ----------------------------
INSERT INTO `caipin` VALUES (1, NULL, 3, 30.00, 'http://localhost:8080/chantingdiancai/upload/1748514297896.png', '<p>11111老好吃了</p>', 0);
INSERT INTO `caipin` VALUES (2, NULL, 2, 20.00, 'http://localhost:8080/chantingdiancai/upload/1748514277811.png', '<p>也挺好吃</p>', 0);
INSERT INTO `caipin` VALUES (5, NULL, 1, 10.00, 'http://localhost:8080/chantingdiancai/upload/1748514257637.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (8, NULL, 4, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514212392.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (9, NULL, 6, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514183707.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (10, NULL, 7, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514145816.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (11, NULL, 8, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514161376.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (12, NULL, 9, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514126091.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (13, NULL, 10, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514105249.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (14, NULL, 11, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514087042.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (15, NULL, 12, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514066489.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (16, NULL, 13, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514044344.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (17, NULL, 14, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748514025535.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (18, NULL, 15, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748513917140.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (19, NULL, 16, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748513877026.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (20, NULL, 17, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748513851491.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (21, NULL, 18, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748513820680.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (23, NULL, 20, 100.00, 'http://localhost:8080/chantingdiancai/upload/1748513777221.png', '<p>非常好吃</p>', 0);
INSERT INTO `caipin` VALUES (28, NULL, 21, 11.00, 'http://localhost:8080/chantingdiancai/upload/1748513737741.png', '<p>1</p>', 0);

-- ----------------------------
-- Table structure for canzhuo
-- ----------------------------
DROP TABLE IF EXISTS `canzhuo`;
CREATE TABLE `canzhuo`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '餐桌名称 Search',
  `tableLocation` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '餐桌位置',
  `sf_types` tinyint(4) NULL DEFAULT NULL COMMENT '是否预定 Search',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '餐桌表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of canzhuo
-- ----------------------------
INSERT INTO `canzhuo` VALUES (1, '1号餐桌', '餐桌位置1', 2);
INSERT INTO `canzhuo` VALUES (2, '2号餐桌', '餐桌位置2', 2);
INSERT INTO `canzhuo` VALUES (3, '3号餐桌', '餐桌位置3', 2);
INSERT INTO `canzhuo` VALUES (4, '4号餐桌', '餐桌位置4', 1);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tablename` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'shangpinxinxi' COMMENT '商品表名',
  `userid` int(20) NOT NULL COMMENT '用户id',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `buynumber` int(11) NOT NULL COMMENT '购买数量',
  `price` float NULL DEFAULT NULL COMMENT '单价',
  `discountprice` float NULL DEFAULT NULL COMMENT '会员价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1748513146940 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1616499729428, '2021-03-23 19:42:08', 'shangpinxinxi', 11, 33, '商品名称3', 'http://localhost:8080/sp-ssmv/upload/1616498421331.webp', 1, 99.9, 0);

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` int(123) NOT NULL COMMENT '用户id',
  `adminid` bigint(20) NULL DEFAULT NULL COMMENT '管理员id',
  `ask` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '提问',
  `reply` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复',
  `isreply` int(11) NULL DEFAULT NULL COMMENT '是否回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1616750223090 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客服聊天表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat
-- ----------------------------
INSERT INTO `chat` VALUES (1616750223089, '2021-03-26 17:17:02', 1, NULL, '111111', NULL, 1);

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'picture1', 'http://localhost:8080/chantingdiancai/upload/1616724528763.jpg');
INSERT INTO `config` VALUES (2, 'picture2', 'http://localhost:8080/chantingdiancai/upload/1616724552478.jpg');
INSERT INTO `config` VALUES (3, 'picture3', 'http://localhost:8080/chantingdiancai/upload/1616724633152.jpg');
INSERT INTO `config` VALUES (4, 'picture4', 'http://localhost:8080/chantingdiancai/upload/1616724648906.jpg');
INSERT INTO `config` VALUES (5, 'picture5', 'http://localhost:8080/chantingdiancai/upload/1616724660864.jpg');

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dic_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段',
  `dic_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `code_index` tinyint(4) NULL DEFAULT NULL COMMENT '编码',
  `index_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码名字',
  `super_id` int(11) NULL DEFAULT NULL COMMENT '父字段id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES (1, 'sex_types', '性别', 1, '男', NULL, '2021-02-25 11:41:54');
INSERT INTO `dictionary` VALUES (2, 'sex_types', '性别', 2, '女', NULL, '2021-02-25 11:41:54');
INSERT INTO `dictionary` VALUES (3, 'sf_types', '是否', 1, '是', NULL, '2021-02-25 11:41:54');
INSERT INTO `dictionary` VALUES (4, 'sf_types', '是否', 2, '否', NULL, '2021-02-25 11:41:54');

-- ----------------------------
-- Table structure for dingdanxiangqing
-- ----------------------------
DROP TABLE IF EXISTS `dingdanxiangqing`;
CREATE TABLE `dingdanxiangqing`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `odd` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号 Search',
  `hx_types` tinyint(4) NULL DEFAULT NULL COMMENT '海鲜名称',
  `number` int(4) NULL DEFAULT NULL COMMENT '数量 Search',
  `money` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dingdanxiangqing
-- ----------------------------
INSERT INTO `dingdanxiangqing` VALUES (1, '1615207060567', 1, 7, 30.00);
INSERT INTO `dingdanxiangqing` VALUES (2, '1615207060567', 2, 18, 20.00);
INSERT INTO `dingdanxiangqing` VALUES (3, '1615207060567', 3, 29, 10.00);
INSERT INTO `dingdanxiangqing` VALUES (11, '1615258272174', 1, 3, 30.00);
INSERT INTO `dingdanxiangqing` VALUES (12, '1615258272174', 2, 2, 20.00);
INSERT INTO `dingdanxiangqing` VALUES (13, '1615258272174', 3, 23, 10.00);
INSERT INTO `dingdanxiangqing` VALUES (14, '1615260728415', 1, 30, 30.00);
INSERT INTO `dingdanxiangqing` VALUES (15, '1616743554501', 3, 3, 30.00);
INSERT INTO `dingdanxiangqing` VALUES (16, '1616743554501', 5, 5, 100.00);
INSERT INTO `dingdanxiangqing` VALUES (17, '1616750385629', 1, 1, 10.00);
INSERT INTO `dingdanxiangqing` VALUES (18, '1616750385629', 2, 2, 20.00);
INSERT INTO `dingdanxiangqing` VALUES (19, '1616750385629', 5, 5, 100.00);
INSERT INTO `dingdanxiangqing` VALUES (20, '1616750385629', 6, 6, 50.00);
INSERT INTO `dingdanxiangqing` VALUES (21, '1620365812257', 2, 2, 20.00);
INSERT INTO `dingdanxiangqing` VALUES (22, '1620365812257', 3, 3, 30.00);
INSERT INTO `dingdanxiangqing` VALUES (23, '1620365812257', 5, 5, 100.00);
INSERT INTO `dingdanxiangqing` VALUES (24, '1620366454527', 1, 1, 10.00);
INSERT INTO `dingdanxiangqing` VALUES (25, '1620366454527', 2, 2, 20.00);
INSERT INTO `dingdanxiangqing` VALUES (26, '1620366454527', 3, 3, 30.00);
INSERT INTO `dingdanxiangqing` VALUES (27, '1620366454527', 5, 5, 100.00);
INSERT INTO `dingdanxiangqing` VALUES (28, '1620366541616', 1, 1, 10.00);
INSERT INTO `dingdanxiangqing` VALUES (29, '1620366541616', 5, 5, 100.00);
INSERT INTO `dingdanxiangqing` VALUES (30, '1620367047486', 2, 2, 20.00);
INSERT INTO `dingdanxiangqing` VALUES (31, '1620367047486', 3, 3, 30.00);

-- ----------------------------
-- Table structure for jiankang
-- ----------------------------
DROP TABLE IF EXISTS `jiankang`;
CREATE TABLE `jiankang`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT ' 主键',
  `yonghuid` int(11) NULL DEFAULT NULL COMMENT '用户id主键',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL COMMENT '内容',
  `createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `type` int(11) NULL DEFAULT NULL COMMENT '1代表是每日健康记录2代表的是饮食计划3代表的是健康报告',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jiankang
-- ----------------------------
INSERT INTO `jiankang` VALUES (2, 1, '我今天运动了100m', '2025-05-21 15:24:27', 1);
INSERT INTO `jiankang` VALUES (3, 1, '我今天爬楼梯爬了十层', '2025-05-21 15:24:36', 1);
INSERT INTO `jiankang` VALUES (10, 1, '饮食计划推荐：\n- 椒盐虾\n- 干锅花菜\n- 香菇青菜\n- 清蒸鲈鱼\n- 麻婆豆腐\n', '2025-05-21 15:58:09', 2);
INSERT INTO `jiankang` VALUES (11, 1, '{\"summary\":\"根据您的健康记录和近期饮食分析，您的运动量适中但蔬菜摄入不足，饮食结构需要调整。\",\"metrics\":[{\"name\":\"运动量\",\"value\":\"爬楼梯10层+运动100m\",\"status\":\"normal\",\"statusText\":\"良好\"},{\"name\":\"蔬菜摄入比例\",\"value\":\"0次\",\"status\":\"danger\",\"statusText\":\"严重不足\"},{\"name\":\"肉类摄入比例\",\"value\":\"1次\",\"status\":\"normal\",\"statusText\":\"正常\"},{\"name\":\"辛辣食物摄入\",\"value\":\"0次\",\"status\":\"normal\",\"statusText\":\"良好\"},{\"name\":\"油炸食物摄入\",\"value\":\"0次\",\"status\":\"normal\",\"statusText\":\"良好\"}],\"suggestions\":[\"建议每日至少摄入3-5份蔬菜，以补充膳食纤维和维生素。\",\"虽然当前肉类摄入正常，但建议增加鱼类和白肉比例，减少红肉摄入。\",\"继续保持良好的运动习惯，建议每周进行3-5次有氧运动。\",\"注意饮食多样化，可以适当增加豆制品和全谷物类食物。\",\"建议记录每日饮水量，确保每日摄入足够水分。\"]}', '2025-05-21 15:58:38', 3);
INSERT INTO `jiankang` VALUES (9, 1, '{\"summary\":\"根据您的健康记录和近期饮食分析，您今天进行了适量的运动，但饮食结构需要调整。\",\"metrics\":[{\"name\":\"运动量\",\"value\":\"100m + 10层楼梯\",\"status\":\"normal\",\"statusText\":\"适中\"},{\"name\":\"蔬菜摄入比例\",\"value\":\"0%\",\"status\":\"danger\",\"statusText\":\"严重不足\"},{\"name\":\"肉类摄入比例\",\"value\":\"100%\",\"status\":\"warning\",\"statusText\":\"偏高\"}],\"suggestions\":[\"建议增加蔬菜摄入量，蔬菜应占每日饮食的35%以上。\",\"虽然您今天的肉类选择较为健康(鱼、海鲜)，但仍建议适当减少肉类比例。\",\"继续保持适量运动，可以尝试增加一些有氧运动。\",\"建议在饮食中加入全谷物和豆类食品，以获得更均衡的营养。\"]}', '2025-05-21 15:56:17', 3);

-- ----------------------------
-- Table structure for kuchuen
-- ----------------------------
DROP TABLE IF EXISTS `kuchuen`;
CREATE TABLE `kuchuen`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品名称 Search',
  `number` int(4) NULL DEFAULT NULL COMMENT '库存数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '库存表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kuchuen
-- ----------------------------
INSERT INTO `kuchuen` VALUES (1, '鲍鱼', 0);
INSERT INTO `kuchuen` VALUES (2, '韭菜', 0);
INSERT INTO `kuchuen` VALUES (3, '红烧鱼', 0);
INSERT INTO `kuchuen` VALUES (4, '生蚝', 4);
INSERT INTO `kuchuen` VALUES (6, '大闸蟹', 8);
INSERT INTO `kuchuen` VALUES (7, '北京烤鸭', 3);
INSERT INTO `kuchuen` VALUES (8, '糖醋排骨', 5);
INSERT INTO `kuchuen` VALUES (9, '麻婆豆腐', 10);
INSERT INTO `kuchuen` VALUES (10, '宫保鸡丁', 7);
INSERT INTO `kuchuen` VALUES (11, '清蒸鲈鱼', 2);
INSERT INTO `kuchuen` VALUES (12, '葱爆羊肉', 0);
INSERT INTO `kuchuen` VALUES (13, '水煮牛肉', 4);
INSERT INTO `kuchuen` VALUES (14, '蒜蓉西兰花', 12);
INSERT INTO `kuchuen` VALUES (15, '酸辣土豆丝', 15);
INSERT INTO `kuchuen` VALUES (16, '香菇青菜', 9);
INSERT INTO `kuchuen` VALUES (17, '干锅花菜', 5);
INSERT INTO `kuchuen` VALUES (18, '椒盐虾', 3);
INSERT INTO `kuchuen` VALUES (20, '酸菜鱼', 5);
INSERT INTO `kuchuen` VALUES (21, '鱼香肉丝', 11);

-- ----------------------------
-- Table structure for liushui
-- ----------------------------
DROP TABLE IF EXISTS `liushui`;
CREATE TABLE `liushui`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `odd` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `cz_types` tinyint(4) NULL DEFAULT NULL COMMENT '餐桌名称',
  `yh_types` tinyint(4) NULL DEFAULT NULL COMMENT '预定用户',
  `sf_types` tinyint(4) NULL DEFAULT NULL COMMENT '是否支付 Search',
  `maxMoney` decimal(10, 2) NULL DEFAULT NULL COMMENT '总价',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '支付时间 Search',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流水表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of liushui
-- ----------------------------
INSERT INTO `liushui` VALUES (18, '1616743554501', 4, 1, 1, 500.00, '2021-03-26 15:25:55');
INSERT INTO `liushui` VALUES (19, '1616750385629', 4, 1, 1, 300.00, '2021-04-27 17:19:46');
INSERT INTO `liushui` VALUES (20, '1620365812257', 4, 1, 2, 500.00, '2021-05-07 13:36:52');
INSERT INTO `liushui` VALUES (21, '1620366454527', 4, 1, 2, 500.00, '2021-05-07 13:47:50');
INSERT INTO `liushui` VALUES (22, '1620366541616', 4, 1, 2, 500.00, '2021-05-07 13:49:04');
INSERT INTO `liushui` VALUES (23, '1620367047486', 4, 1, 2, 90.00, '2021-05-07 13:57:31');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '简介',
  `picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品资讯' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (111, '2021-01-25 11:42:19', '标题1', '简介1', 'http://localhost:8080/chantingdiancai/upload/1616724341543.jpg', '<p><span style=\"color: rgb(96, 98, 102);\">内容1</span></p>');
INSERT INTO `news` VALUES (112, '2021-01-25 11:42:19', '标题2', '简介2', 'http://localhost:8080/chantingdiancai/upload/1616724431102.jpg', '<p>内容2</p>');
INSERT INTO `news` VALUES (113, '2021-01-25 11:42:19', '标题3', '简介3', 'http://localhost:8080/chantingdiancai/upload/1616724461130.jpg', '<p>内容3</p>');
INSERT INTO `news` VALUES (114, '2021-01-25 11:42:19', '标题4', '简介4', 'http://localhost:8080/chantingdiancai/upload/1616724473592.jpg', '<p>内容4</p>');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `orderid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `tablename` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'shangpinxinxi' COMMENT '商品表名',
  `userid` int(20) NOT NULL COMMENT '用户id',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `buynumber` int(11) NOT NULL COMMENT '购买数量',
  `price` float NOT NULL DEFAULT 0 COMMENT '价格/积分',
  `discountprice` float NULL DEFAULT 0 COMMENT '折扣价格',
  `total` float NOT NULL DEFAULT 0 COMMENT '总价格/总积分',
  `discounttotal` float NULL DEFAULT 0 COMMENT '折扣总价格',
  `type` int(11) NULL DEFAULT 1 COMMENT '支付类型',
  `status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orderid`(`orderid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1748513312840 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1619156535251, '2021-04-23 13:42:15', '202142313421357566456', 'caipin', 1, 7, '韭菜', 'http://localhost:8080/chantingdiancai/upload/1616677131810.jpg', 1, 100, 100, 100, 100, 1, '已支付', '宇宙银河系金星1号');
INSERT INTO `orders` VALUES (1619156624480, '2021-04-23 13:43:43', '20214231343372546745', 'caipin', 1, 7, '红烧鱼', 'http://localhost:8080/chantingdiancai/upload/1616677131810.jpg', 1, 100, 100, 100, 100, 1, '已支付', '宇宙银河系金星1号');
INSERT INTO `orders` VALUES (1619156672572, '2021-04-23 13:44:32', '202142313442664996595', 'caipin', 1, 7, '生蚝', 'http://localhost:8080/chantingdiancai/upload/1616677131810.jpg', 1, 100, 100, 100, 100, 1, '已支付', '宇宙银河系金星1号');
INSERT INTO `orders` VALUES (1619156724116, '2021-04-23 13:45:23', '202142313452379789602', 'caipin', 1, 7, '龙虾', 'http://localhost:8080/chantingdiancai/upload/1616677131810.jpg', 1, 100, 100, 100, 100, 1, '已支付', '宇宙银河系金星1号');
INSERT INTO `orders` VALUES (1619156725218, '2021-04-23 13:45:24', '202142313452442456127', 'caipin', 1, 7, '水煮牛肉', 'http://localhost:8080/chantingdiancai/upload/1616677131810.jpg', 1, 100, 100, 100, 100, 1, '已支付', '宇宙银河系金星1号');
INSERT INTO `orders` VALUES (1748513312839, '2025-05-29 18:08:32', '20255291883197648919', 'caipin', 1, 20, '干锅花菜', NULL, 1, 100, 100, 100, 100, 1, '已完成', '宇宙银河系金星1号');

-- ----------------------------
-- Table structure for storeup
-- ----------------------------
DROP TABLE IF EXISTS `storeup`;
CREATE TABLE `storeup`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` int(20) NOT NULL COMMENT '用户id',
  `refid` bigint(20) NULL DEFAULT NULL COMMENT '收藏id',
  `tablename` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收藏名称',
  `picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收藏图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1619149891722 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storeup
-- ----------------------------
INSERT INTO `storeup` VALUES (1616750186150, '2021-03-26 17:16:25', 1, 2, 'caipin', '菜品2', 'http://localhost:8080/chantingdiancai/upload/1616677163192.jpg');
INSERT INTO `storeup` VALUES (1616750191544, '2021-03-26 17:16:30', 1, 1, 'caipin', '菜品3', 'http://localhost:8080/chantingdiancai/upload/1616677176001.jpg');
INSERT INTO `storeup` VALUES (1619149890090, '2021-04-23 11:51:29', 1, 5, 'caipin', '菜品1', 'http://localhost:8080/chantingdiancai/upload/1615266843278.jpg');
INSERT INTO `storeup` VALUES (1619149890101, '2021-04-23 11:51:30', 1, 5, 'caipin', '菜品1', 'http://localhost:8080/chantingdiancai/upload/1615266843278.jpg');
INSERT INTO `storeup` VALUES (1619149891236, '2021-04-23 11:51:30', 1, 5, 'caipin', '菜品1', 'http://localhost:8080/chantingdiancai/upload/1615266843278.jpg');
INSERT INTO `storeup` VALUES (1619149891721, '2021-04-23 11:51:31', 1, 5, 'caipin', '菜品1', 'http://localhost:8080/chantingdiancai/upload/1615266843278.jpg');

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` int(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `tablename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (5, 1, 'admin', 'users', '管理员', '0n5s1mt81rgyenelrpuj9xni39m34zsb', '2021-03-04 11:02:31', '2025-05-29 19:04:35');
INSERT INTO `token` VALUES (6, 1, '111', 'users', '用户', '3g971g4lmm6zdn07xf4sbaxezydw32eq', '2021-03-13 19:35:22', '2025-05-29 19:28:41');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'admin', '管理员', '2021-03-01 00:00:00');

-- ----------------------------
-- Table structure for yonghu
-- ----------------------------
DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE `yonghu`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称  Search111',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `img_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `sex_types` tinyint(4) NULL DEFAULT NULL COMMENT '性别  Search111',
  `phone` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of yonghu
-- ----------------------------
INSERT INTO `yonghu` VALUES (1, '小金', '111', '111', 'http://localhost:8080/chantingdiancai/upload/1615259583314.jpg', 1, '17796312333', '用户');
INSERT INTO `yonghu` VALUES (2, '小札', '222', '222', 'http://localhost:8080/chantingdiancai/upload/1615259866641.jpg', 2, '12312312333', '用户');

-- ----------------------------
-- Table structure for yudingcanzhuo
-- ----------------------------
DROP TABLE IF EXISTS `yudingcanzhuo`;
CREATE TABLE `yudingcanzhuo`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cz_types` tinyint(4) NULL DEFAULT NULL COMMENT '餐桌名称',
  `yh_types` tinyint(4) NULL DEFAULT NULL COMMENT '预定用户',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '预定时间 Search',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '预定餐桌表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of yudingcanzhuo
-- ----------------------------
INSERT INTO `yudingcanzhuo` VALUES (1, 4, 1, '2021-05-07 13:36:25');

SET FOREIGN_KEY_CHECKS = 1;
