# 📱 Flutter移动应用生成器

> AI驱动的跨平台移动应用生成工具，基于Flutter框架，让非程序员也能快速创建专业的Android和iOS应用

## 📋 复制AI提示词开始使用

```prompt
你好！我想创建一个跨平台移动应用，请帮我生成完整的Flutter项目代码。

作为Flutter专家开发者，请按照以下步骤进行：

1. **理解需求**：首先询问我的应用类型和主要功能需求

2. **配置生成**：根据我的需求，创建flutter-config.json配置文件，遵循以下规范：
   - 参考：https://github.com/vibetemplate/app_enerator/blob/main/FLUTTER-SPEC.md
   - 验证：https://github.com/vibetemplate/app_enerator/blob/main/schemas/flutter-config.schema.json

3. **代码实现**：基于配置文件生成完整的项目，包括：
   - 最新Flutter 3.x架构和Dart语言
   - 现代化Widget组件库
   - 状态管理(Provider/Riverpod/Bloc)
   - 网络请求和API集成
   - 本地数据存储(Hive/SQLite)
   - 路由导航系统
   - 主题和国际化支持
   - 打包配置(Android/iOS)

4. **参考示例**：
   - 电商购物应用：https://github.com/vibetemplate/app_enerator/tree/main/examples/ecommerce-app
   - 社交聊天应用：https://github.com/vibetemplate/app_enerator/tree/main/examples/chat-app
   - 健康运动应用：https://github.com/vibetemplate/app_enerator/tree/main/examples/fitness-app

5. **组件模板**：使用预设组件加速开发：
   - https://github.com/vibetemplate/app_enerator/tree/main/templates

请开始询问我的具体需求吧！
```

## 🚀 快速开始

### 方式一：AI工具生成（推荐）

1. 复制上面的提示词
2. 粘贴到AI工具（Cursor、Claude Code、ChatGPT等）
3. 描述你的移动应用需求
4. 获得完整的Flutter项目代码

### 方式二：手动配置

1. 克隆项目
```bash
git clone https://github.com/vibetemplate/app_enerator.git
cd app_enerator
```

2. 查看配置规范
```bash
# 阅读配置文档
cat FLUTTER-SPEC.md

# 查看示例配置
ls examples/
```

3. 创建配置文件
```bash
# 复制示例配置
cp examples/ecommerce-app/flutter-config.json my-app-config.json

# 编辑配置
vim my-app-config.json
```

## 📁 项目结构

```
app_enerator/
├── README.md                  # 本文档
├── FLUTTER-SPEC.md           # 配置规范文档
├── schemas/                  # JSON Schema验证
│   └── flutter-config.schema.json
├── examples/                 # 示例应用
│   ├── ecommerce-app/        # 电商购物应用
│   ├── chat-app/             # 社交聊天应用
│   └── fitness-app/          # 健康运动应用
├── templates/                # 组件模板
│   ├── widgets/              # UI组件
│   ├── screens/              # 页面模板
│   └── services/             # 服务模板
└── docs/                     # 文档
    ├── 快速开始.md
    ├── 配置指南.md
    └── 最佳实践.md
```

## 🎯 支持的应用类型

- **🛒 电商购物** - 商城应用、购物车、支付集成、商品管理
- **💬 社交聊天** - 即时通讯、群聊、语音视频、朋友圈
- **🏃 健康运动** - 运动跟踪、健康数据、目标设定、社区分享
- **📚 教育学习** - 在线课程、题库练习、学习进度、证书管理
- **💰 金融理财** - 记账应用、投资管理、数据分析、理财规划
- **🎵 音视频** - 音乐播放器、视频播放器、直播应用
- **📰 新闻资讯** - 新闻阅读、内容推荐、评论互动
- **🍔 餐饮外卖** - 点餐系统、配送跟踪、评价系统
- **🚗 出行交通** - 地图导航、打车服务、交通查询
- **🏥 医疗健康** - 预约挂号、健康记录、用药提醒

## 🛠️ 技术特性

### 现代化Flutter架构
- **Flutter 3.x** - 最新版本，性能优化
- **Dart 3.x** - 现代化编程语言，空安全
- **Material Design 3** - 最新设计规范
- **Cupertino iOS风格** - 原生iOS体验

### 跨平台支持
- **Android** - 支持Android 5.0+，适配各种屏幕
- **iOS** - 支持iOS 11+，完美适配iPhone和iPad
- **Web** - 可选的Web端支持
- **Desktop** - 可选的桌面端支持

