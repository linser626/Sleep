# 好眠 — 健康睡眠助手 开发计划

> 版本：v1.0 | 日期：2026-05-18 | 开发阶段：MVP v1.0

---

## 一、技术选型

### 1.1 技术栈决策

| 层级 | 技术方案 | 选型理由 |
|------|---------|---------|
| **前端框架** | React Native (Expo) | 跨平台开发，一套代码同时支持 iOS 和 Android，生态成熟 |
| **UI 组件库** | React Native Paper + 自定义组件 | 基础组件完善，便于打造定制化视觉风格 |
| **状态管理** | Redux Toolkit + RTK Query | 统一状态管理，内置数据缓存和异步请求处理 |
| **路由管理** | React Navigation | 标准路由方案，支持 Tab、Stack 等多种导航模式 |
| **后端服务** | NestJS (Node.js) | TypeScript 全栈统一，模块清晰，易维护 |
| **数据库** | PostgreSQL | 关系型数据库，适合复杂数据模型 |
| **缓存** | Redis | 会话、打卡数据热点缓存 |
| **对象存储** | 阿里云 OSS / AWS S3 | 音视频、图片文件存储 |
| **消息推送** | Firebase Cloud Messaging + 极光推送 | 覆盖 iOS 和 Android 推送 |
| **蓝牙通信** | react-native-ble-plx | 稳定的 BLE 蓝牙库，支持多品牌设备 |

### 1.2 目录结构

```
/workspace
├── docs/                    # 文档
│   ├── requirements.md      # 需求文档
│   └── development-plan.md  # 本文档
├── server/                  # 后端服务
│   ├── src/
│   │   ├── modules/         # 业务模块
│   │   ├── common/          # 通用工具
│   │   └── main.ts          # 入口
│   └── package.json
└── app/                     # 前端 APP
    ├── src/
    │   ├── screens/         # 页面
    │   ├── components/      # 组件
    │   ├── store/           # 状态管理
    │   ├── services/        # API 服务
    │   ├── utils/           # 工具
    │   └── App.tsx          # 入口
    └── package.json
```

---

## 二、开发阶段划分（MVP v1.0）

### 阶段一：项目初始化与基础架构（1-2天）

**目标：** 搭建前后端项目骨架，配置开发环境

| 任务 | 交付物 |
|------|--------|
| 初始化后端 NestJS 项目 | server/ 目录完整结构 |
| 初始化前端 Expo 项目 | app/ 目录完整结构 |
| 配置数据库（PostgreSQL） + ORM（Prisma） | 数据库连接，基础实体模型 |
| 配置 Redux + RTK Query + React Navigation | 前端基础架构就绪 |
| 配置统一代码规范（ESLint + Prettier） | .eslintrc, .prettierrc |

---

### 阶段二：用户认证与个人中心（2-3天）

**目标：** 完成登录注册、个人信息管理、等级展示

| 子任务 | 后端 | 前端 |
|--------|------|------|
| 用户注册/登录（手机号+验证码） | AuthModule, UserModule | 登录页、注册页 |
| 个人信息编辑 | UserController | 个人信息页 |
| 等级体系基础（Level 实体） | LevelModule | 等级展示组件 |
| 我的页面布局 | - | "我的" Tab 页面 |

---

### 阶段三：睡眠打卡与激励体系（3-4天）

**目标：** 核心功能 — 打卡、连续天数、奖励、睡眠报告

| 子任务 | 后端 | 前端 |
|--------|------|------|
| 睡眠打卡接口（开始/结束） | CheckInModule | 首页打卡按钮、打卡流程页 |
| 打卡日历数据 | CheckInController | 打卡日历组件 |
| 连续打卡计算 + 经验值/星月币发放 | CheckInService | 连续天数展示、奖励弹窗 |
| 日睡眠报告生成 | ReportService | 日报告页 |
| 我的收藏夹 | CollectionModule | 收藏夹页 |

---

### 阶段四：助眠内容库（3-4天）

**目标：** 音乐/视频分类、播放、收藏

| 子任务 | 后端 | 前端 |
|--------|------|------|
| 助眠音乐 CRUD 接口 | MusicModule | 音乐列表页、音乐详情页 |
| 助眠视频 CRUD 接口 | VideoModule | 视频列表页、视频详情页 |
| 分类/标签体系 | ContentTagModule | 分类筛选组件 |
| 音频播放器（含定时关闭） | - | 播放器组件（react-native-track-player） |
| 视频播放器 | - | 视频播放页（expo-video-player） |
| 收藏接口 | CollectionController | 收藏按钮/状态 |

---

### 阶段五：社区与官方号（3-4天）

**目标：** 发帖、浏览、官方号内容

