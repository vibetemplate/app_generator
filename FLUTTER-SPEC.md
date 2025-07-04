# Flutter移动应用配置规范

本文档定义了Flutter移动应用生成器的配置规范，用于生成跨平台移动应用（Android和iOS）。

## 配置文件结构

配置文件采用JSON格式，命名为 `flutter-config.json`。主要包含以下几个部分：

1. **app** - 应用基础信息
2. **platform** - 平台支持配置
3. **ui** - 用户界面配置
4. **stateManagement** - 状态管理方案
5. **features** - 功能特性配置
6. **database** - 数据存储配置
7. **api** - 网络和API配置
8. **build** - 构建和发布配置
9. **analytics** - 数据分析配置
10. **localization** - 国际化配置

## 完整配置示例

```json
{
  "app": {
    "name": "MyFlutterApp",
    "displayName": "我的移动应用",
    "description": "基于Flutter的跨平台移动应用",
    "version": "1.0.0",
    "bundleId": "com.example.myflutterapp",
    "author": "开发者名称",
    "homepage": "https://myapp.com",
    "keywords": ["flutter", "mobile", "cross-platform"],
    "category": "productivity"
  },
  "platform": {
    "android": {
      "enabled": true,
      "minSdkVersion": 21,
      "targetSdkVersion": 34,
      "compileSdkVersion": 34,
      "applicationId": "com.example.myflutterapp",
      "versionCode": 1,
      "supportedABIs": ["arm64-v8a", "armeabi-v7a", "x86_64"]
    },
    "ios": {
      "enabled": true,
      "deploymentTarget": "11.0",
      "bundleIdentifier": "com.example.myflutterapp",
      "teamId": "TEAM_ID",
      "supportedDevices": ["iphone", "ipad"]
    },
    "web": {
      "enabled": false,
      "renderer": "html",
      "baseHref": "/"
    },
    "desktop": {
      "enabled": false,
      "windows": false,
      "macos": false,
      "linux": false
    }
  },
  "ui": {
    "theme": "material3",
    "primaryColor": "#2196F3",
    "secondaryColor": "#03DAC6",
    "backgroundColor": "#FFFFFF",
    "surfaceColor": "#F5F5F5",
    "errorColor": "#B00020",
    "supportDarkMode": true,
    "fontFamily": "Roboto",
    "customFonts": [],
    "iconTheme": "material",
    "appBarStyle": "normal",
    "navigationStyle": "bottom",
    "responsiveLayout": true,
    "animations": {
      "enabled": true,
      "duration": 300,
      "curve": "easeInOut"
    }
  },
  "stateManagement": {
    "type": "riverpod",
    "globalState": true,
    "persistence": true,
    "devTools": true
  },
  "features": {
    "authentication": {
      "enabled": true,
      "providers": ["email", "google", "apple"],
      "biometrics": true,
      "twoFactor": false
    },
    "push": {
      "enabled": true,
      "provider": "firebase",
      "localNotifications": true,
      "badges": true
    },
    "camera": {
      "enabled": true,
      "gallery": true,
      "permissions": ["camera", "storage"]
    },
    "location": {
      "enabled": true,
      "background": false,
      "accuracy": "high",
      "permissions": ["location"]
    },
    "payment": {
      "enabled": false,
      "providers": [],
      "inAppPurchase": false
    },
    "social": {
      "enabled": false,
      "share": true,
      "deepLinks": true
    },
    "offline": {
      "enabled": true,
      "caching": true,
      "syncStrategy": "optimistic"
    },
    "biometrics": {
      "enabled": true,
      "fingerprint": true,
      "faceId": true,
      "fallbackToPin": true
    },
    "sensors": {
      "enabled": false,
      "accelerometer": false,
      "gyroscope": false,
      "magnetometer": false
    },
    "bluetooth": {
      "enabled": false,
      "lowEnergy": false,
      "permissions": ["bluetooth"]
    },
    "fileSystem": {
      "enabled": true,
      "documentPicker": true,
      "filePicker": true,
      "permissions": ["storage"]
    }
  },
  "database": {
    "local": {
      "type": "hive",
      "encryption": true,
      "backup": true
    },
    "remote": {
      "type": "firebase",
      "realtime": true,
      "offline": true,
      "caching": true
    }
  },
  "api": {
    "client": "dio",
    "baseUrl": "https://api.example.com",
    "timeout": 30000,
    "retries": 3,
    "interceptors": {
      "logging": true,
      "auth": true,
      "cache": true,
      "retry": true
    },
    "serialization": "json_annotation",
    "mockData": {
      "enabled": true,
      "environment": "development"
    }
  },
  "build": {
    "android": {
      "buildType": "release",
      "shrinkResources": true,
      "minifyEnabled": true,
      "signing": {
        "keystore": "android/app/my-release-key.keystore",
        "keyAlias": "my-key-alias"
      },
      "gradle": {
        "version": "8.0",
        "kotlinVersion": "1.8.0"
      }
    },
    "ios": {
      "configuration": "Release",
      "codeSign": {
        "identity": "iPhone Distribution",
        "provisioningProfile": "MyApp AdHoc"
      },
      "bundleShortVersionString": "1.0",
      "bundleVersion": "1",
      "exportMethod": "app-store"
    },
    "flutter": {
      "version": "3.16.0",
      "channel": "stable",
      "enabledPlatforms": ["android", "ios"]
    },
    "dependencies": {
      "cupertino_icons": "^1.0.2",
      "provider": "^6.0.5",
      "http": "^0.13.5",
      "shared_preferences": "^2.0.17",
      "sqflite": "^2.2.6"
    },
    "devDependencies": {
      "flutter_test": "sdk: flutter",
      "flutter_lints": "^3.0.0",
      "mockito": "^5.4.0"
    }
  },
  "analytics": {
    "enabled": false,
    "provider": "firebase",
    "crashlytics": true,
    "performance": true,
    "customEvents": true,
    "userProperties": true,
    "anonymizeData": true
  },
  "localization": {
    "enabled": true,
    "defaultLocale": "zh_CN",
    "supportedLocales": ["zh_CN", "en_US", "ja_JP"],
    "fallbackLocale": "en_US",
    "arb": {
      "enabled": true,
      "outputDir": "lib/l10n"
    },
    "dateFormat": {
      "enabled": true,
      "patterns": {
        "zh_CN": "yyyy年MM月dd日",
        "en_US": "MMM dd, yyyy"
      }
    }
  },
  "testing": {
    "unitTests": {
      "enabled": true,
      "coverage": true,
      "mockData": true
    },
    "widgetTests": {
      "enabled": true,
      "goldenTests": false
    },
    "integrationTests": {
      "enabled": true,
      "e2e": false
    }
  },
  "ci": {
    "enabled": false,
    "provider": "github_actions",
    "buildOnPush": true,
    "testOnPush": true,
    "deployOnTag": true
  },
  "performance": {
    "optimization": {
      "enabled": true,
      "imageCompression": true,
      "bundleSize": true,
      "lazyLoading": true
    },
    "monitoring": {
      "enabled": false,
      "fps": true,
      "memory": true,
      "network": true
    }
  }
}
```

