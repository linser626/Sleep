# 好眠 - 健康睡眠助手

一款帮助用户监督健康睡眠的移动应用，提供睡眠打卡、助眠内容、社区交流和设备数据同步等功能。

## 技术栈

### 前端
- **Flutter** - 跨平台移动应用框架
- **Riverpod** - 状态管理
- **Go Router** - 路由管理
- **Dio** - 网络请求
- **Audioplayers** - 音频播放
- **Video Player** - 视频播放
- **Flutter Blue Plus** - 蓝牙设备连接
- **FL Chart** - 图表展示

### 后端
- **Spring Boot** - Java 后端框架
- **MyBatis Plus** - ORM 框架
- **MySQL** - 关系型数据库
- **Redis** - 缓存（可选）
- **JWT** - 身份认证

## 项目结构

```
/workspace
├── docs/                    # 文档
│   ├── requirements.md      # 需求文档
│   └── development-plan.md  # 开发计划
├── server/                  # 后端服务
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/haomian/
│   │   │   │       ├── modules/    # 业务模块
│   │   │   │       ├── common/     # 通用工具
│   │   │   │       └── HaomianApplication.java
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       └── schema.sql      # 数据库脚本
│   └── pom.xml
└── app/                     # 前端应用
    ├── lib/
    │   └── main.dart
    ├── assets/              # 静态资源
    └── pubspec.yaml
```

## 快速开始

### 后端

1. 确保已安装 JDK 17+ 和 Maven
2. 创建 MySQL 数据库并执行 `server/src/main/resources/schema.sql`
3. 修改 `server/src/main/resources/application.yml` 中的数据库配置
4. 运行 `cd server && mvn spring-boot:run`

### 前端

1. 确保已安装 Flutter SDK
2. 运行 `cd app && flutter pub get`
3. 运行 `flutter run`

## 功能模块

1. **睡眠打卡** - 每日打卡，连续打卡获得奖励和等级升级
2. **助眠内容** - 助眠音乐、视频库
3. **社区交流** - 用户发帖、圈子交流，官方科普内容
4. **设备连接** - 连接手环等外设，同步睡眠数据

## 视觉风格

- 主色调：深蓝/靛蓝 (#1A1A3E)
- 点缀色：月光黄 (#F5E6A3)
- 辅助色：淡紫 (#9B8EC4)
- 整体风格：宁静、温暖、治愈，默认深色模式

## 开发计划

详细开发计划请参考 [development-plan.md](docs/development-plan.md)

## 需求文档

详细需求请参考 [requirements.md](docs/requirements.md)