| 子任务 | 后端 | 前端 |
|--------|------|------|
| 帖子发布/查询接口 | PostModule | 发帖页、社区首页信息流 |
| 点赞/评论/收藏 | InteractionModule | 帖子详情页、评论区 |
| 话题标签体系 | TagModule | 标签选择、标签筛选 |
| 官方号内容发布 | OfficialAccountModule | 官方号主页 |
| 内容审核（敏感词过滤） | ContentModerationService | - |

---

### 阶段六：外设连接与数据同步（4-5天）

**目标：** 蓝牙搜索、连接、同步睡眠数据

| 子任务 | 后端 | 前端 |
|--------|------|------|
| 设备管理接口（绑定/解绑/状态） | DeviceModule | 设备管理页 |
| 睡眠数据同步接口 | SleepDataModule | 蓝牙搜索、连接组件 |
| 小米手环数据解析 | DeviceDataParser (Xiaomi) | 设备数据同步逻辑 |
| 华为手环数据解析 | DeviceDataParser (Huawei) | 设备监测报告页 |
| 数据融合与展示 | SleepDataService | 睡眠曲线、睡眠阶段展示 |

---

### 阶段七：视觉设计与动效（2-3天）

**目标：** 打造适合睡眠的视觉风格

| 任务 | 交付物 |
|------|--------|
| 主题色配置 | 全局主题文件，组件适配主题 |
| 自定义图标与插画 | Icon 组件，插画资源 |
| 页面交互动效 | 路由切换、按钮点击、打卡成功动效 |
| 深色模式适配 | 主题切换逻辑 |

---

### 阶段八：测试与优化（2-3天）

**目标：** 功能测试、性能优化、Bug 修复

| 任务 | 内容 |
|------|------|
| 核心功能测试 | 打卡、播放、发帖、蓝牙连接等流程测试 |
| 性能测试 | 启动速度、内存占用、音视频卡顿测试 |
| Bug 修复 | 根据测试结果修复问题 |
| 代码优化 | 重构、消除重复代码、优化性能 |

---

## 三、详细任务分解（后端）

### Server 模块清单

```
server/src/modules/
├── auth/              # 用户认证
├── user/              # 用户管理
├── checkin/           # 睡眠打卡
├── level/             # 等级体系
├── badge/             # 徽章奖励
├── music/             # 助眠音乐
├── video/             # 助眠视频
├── content-tag/       # 内容标签
├── post/              # 社区帖子
├── circle/            # 圈子
├── official-account/  # 官方号
├── interaction/       # 互动（点赞/评论/收藏）
├── device/            # 设备管理
└── sleep-data/        # 睡眠数据
```

### 后端开发任务

| 优先级 | 模块 | 任务详情 |
|--------|------|---------|
| P0 | auth | 实现手机号+验证码登录/注册；JWT 令牌发放与验证 |
| P0 | user | 用户 CRUD；用户信息查询/更新 |
| P0 | checkin | 开始打卡接口；结束打卡接口；查询打卡记录；计算连续天数 |
| P0 | level | 等级配置；经验值计算；等级升级判断 |
| P0 | music | 音乐列表分页查询；音乐详情查询；播放数统计 |
| P0 | video | 视频列表分页查询；视频详情查询；播放数统计 |
| P0 | post | 帖子发布；帖子列表查询；帖子详情查询 |
| P0 | interaction | 点赞/取消点赞；评论发布/查询；收藏/取消收藏 |
| P1 | badge | 徽章配置；获得徽章判断；用户徽章查询 |
| P1 | content-tag | 标签 CRUD；内容标签关联 |
| P1 | official-account | 官方号内容发布；置顶管理 |
| P1 | device | 设备绑定/解绑；设备信息存储；最后同步时间 |
| P1 | sleep-data | 睡眠数据存储；数据融合逻辑；睡眠评分 |

---

## 四、详细任务分解（前端）

### App 页面清单

```
app/src/screens/
├── AuthStack/
│   ├── LoginScreen.tsx
│   └── RegisterScreen.tsx
├── MainTab/
│   ├── HomeScreen.tsx          # 首页（打卡入口）
│   ├── SleepContentScreen.tsx  # 助眠页
│   ├── CommunityScreen.tsx     # 社区页
│   └── ProfileScreen.tsx       # 我的页
└── SubScreens/
    ├── CheckInFlowScreen.tsx
    ├── CalendarScreen.tsx
    ├── DailyReportScreen.tsx
    ├── MusicPlayerScreen.tsx
    ├── VideoPlayerScreen.tsx
    ├── PostDetailScreen.tsx
    ├── CreatePostScreen.tsx
    ├── DeviceManageScreen.tsx
    └── SleepDataMonitorScreen.tsx
```

### 前端开发任务