### 状态管理
- **Provider** - 简单易用的状态管理
- **Riverpod** - 新一代Provider，类型安全
- **Bloc** - 企业级状态管理，事件驱动
- **GetX** - 轻量级全能解决方案

### 数据存储
- **Hive** - 高性能NoSQL数据库
- **SQLite** - 关系型数据库，SQL支持
- **SharedPreferences** - 简单键值存储
- **Firebase** - 云数据库和实时同步

### 网络和API
- **Dio** - 强大的HTTP客户端
- **Retrofit** - 类型安全的API客户端
- **GraphQL** - 现代化API查询语言
- **WebSocket** - 实时通信支持

### 原生功能
- **相机和相册** - 图片视频拍摄和选择
- **地理位置** - GPS定位和地图集成
- **推送通知** - 本地和远程消息推送
- **生物识别** - 指纹和面部识别
- **传感器** - 陀螺仪、加速度计等
- **蓝牙和NFC** - 设备连接和数据传输

## 📊 配置示例

### 基础电商应用配置
```json
{
  "app": {
    "name": "ShopApp",
    "displayName": "购物商城",
    "version": "1.0.0",
    "description": "现代化电商购物应用"
  },
  "platform": {
    "android": true,
    "ios": true,
    "web": false
  },
  "ui": {
    "theme": "material3",
    "primaryColor": "#2196F3",
    "supportDarkMode": true
  },
  "stateManagement": "riverpod",
  "features": {
    "auth": true,
    "payment": true,
    "push": true,
    "analytics": true
  }
}
```

## 🎨 组件库

### UI组件
- **AppBar** - 自定义应用栏
- **BottomNavBar** - 底部导航栏
- **CustomButton** - 多样式按钮
- **ProductCard** - 商品卡片
- **UserAvatar** - 用户头像
- **LoadingWidget** - 加载指示器
- **EmptyState** - 空状态页面
- **ErrorWidget** - 错误状态组件

### 页面模板
- **LoginScreen** - 登录页面
- **RegisterScreen** - 注册页面
- **ProfileScreen** - 个人资料页
- **ProductListScreen** - 商品列表页
- **ProductDetailScreen** - 商品详情页
- **ShoppingCartScreen** - 购物车页面
- **ChatScreen** - 聊天页面
- **SettingsScreen** - 设置页面

### 服务模板
- **AuthService** - 认证服务
- **ApiService** - API服务
- **StorageService** - 存储服务
- **NotificationService** - 通知服务
- **LocationService** - 定位服务
- **CameraService** - 相机服务

## 📚 文档链接

- [配置规范文档](FLUTTER-SPEC.md)
- [快速开始指南](docs/快速开始.md)
- [配置完整指南](docs/配置指南.md)
- [开发最佳实践](docs/最佳实践.md)
- [组件使用文档](templates/README.md)

## 🔧 开发工具

### 验证配置
```bash
npm install -g ajv-cli
ajv validate -s schemas/flutter-config.schema.json -d your-config.json
```

### 本地开发
```bash
# 创建Flutter项目
flutter create my_app
cd my_app

# 安装依赖
flutter pub get

# 运行开发服务器
flutter run

# 构建应用
flutter build apk
flutter build ios
```

## 📖 示例应用

### 1. 电商购物应用
完整的电商应用，支持商品浏览、购物车、订单管理、支付集成。

**特性：**
- 商品分类浏览
- 搜索和筛选
- 购物车管理
- 用户认证
- 订单跟踪
- 支付集成
- 评价系统

### 2. 社交聊天应用
现代化即时通讯应用，支持单聊、群聊、语音视频通话。

**特性：**
- 实时消息
- 群组聊天
- 语音视频通话
- 文件传输
- 朋友圈动态
- 用户状态
- 消息加密

### 3. 健康运动应用
专业的健康管理应用，支持运动跟踪、健康数据分析。

**特性：**
- 运动记录
- 健康数据图表
- 目标设定
- 社区分享
- 成就系统
- 健康提醒
- 数据同步

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

## 📄 许可证

MIT License - 查看 [LICENSE](LICENSE) 文件了解详情

## 🔗 相关项目

- [AI网站生成器](https://github.com/vibetemplate/ai-web-generator) - AI驱动的网站生成工具
- [小程序生成器](https://github.com/vibetemplate/miniprogram-generator) - uni-app跨平台小程序生成器
- [桌面应用生成器](https://github.com/vibetemplate/desktop-generator) - Electron桌面应用生成工具

---

**让AI帮你快速构建专业移动应用！** 🚀