## 配置字段说明

### app (必需)
应用基础信息配置

| 字段 | 类型 | 必需 | 默认值 | 说明 |
|------|------|------|--------|------|
| name | string | 是 | - | 应用名称（英文，用于包名） |
| displayName | string | 是 | - | 应用显示名称 |
| description | string | 是 | - | 应用描述 |
| version | string | 是 | "1.0.0" | 应用版本号 |
| bundleId | string | 是 | - | 应用包标识符 |
| author | string | 否 | - | 作者信息 |
| homepage | string | 否 | - | 应用官网 |
| keywords | array | 否 | [] | 关键词 |
| category | string | 否 | "productivity" | 应用分类 |

### platform (必需)
平台支持配置

#### android
| 字段 | 类型 | 必需 | 默认值 | 说明 |
|------|------|------|--------|------|
| enabled | boolean | 是 | true | 是否支持Android |
| minSdkVersion | number | 否 | 21 | 最低SDK版本 |
| targetSdkVersion | number | 否 | 34 | 目标SDK版本 |
| compileSdkVersion | number | 否 | 34 | 编译SDK版本 |
| applicationId | string | 是 | - | 应用ID |
| versionCode | number | 否 | 1 | 版本代码 |
| supportedABIs | array | 否 | ["arm64-v8a", "armeabi-v7a"] | 支持的架构 |