| 优先级 | 模块 | 任务详情 |
|--------|------|---------|
| P0 | 导航 | 搭建 AuthStack 和 MainTab 路由结构 |
| P0 | 登录/注册 | 手机号输入；验证码获取与输入；登录逻辑 |
| P0 | 首页 | 今日概览展示；"我要睡觉"/"我醒了"打卡按钮 |
| P0 | 打卡流程 | 入睡时间记录；起床时间记录；睡眠时长计算展示 |
| P0 | 打卡日历 | 月历视图；已打卡日期标记 |
| P0 | 日报告 | 展示入睡/起床时间、睡眠时长、评分 |
| P0 | 助眠页 | 音乐/视频 Tab 切换；分类列表 |
| P0 | 音乐播放器 | 播放/暂停；进度条；定时关闭；音量调节 |
| P0 | 视频播放器 | 视频播放；全屏切换；定时关闭 |
| P0 | 社区页 | 帖子信息流；下拉刷新；上拉加载 |
| P0 | 发帖页 | 文字输入；图片选择/上传；标签选择 |
| P0 | 帖子详情 | 内容展示；点赞/评论/收藏；评论区 |
| P0 | 我的页 | 用户信息展示；菜单入口 |
| P1 | 连续打卡展示 | 当前连续天数；历史最高连续天数 |
| P1 | 等级展示 | 当前等级；经验值进度条；下一级所需经验 |
| P1 | 设备管理 | 蓝牙搜索；设备配对；连接状态显示 |
| P1 | 睡眠监测 | 睡眠曲线展示；各睡眠阶段占比 |
| P1 | 主题 | 全局主题配置；深色模式切换 |

---

## 五、关键技术实现要点

### 5.1 蓝牙设备连接（前端）

```typescript
// react-native-ble-plx 使用示例
import { BleManager } from 'react-native-ble-plx';

const bleManager = new BleManager();

// 1. 搜索设备
bleManager.startDeviceScan(null, null, (error, device) => {
  if (error) return;
  if (device.name?.includes('Mi Band') || device.name?.includes('Huawei')) {
    // 发现目标设备
  }
});

// 2. 连接设备
device.connect().then(device => {
  return device.discoverAllServicesAndCharacteristics();
}).then(device => {
  // 读写特征值获取睡眠数据
});
```

### 5.2 音频播放器（前端）

```typescript
// react-native-track-player 配置
import TrackPlayer, { Capability } from 'react-native-track-player';

await TrackPlayer.setupPlayer();
await TrackPlayer.updateOptions({
  capabilities: [
    Capability.Play,
    Capability.Pause,
    Capability.Stop,
    Capability.JumpForward,
    Capability.JumpBackward,
  ],
  compactCapabilities: [Capability.Play, Capability.Pause],
});
```

### 5.3 连续打卡逻辑（后端）

```typescript
// CheckInService 中的连续天数计算
async calculateStreak(userId: string): Promise<number> {
  const checkins = await this.checkinRepository.find({
    where: { userId },
    order: { sleepTime: 'DESC' },
  });

  let streak = 0;
  let expectedDate = new Date();

  for (const checkin of checkins) {
    const checkinDate = new Date(checkin.sleepTime);
    const diffDays = this.dateDiff(expectedDate, checkinDate);

    if (diffDays === 0 || diffDays === 1) {
      streak++;
      expectedDate = new Date(checkinDate);
      expectedDate.setDate(expectedDate.getDate() - 1);
    } else {
      break;
    }
  }

  return streak;
}
```

---

## 六、里程碑与时间线

| 里程碑 | 预计时间 | 验收标准 |
|--------|---------|---------|
| M1: 项目启动 | Day 1 | 前后端项目初始化完成，可独立运行 |
| M2: 登录与个人中心 | Day 3 | 用户可注册登录，个人信息页可正常展示 |
| M3: 打卡与激励 | Day 7 | 用户可完成完整打卡流程，获得经验和奖励 |
| M4: 助眠内容库 | Day 11 | 用户可浏览、播放音乐和视频 |
| M5: 社区功能 | Day 15 | 用户可发帖、点赞、评论，官方号内容可见 |
| M6: 外设连接 | Day 20 | 可连接小米/华为手环并同步数据 |
| M7: 视觉设计 | Day 23 | 整体风格统一，符合睡眠场景 |
| M8: 测试与发布 | Day 25 | 核心流程稳定，准备内测 |

---

## 七、风险与应对

| 风险 | 影响 | 概率 | 应对措施 |
|------|------|------|---------|
| 手环协议不公开，数据解析困难 | 高 | 中 | 优先对接公开协议的设备；预留扩展接口 |
| 跨平台音频播放兼容性问题 | 中 | 低 | 使用成熟的 react-native-track-player |
| 社区初期内容不足 | 中 | 高 | 运营提前准备种子内容；官方号定期更新 |
| 开发进度延期 | 高 | 中 | 优先保证 MVP 核心功能，非必要功能延期 |

---

## 八、后续规划

v1.0 完成后，按需求文档中 v1.5/v2.0 版本规划迭代：
- v1.5: 圈子功能、混音播放、周/月报告
- v2.0: 智能推荐、更多设备支持
- v2.5: AI 顾问、VIP 体系
