CREATE DATABASE IF NOT EXISTS haomian DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE haomian;

CREATE TABLE IF NOT EXISTS user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    phone VARCHAR(20) NOT NULL UNIQUE COMMENT '手机号',
    nickname VARCHAR(50) COMMENT '昵称',
    avatar VARCHAR(500) COMMENT '头像URL',
    level INT DEFAULT 1 COMMENT '等级',
    exp BIGINT DEFAULT 0 COMMENT '经验值',
    star_moon_coins BIGINT DEFAULT 0 COMMENT '星月币',
    streak_days INT DEFAULT 0 COMMENT '连续打卡天数',
    sleep_goal INT DEFAULT 8 COMMENT '目标睡眠时长(小时)',
    total_sleep_hours DECIMAL(10,2) DEFAULT 0.00 COMMENT '总睡眠时长',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted INT DEFAULT 0 COMMENT '0:未删除 1:已删除'
) COMMENT='用户表';

CREATE TABLE IF NOT EXISTS checkin (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL COMMENT '用户ID',
    sleep_time DATETIME COMMENT '入睡时间',
    wake_time DATETIME COMMENT '醒来时间',
    duration DECIMAL(5,2) COMMENT '睡眠时长(小时)',
    is_goal_met INT DEFAULT 0 COMMENT '是否达成目标 0:否 1:是',
    source VARCHAR(20) DEFAULT 'manual' COMMENT '数据来源 manual:手动 device:设备',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted INT DEFAULT 0 COMMENT '0:未删除 1:已删除',
    INDEX idx_user_id (user_id),
    INDEX idx_sleep_time (sleep_time)
) COMMENT='打卡记录表';

CREATE TABLE IF NOT EXISTS level (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    level INT NOT NULL UNIQUE COMMENT '等级',
    title VARCHAR(20) COMMENT '等级称号',
    min_exp BIGINT NOT NULL COMMENT '最小经验值',
    reward_desc TEXT COMMENT '奖励描述',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT='等级配置表';

CREATE TABLE IF NOT EXISTS music (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL COMMENT '音乐标题',
    category VARCHAR(50) COMMENT '分类',
    file_url VARCHAR(500) NOT NULL COMMENT '文件URL',
    cover_url VARCHAR(500) COMMENT '封面URL',
    duration INT COMMENT '时长(秒)',
    play_count BIGINT DEFAULT 0 COMMENT '播放次数',
    description TEXT COMMENT '描述',
    tags VARCHAR(200) COMMENT '标签',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted INT DEFAULT 0 COMMENT '0:未删除 1:已删除',
    INDEX idx_category (category)
) COMMENT='助眠音乐表';

CREATE TABLE IF NOT EXISTS video (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL COMMENT '视频标题',
    category VARCHAR(50) COMMENT '分类',
    file_url VARCHAR(500) NOT NULL COMMENT '文件URL',
    cover_url VARCHAR(500) COMMENT '封面URL',
    duration INT COMMENT '时长(秒)',
    play_count BIGINT DEFAULT 0 COMMENT '播放次数',
    description TEXT COMMENT '描述',
    tags VARCHAR(200) COMMENT '标签',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted INT DEFAULT 0 COMMENT '0:未删除 1:已删除',
    INDEX idx_category (category)
) COMMENT='助眠视频表';

CREATE TABLE IF NOT EXISTS post (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL COMMENT '用户ID',
    content TEXT NOT NULL COMMENT '帖子内容',
    images VARCHAR(1000) COMMENT '图片URL列表，逗号分隔',
    tags VARCHAR(200) COMMENT '标签',
    circle_id BIGINT COMMENT '圈子ID',
    like_count BIGINT DEFAULT 0 COMMENT '点赞数',
    comment_count BIGINT DEFAULT 0 COMMENT '评论数',
    is_official INT DEFAULT 0 COMMENT '是否官方 0:否 1:是',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted INT DEFAULT 0 COMMENT '0:未删除 1:已删除',
    INDEX idx_user_id (user_id),
    INDEX idx_create_time (create_time)
) COMMENT='帖子表';

CREATE TABLE IF NOT EXISTS device (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL COMMENT '用户ID',
    brand VARCHAR(50) COMMENT '品牌',
    model VARCHAR(50) COMMENT '型号',
    bluetooth_mac VARCHAR(50) COMMENT '蓝牙MAC地址',
    last_sync_time DATETIME COMMENT '最后同步时间',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted INT DEFAULT 0 COMMENT '0:未删除 1:已删除',
    INDEX idx_user_id (user_id)
) COMMENT='设备表';

CREATE TABLE IF NOT EXISTS sleep_data (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL COMMENT '用户ID',
    device_id BIGINT COMMENT '设备ID',
    date DATE NOT NULL COMMENT '日期',
    deep_sleep DECIMAL(5,2) COMMENT '深睡时长(小时)',
    light_sleep DECIMAL(5,2) COMMENT '浅睡时长(小时)',
    rem DECIMAL(5,2) COMMENT 'REM时长(小时)',
    awake DECIMAL(5,2) COMMENT '清醒时长(小时)',
    sleep_score INT COMMENT '睡眠评分(0-100)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted INT DEFAULT 0 COMMENT '0:未删除 1:已删除',
    INDEX idx_user_id (user_id),
    INDEX idx_date (date)
) COMMENT='睡眠数据记录表';

INSERT INTO level (level, title, min_exp, reward_desc) VALUES
(1, '初入梦乡', 0, '解锁基础功能'),
(2, '睡眠学徒', 100, '解锁新的助眠内容'),
(3, '规律睡眠者', 300, '专属头像框'),
(4, '睡眠达人', 600, '更多专属特权'),
(5, '睡眠专家', 1000, '社区高级权限'),
(6, '睡神', 2000, '全部功能解锁'),
(7, '传说级睡神', 5000, '终身VIP');

INSERT INTO music (title, category, file_url, duration, description, tags) VALUES
('雨声入梦', '白噪音', 'https://example.com/rain.mp3', 3600, '淅淅沥沥的雨声，伴你入眠', '放松,雨声'),
('溪水潺潺', '自然声', 'https://example.com/stream.mp3', 3600, '清澈的溪水声，舒缓身心', '自然,放松'),
('森林鸟语', '自然声', 'https://example.com/forest.mp3', 3600, '清晨的森林，鸟语花香', '自然,清晨'),
('轻柔钢琴', '轻音乐', 'https://example.com/piano.mp3', 1800, '温柔的钢琴曲，平静心情', '钢琴,轻柔'),
('冥想引导', '冥想', 'https://example.com/meditation.mp3', 1800, '专业的冥想引导，放松身心', '冥想,引导');

INSERT INTO video (title, category, file_url, duration, description, tags) VALUES
('星空入眠', '自然风景', 'https://example.com/starry-sky.mp4', 3600, '美丽的星空，伴你入眠', '星空,风景'),
('海浪轻拍', '自然风景', 'https://example.com/ocean.mp4', 3600, '海浪轻轻拍打着沙滩', '海洋,放松'),
('睡前呼吸练习', '呼吸练习', 'https://example.com/breathing.mp4', 600, '简单的睡前呼吸练习', '呼吸,练习');