#### ios
| 字段 | 类型 | 必需 | 默认值 | 说明 |
|------|------|------|--------|------|
| enabled | boolean | 是 | true | 是否支持iOS |
| deploymentTarget | string | 否 | "11.0" | 部署目标版本 |
| bundleIdentifier | string | 是 | - | Bundle标识符 |
| teamId | string | 否 | - | 开发者团队ID |
| supportedDevices | array | 否 | ["iphone", "ipad"] | 支持的设备 |

### ui (必需)
用户界面配置

| 字段 | 类型 | 必需 | 默认值 | 可选值 | 说明 |
|------|------|------|--------|--------|------|
| theme | string | 是 | "material3" | "material3", "material2", "cupertino", "custom" | UI主题 |
| primaryColor | string | 否 | "#2196F3" | - | 主色调 |
| secondaryColor | string | 否 | "#03DAC6" | - | 辅助色 |
| supportDarkMode | boolean | 否 | true | - | 是否支持暗黑模式 |
| fontFamily | string | 否 | "Roboto" | - | 字体家族 |
| iconTheme | string | 否 | "material" | "material", "cupertino" | 图标主题 |
| navigationStyle | string | 否 | "bottom" | "bottom", "drawer", "rail" | 导航样式 |

### stateManagement (必需)
状态管理配置

| 字段 | 类型 | 必需 | 默认值 | 可选值 | 说明 |
|------|------|------|--------|--------|------|
| type | string | 是 | "riverpod" | "riverpod", "provider", "bloc", "getx", "setState" | 状态管理方案 |
| globalState | boolean | 否 | true | - | 是否使用全局状态 |
| persistence | boolean | 否 | true | - | 是否持久化状态 |
| devTools | boolean | 否 | true | - | 是否启用开发工具 |

### features (可选)
功能特性配置

#### authentication
| 字段 | 类型 | 必需 | 默认值 | 说明 |
|------|------|------|--------|------|
| enabled | boolean | 否 | false | 是否启用认证 |
| providers | array | 否 | [] | 认证提供商 |
| biometrics | boolean | 否 | false | 是否支持生物识别 |
| twoFactor | boolean | 否 | false | 是否支持双因子认证 |

#### push
| 字段 | 类型 | 必需 | 默认值 | 说明 |
|------|------|------|--------|------|
| enabled | boolean | 否 | false | 是否启用推送通知 |
| provider | string | 否 | "firebase" | 推送服务提供商 |
| localNotifications | boolean | 否 | true | 是否支持本地通知 |
| badges | boolean | 否 | true | 是否支持角标 |

### database (可选)
数据存储配置

#### local
| 字段 | 类型 | 必需 | 默认值 | 可选值 | 说明 |
|------|------|------|--------|--------|------|
| type | string | 否 | "hive" | "hive", "sqflite", "shared_preferences" | 本地数据库类型 |
| encryption | boolean | 否 | false | - | 是否加密 |
| backup | boolean | 否 | false | - | 是否备份 |

#### remote
| 字段 | 类型 | 必需 | 默认值 | 可选值 | 说明 |
|------|------|------|--------|--------|------|
| type | string | 否 | "firebase" | "firebase", "supabase", "custom" | 远程数据库类型 |
| realtime | boolean | 否 | false | - | 是否实时同步 |
| offline | boolean | 否 | true | - | 是否支持离线 |

### api (可选)
网络和API配置

| 字段 | 类型 | 必需 | 默认值 | 可选值 | 说明 |
|------|------|------|--------|--------|------|
| client | string | 否 | "dio" | "dio", "http", "chopper" | HTTP客户端 |
| baseUrl | string | 否 | - | - | API基础URL |
| timeout | number | 否 | 30000 | - | 超时时间(毫秒) |
| retries | number | 否 | 3 | - | 重试次数 |
| serialization | string | 否 | "json_annotation" | "json_annotation", "built_value" | 序列化方案 |

## 应用类型模板

### 电商购物应用
适用于商城、购物、电商类移动应用

