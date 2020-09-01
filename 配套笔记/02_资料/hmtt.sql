/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : hmtt

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 16/02/2019 21:39:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS `hmtt`;

CREATE DATABASE IF NOT EXISTS hmtt DEFAULT CHARSET utf8;
USE hmtt;

-- ----------------------------
-- Table structure for global_announcement
-- ----------------------------
DROP TABLE IF EXISTS `global_announcement`;
CREATE TABLE `global_announcement` (
  `announcement_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(32) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '正文',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0-待发布，1-已发布，2-已撤下',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`announcement_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统公告表';

-- ----------------------------
-- Table structure for news_article_basic
-- ----------------------------
DROP TABLE IF EXISTS `news_article_basic`;
CREATE TABLE `news_article_basic` (
  `article_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `channel_id` int(11) unsigned NOT NULL COMMENT '频道ID',
  `title` varchar(128) NOT NULL COMMENT '标题',
  `cover` json NOT NULL COMMENT '封面',
  `is_advertising` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否投放广告，0-不投放，1-投放',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '贴文状态，0-草稿，1-待审核，2-审核通过，3-审核失败，4-已删除',
  `reviewer_id` int(11) DEFAULT NULL COMMENT '审核人员ID',
  `review_time` datetime DEFAULT NULL COMMENT '审核时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计评论数',
  PRIMARY KEY (`article_id`),
  KEY `user_id` (`user_id`),
  KEY `article_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章基本信息表';

-- ----------------------------
-- Table structure for news_article_content
-- ----------------------------
DROP TABLE IF EXISTS `news_article_content`;
CREATE TABLE `news_article_content` (
  `article_id` bigint(20) unsigned NOT NULL COMMENT '文章ID',
  `content` longtext NOT NULL COMMENT '文章内容',
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章内容表';

-- ----------------------------
-- Table structure for news_article_statistic
-- ----------------------------
DROP TABLE IF EXISTS `news_article_statistic`;
CREATE TABLE `news_article_statistic` (
  `article_id` bigint(20) unsigned NOT NULL COMMENT '文章ID',
  `read_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '阅读量',
  `like_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `dislike_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不喜欢数',
  `repost_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '转发数',
  `collect_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章统计表';

-- ----------------------------
-- Table structure for news_channel
-- ----------------------------
DROP TABLE IF EXISTS `news_channel`;
CREATE TABLE `news_channel` (
  `channel_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `channel_name` varchar(32) NOT NULL COMMENT '频道名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`channel_id`),
  UNIQUE KEY `channel_name` (`channel_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='新闻频道表';

-- ----------------------------
-- Table structure for news_collection
-- ----------------------------
DROP TABLE IF EXISTS `news_collection`;
CREATE TABLE `news_collection` (
  `collection_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `article_id` bigint(20) unsigned NOT NULL COMMENT '文章ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否取消收藏, 0-未取消, 1-已取消',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`collection_id`),
  UNIQUE KEY `user_article` (`user_id`,`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of news_collection
-- ----------------------------
BEGIN;
INSERT INTO `news_collection` VALUES (1, 1, 2, '2038-02-16 21:36:25', 1, '2038-02-16 21:36:55');
COMMIT;

-- ----------------------------
-- Table structure for news_read
-- ----------------------------
DROP TABLE IF EXISTS `news_read`;
CREATE TABLE `news_read` (
  `read_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `article_id` bigint(20) unsigned NOT NULL COMMENT '文章ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`read_id`),
  UNIQUE KEY `user_article` (`user_id`,`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户阅读历史';

-- ----------------------------
-- Table structure for news_user_channel
-- ----------------------------
DROP TABLE IF EXISTS `news_user_channel`;
CREATE TABLE `news_user_channel` (
  `user_channel_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `channel_id` int(11) unsigned NOT NULL COMMENT '频道ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除, 0-未删除, 1-已删除',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_channel_id`),
  UNIQUE KEY `user_channel` (`user_id`,`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户关注频道表';

-- ----------------------------
-- Table structure for user_basic
-- ----------------------------
DROP TABLE IF EXISTS `user_basic`;
CREATE TABLE `user_basic` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `mobile` char(11) NOT NULL COMMENT '手机号',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `user_name` varchar(32) NOT NULL COMMENT '昵称',
  `profile_photo` varchar(128) DEFAULT NULL COMMENT '头像',
  `last_login` datetime DEFAULT NULL COMMENT '最后登录时间',
  `is_media` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是自媒体，0-不是，1-是',
  `article_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发文章数',
  `following_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '关注的人数',
  `fans_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '被关注的人数',
  `like_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计点赞人数',
  `read_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计阅读人数',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户基本信息表';

-- ----------------------------
-- Table structure for user_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `user_blacklist`;
CREATE TABLE `user_blacklist` (
  `blacklist_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `blacklist_user_id` bigint(20) unsigned NOT NULL COMMENT '拉黑的用户ID',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否取消拉黑, 0-未取消，1-已取消',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`blacklist_id`),
  UNIQUE KEY `user_blacklist` (`user_id`,`blacklist_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户拉黑表';

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow` (
  `follow_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `following_user_id` bigint(20) unsigned NOT NULL COMMENT '关注的用户ID',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否取消关注，0-未取消，1-已取消',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`follow_id`),
  UNIQUE KEY `user_following` (`user_id`,`following_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户关注表';

-- ----------------------------
-- Table structure for user_material
-- ----------------------------
DROP TABLE IF EXISTS `user_material`;
CREATE TABLE `user_material` (
  `material_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '素材id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '素材类型，0-图片, 1-视频, 2-音频',
  `hash` varchar(128) DEFAULT NULL COMMENT '素材指纹',
  `url` varchar(128) NOT NULL COMMENT '素材链接地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0-待审核，1-审核通过，2-审核失败，3-已删除',
  `reviewer_id` int(11) unsigned DEFAULT NULL COMMENT '审核人员ID',
  `review_time` datetime DEFAULT NULL COMMENT '审核时间',
  `is_collected` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否收藏，0-未收藏，1-已收藏',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`material_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户素材表';

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `gender` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别，0-男，1-女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `real_name` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `introduction` varchar(200) DEFAULT NULL COMMENT '个人简介',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `register_media_time` datetime DEFAULT NULL COMMENT '注册自媒体时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户资料表';

-- ----------------------------
-- Table structure for user_search
-- ----------------------------
DROP TABLE IF EXISTS `user_search`;
CREATE TABLE `user_search` (
  `search_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `keyword` varchar(32) NOT NULL COMMENT '关键词',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除, 0-未删除，1-已删除',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`search_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户搜索历史';

SET FOREIGN_KEY_CHECKS = 1;
