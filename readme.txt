总项目，本文件夹存放所有源代码及其相关配置等。

拾柒图书管理系统
├── assets            // 素材
├── chatbotapi1            // 拾柒助手服务端
├── ruoyi-common            // 工具类
│ └── annotation                    // 自定义注解
│       └── config                        // 全局配置
│       └── constant                      // 通用常量
│       └── core                          // 核心控制
│       └── enums                         // 通用枚举
│       └── exception                     // 通用异常
│       └── filter                        // 过滤器处理
│       └── utils                         // 通用类处理
├── ruoyi-framework         // 框架核心
│       └── aspectj                       // 注解实现
│       └── config                        // 系统配置
│       └── datasource                    // 数据权限
│       └── interceptor                   // 拦截器
│       └── manager                       // 异步处理
│       └── security                      // 权限控制
│       └── web                           // 前端控制
├── ruoyi-system      // 系统代码
├── ruoyi-admin       // 后台服务
├── shiqi-public-service  // 公共业务接口模块
├── shiqi-service  // 拾柒业务模块
├── sq-app  // H5端
|   ├── api                        // 所有请求
|   ├── components                 // 全局公用组件
|   ├── pages                      // 页面文件
|   ├── plugins                    // 通用方法
|   ├── store                      // 全局 store管理
|   ├── utils                      // 公用方法
|   ├── static                     // 公共文件
|   │   ├── favicon.ico            // favicon图标
|   │   └── index.html             // html模板
|   │   └── logo.png               // logo图片
|   ├── uni_modules                // uniui组件
|   ├── App.vue                    // 应用配置
|   ├── config.js                  // 环境配置
|   ├── main.js                    // Vue初始化入口文件
|   ├── manifest.json              // 配置打包
|   ├── pages.json                 // 配置页面路由
|   ├── permission.js              // 权限拦截
|   ├── uni.scss                   // 全局样式变量
├── sq-ui  // web端
├    ├── build                      // 构建相关
├    ├── bin                        // 执行脚本
├    ├── public                     // 公共文件
│    │   ├── favicon.ico            // favicon图标
│    │   └── index.html             // html模板
│    │   └── robots.txt             // 反爬虫
│    ├── src                        // 源代码
│    │   ├── api                    // 所有请求
│    │   ├── assets                 // 主题 字体等静态资源
│    │   ├── components             // 全局公用组件
│    │   ├── directive              // 全局指令
│    │   ├── layout                 // 布局
│    │   ├── plugins                // 通用方法
│    │   ├── router                 // 路由
│    │   ├── store                  // 全局 store管理
│    │   ├── utils                  // 全局公用方法
│    │   ├── views                  // view
│    │   ├── App.vue                // 入口页面
│    │   ├── main.js                // 入口 加载组件 初始化等
│    │   ├── permission.js          // 权限管理
│    │   └── settings.js            // 系统配置
│    ├── .editorconfig              // 编码格式
│    ├── .env.development           // 开发环境配置
│    ├── .env.production            // 生产环境配置
│    ├── .env.staging               // 测试环境配置
│    ├── .eslintignore              // 忽略语法检查
│    ├── .eslintrc.js               // eslint 配置项
│    ├── .gitignore                 // git 忽略项
│    ├── babel.config.js            // babel.config.js
│    ├── package.json               // package.json
│    └── vue.config.js              // vue.config.js
├── sql  // 项目建库语句
├── .gitignore  // git提交忽略文件
├── README.md  // 项目介绍
├── LICENSE  // 本项目开源协议
├── pom.xml  // 本项目pom依赖配置