```json
{
  "app": {
    "name": "ShopApp",
    "displayName": "购物商城",
    "category": "shopping"
  },
  "ui": {
    "theme": "material3",
    "primaryColor": "#FF6B35",
    "navigationStyle": "bottom"
  },
  "stateManagement": {
    "type": "riverpod",
    "globalState": true
  },
  "features": {
    "authentication": {
      "enabled": true,
      "providers": ["email", "google", "apple"]
    },
    "payment": {
      "enabled": true,
      "providers": ["stripe", "alipay", "wechat"],
      "inAppPurchase": false
    },
    "push": {
      "enabled": true,
      "provider": "firebase"
    }
  }
}
```

### 社交聊天应用
适用于即时通讯、社交、聊天类应用

```json
{
  "app": {
    "name": "ChatApp",
    "displayName": "即时聊天",
    "category": "social"
  },
  "ui": {
    "theme": "material3",
    "primaryColor": "#1976D2",
    "supportDarkMode": true
  },
  "stateManagement": {
    "type": "bloc",
    "globalState": true
  },
  "features": {
    "authentication": {
      "enabled": true,
      "providers": ["phone", "email"],
      "biometrics": true
    },
    "camera": {
      "enabled": true,
      "gallery": true
    },
    "location": {
      "enabled": true,
      "background": false
    },
    "push": {
      "enabled": true,
      "provider": "firebase"
    }
  },
  "database": {
    "remote": {
      "type": "firebase",
      "realtime": true
    }
  }
}
```

### 健康运动应用
适用于健康管理、运动跟踪、健身类应用

```json
{
  "app": {
    "name": "FitnessApp",
    "displayName": "健康运动",
    "category": "health"
  },
  "ui": {
    "theme": "material3",
    "primaryColor": "#4CAF50",
    "animations": {
      "enabled": true,
      "duration": 400
    }
  },
  "stateManagement": {
    "type": "provider",
    "persistence": true
  },
  "features": {
    "sensors": {
      "enabled": true,
      "accelerometer": true,
      "gyroscope": true
    },
    "location": {
      "enabled": true,
      "background": true,
      "accuracy": "high"
    },
    "biometrics": {
      "enabled": true,
      "fingerprint": true
    }
  },
  "analytics": {
    "enabled": true,
    "provider": "firebase",
    "customEvents": true
  }
}
```

## 验证规则

1. **必需字段验证**：`app.name`、`app.displayName`、`app.version`、`app.bundleId`、`platform.android.applicationId`、`platform.ios.bundleIdentifier` 必须提供
2. **类型验证**：所有字段必须符合指定的数据类型
3. **枚举验证**：枚举类型字段必须使用预定义的值
4. **依赖验证**：某些功能之间存在依赖关系，需要一起启用
5. **平台兼容性**：某些功能仅在特定平台上可用
6. **版本格式**：版本号必须符合语义化版本规范
7. **Bundle ID格式**：包标识符必须符合平台规范

## 最佳实践

1. **性能优先**：合理配置图片压缩和懒加载
2. **用户体验**：支持暗黑模式和响应式布局
3. **安全性**：启用数据加密和生物识别
4. **国际化**：支持多语言和本地化
5. **离线支持**：配置离线缓存和数据同步
6. **权限管理**：合理申请和使用系统权限
7. **状态管理**：选择适合项目规模的状态管理方案
8. **测试覆盖**：配置单元测试和集成测试
9. **CI/CD**：配置自动化构建和部署
10. **监控分析**：配置崩溃报告和性能监控

## 示例配置文件

完整的示例配置文件可在 `examples/` 目录中找到：

- `examples/ecommerce-app/flutter-config.json` - 电商购物应用配置
- `examples/chat-app/flutter-config.json` - 社交聊天应用配置
- `examples/fitness-app/flutter-config.json` - 健康运动应用配置

## 配置验证

使用 JSON Schema 验证配置文件：

```bash
# 安装验证工具
npm install -g ajv-cli

# 验证配置文件
ajv validate -s schemas/flutter-config.schema.json -d flutter-config.json
```

配置文件必须通过 Schema 验证才能用于生成 Flutter 应用。