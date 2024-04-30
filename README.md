# 智能图书馆开源文档

>[Gitee 主页](https://gitee.com/falle22222n-leaves)

前台：http://localhost:8081/#/login
后台：http://localhost:8081/#/loginadmin

Language：**[English](README_en.md)**| **[中文](README.md).**

## ☀️项目介绍

**AI 智能图书馆**（AI Intelligent Library）是一个利用 AI 模型和数据分析对用户所喜欢的图书进行精准推荐的系统，并且提供了 AIGC 的在线生成借阅量分析的 BI 图表功能，能够起到一个数据分析师的作用。其主要有三大使用者：用户（借阅人）、图书管理员、系统管理员。

> Ps：如果你想要简易和新颖，那么这个项目将会是不错的选择~

![](https://pic.yupi.icu/5563/202403041924533.png)

![](https://pic.yupi.icu/5563/202403041924237.png)

## ☀️功能和特性

### 用户功能

1）图书查询功能：分页构造器缓解数据过大压力，后端可设置请求数防止爬虫请求数过大，服务器负载过大。模糊查询进行字段搜索。表格均**可导出 PDF 和 EXCEL**。

2）读者规则功能：查询现有的借阅规则，借阅规则包括：借阅编号，可借阅图书数量，可借阅天数，可借阅图书馆，过期扣费/天。

3）查看公告: 可以查询图书管理员发布的公告列表，**文字滑动效果**。

4）个人信息: 可以查看个人的借阅证编号，借阅证姓名，规则编号，状态，可以修改个人账户的密码。

5）借阅信息: 可以查看自身借阅过的图书记录和归还情况。

6）违章信息: 可以查询自身归还的图书是否有违章信息。

7）读者留言: 实现留言功能并以**弹幕形式**显示。

8）**智能推荐**用户输入自己的偏好，AI 根据数据库书籍列表和用户偏好，给用户推荐书籍。

### 图书管理员功能

1）借阅图书: 图书管理员输入借阅证号(用户)和要借的图书编号和当前的时间，点击借阅。

2）归还图书: 输入图书编号查看图书是否逾期，并且可以设置违规信息，然后选择是否归还图书。

3）借书报表: 用于查询已经借阅并归还的书籍列表，同样使用分页构造器和模糊查询字段，显示借阅证编号，图书编号，借阅日期，截止日期，归还日期，违章信息，处理人。

4）还书报表: 用于查询已经借阅但是还未归还的书籍列表，显示借阅证编号，图书编号，借阅日期，截止日期。

5）发布公告: 可以查询当前发布的公告列表，并进行删除，修改，增加功能，分页构造器用于缓解数据量大的情况。

### 系统管理员功能

1）书籍管理: 可以查询当前的所有图书，显示图书编号，图书昵称，作者，图书馆，分类，位置，状态，描述。可以进行添加，修改，删除图书。利用分页构造器实现批量查询。利用模糊查询实现图书搜索功能。**利用插件实现 PDF 和 EXCEL 导出**。

2）书籍类型: 显示查询当前的所有图书类型，可以进行添加，修改，删除图书类型，利用分页构造器实现批量查询，缓解数据压力。

3）借阅证管理: 可以查询当前的所有借阅证列表，也就是用户数量，可以进行添加，修改，删除操作。同样实现分页。

4）借阅信息查询: 可以查询当前已经完成借阅和归还的记录，显示借阅证号，书籍编号，借阅日期，截止日期，归还日期，违章信息，处理人。分页功能，PDF 和 EXCEL 导出。

5）借阅规则管理: 可以查询当前所有的借阅规则，显示限制借阅天数，限制本数，限制图书馆，逾期费用，可以进行添加、删除、修改操作。

6）图书管理员管理: 显示当前的图书管理员列表，显示账号，姓名，邮箱，可以进行添加、删除、修改操作。

7）系统管理: 可以查询一个月内的借阅量，以一周为时间间隔，计算借阅量，**用 Echarts 实现各种图表的展示**。

8）系统分析：可以上传某个时间段的借阅量和日期，并且输入分析目标和想要生成的图表类型，等待一段时间后，**AI 将会给出分析结论和可视化图表**。

### 特性（亮点）

1）本项目采用前后端分离的模式，前端构建页面，后端作数据接口，前端调用后端数据接口得到数据，重新渲染页面。

2）前端在 Authorization 字段提供 Token 令牌，API 认证使用 Token 认证，使用 HTTP Status Code 表示状态，数据返回格式使用 JSON。

3）后端已开启 CORS 跨域支持，采用权限拦截器进行权限校验，并检查登录情况。

4）添加全局异常处理机制，捕获异常，增强系统健壮性。

5）前端用 Echarts 可视化库实现了图书借阅的分析图标（折线图、饼图），并通过 Loading 配置提高加载体验。

6）留言组件采用弹幕形式，贴合用户的喜好。

7）引入 knife4j 依赖，使用 Swagger + Knife4j 自动生成 OpenAPI 规范的接口文档，前端可以在此基础上使用插件自动生成接口请求代码，降低前后端协作成本

8）使用 ElementUI 组件库进行前端界面搭建，快速实现页面生成，并实现了前后端统一权限管理，多环境切换等能力。

9）基于 MyBatis Plus 框架的 QueryWrapper 实现对 MySQL 数据库的灵活查询，并配合 MyBatisX 插件自动生成后端 CRUD 基础代码，减少重复工作。

10）前端路由懒加载、CDN 静态资源缓存优化、图片懒加载效果。

## ☀️运行方式

### 2 分钟快速上手使用项目

1）找到 SpringBoot 启动类，点击运行

![](https://pic.yupi.icu/5563/202403041925113.png)

2）打开 Knife4J 注册用户，或者可以直接找我拿数据库模拟数据（简易）。

![](https://pic.yupi.icu/5563/202403041925196.png)

![](https://pic.yupi.icu/5563/202403041925244.png)

3）前端输入表单内容后点击登录即可成功，开始愉快使用功能~

![](https://pic.yupi.icu/5563/202403041925792.png)

![](https://pic.yupi.icu/5563/202403041925648.png)

## ☀️部署方式

### 前置条件

**前端**

软件：Vscode 或者 Webstorm（推荐）

环境：Node 版本 16 或者 18（推荐） **注：千万别选 18 以上的版本！**

**后端**

软件：Eclipse 或者 IDEA（推荐）

环境：MySQL 5.7 或者 8.0（推荐）Redis（可选）

### 前端部署

1）点击克隆/下载项目，会使用 Git 进行版本控制的，推荐 Git Clone，不会的小伙伴可以选择下载一个 Zip 压缩包，然后解压到自己电脑的 D 盘，推荐直接 Star，后续直接向我拿数据库模拟文件和 API 接口文档。

![](https://pic.yupi.icu/5563/202403041926975.png)

2）利用 Vscode 或者 Webstorm 打开前端页面，配置 Configuration。配置 Node 环境和包管理工具即可，我这边选择的包管理工具是 Npm，其他包管理工具如：Yarn、Cnpm、Pnpm 皆可。 **注：注意更改 Npm 的镜像地址为淘宝的新镜像地址，否则会出现 Npm Install 一直卡进度条的情况。**

3）直接点击 dev 的运行，或者打开控制台，输入 npm run serve 即可成功启动前端项目。

```shell
npm config set registry https://registry.npmmirror.com/
```

![](https://pic.yupi.icu/5563/202403041926892.png)

![](https://pic.yupi.icu/5563/202403041926931.png)

![](https://pic.yupi.icu/5563/202403041926639.png)

4）将图片链接进行自定义切换，可以切换为你自己的图床的图片链接，比如七牛云、GitHub 等，也可以寻找在线图片，复制百度文库图片链接（多试几次，有些图片有防盗链）。**更换背景后，可以看到右下角的权限切换小图标。**

![](https://pic.yupi.icu/5563/202403041926849.png)

![](https://pic.yupi.icu/5563/202403041926100.png)



### 后端部署

1）点击克隆/下载项目，会使用 Git 进行版本控制的，推荐 Git Clone，不会的小伙伴可以选择下载一个 Zip 压缩包，然后解压到自己电脑的 D 盘，推荐直接 Star，后续直接向我拿数据库模拟文件和 API 接口文档。

![](https://pic.yupi.icu/5563/202403041926093.png)

2）领取数据库模拟文件后，利用 Navicat 或者 SQLYog 等软件导入数据库文件，记得先建立一个名为 bms_boot 的数据库，然后右键点击运行 SQL 文件即可，运行成功，无报错后，重新打开数据库，检查是否有数据，如果有数据，表明导入成功。

![](https://pic.yupi.icu/5563/202403041926256.png)

![](https://pic.yupi.icu/5563/202403041926292.png)

3）用 IDEA 打开后端项目，找到 application-dev.yml 文件，修改其中的 MySQL 配置，保证用户名和密码正确，注：密码不能以数字 0 开头。

![](https://pic.yupi.icu/5563/202403041926672.png)

4）导入 Maven 依赖，注意看自己的 Maven 版本是否正确，建议选择跟我一样的，3.8以上的版本，发现依赖导入很慢，是因为没有配置国内镜像，默认连接的是国外服务器，因此阿里云镜像配置可以看这篇博客。[CSDN Maven 配置教程](https://blog.csdn.net/lianghecai52171314/article/details/102625184?ops_request_misc=&request_id=&biz_id=102&utm_term=Maven)

![](https://pic.yupi.icu/5563/202403041926747.png)

5）找到 SpringBoot 启动类，我建议用 Debug 模式启动项目，更好排查错误。

![](https://pic.yupi.icu/5563/202403041926037.png)

6）如果遇到错误，大概率可能是 JDK 版本问题，我项目用的是 JDK 8，建议选择与我相同版本。

![](https://pic.yupi.icu/5563/202403041926752.png)

![](https://pic.yupi.icu/5563/202403041926887.png)

7）成功启动项目效果展示如下

![](https://pic.yupi.icu/5563/202403041926993.png)

### 前后端联调

1）如果需要修改端口和前缀（比如/api），需要同时修改前端和后端。

![](https://pic.yupi.icu/5563/202403041926975.png)

![](https://pic.yupi.icu/5563/202403041926787.png)

## ☀️技术选型

### 前端

| **技术**                     | **作用**                                                     | **版本**                                             |
| ---------------------------- | ------------------------------------------------------------ | ---------------------------------------------------- |
| Vue                          | 提供前端交互                                                 | 2.6.14                                               |
| Vue-Router                   | 路由式编程导航                                               | 3.5.1                                                |
| Element-UI                   | 模块组件库，绘制界面                                         | 2.4.5                                                |
| Axios                        | 发送ajax请求给后端请求数据                                   | 1.2.1                                                |
| core-js                      | 兼容性更强，浏览器适配                                       | 3.8.3                                                |
| swiper                       | 轮播图插件（快速实现)                                        | 3.4.2                                                |
| vue-baberrage                | vue弹幕插件(实现留言功能)                                    | 3.2.4                                                |
| vue-json-excel               | 表格导出Excel                                                | 0.3.0                                                |
| html2canvas+jspdf            | 表格导出PDF                                                  | 1.4.1 2.5.1                                          |
| node-polyfill-webpack-plugin | webpack5中移除了nodejs核心模块的polyfill自动引入             | 2.0.1                                                |
| default-passive-events       | **Chrome** 增加了新的事件捕获机制 **Passive Event Listeners**（被动事件侦听器) | 让页面滑动更加流畅，主要用于提升移动端滑动行为的性能 |
| nprogress                    | 发送请求显示进度条(人机交互友好)                             | 0.2.0                                                |
| echarts                      | 数据转图标的好工具(功能强大)                                 | 5.4.1                                                |
| less lessloader              | 方便样式开发                                                 | 4.1.3 11.1.0                                         |

### 后端

| **技术及版本**                       | **作用**                                                     | **版本**                          |
| ------------------------------------ | ------------------------------------------------------------ | --------------------------------- |
| SpringBoot                           | 应用开发框架                                                 | 2.7.8                             |
| JDK                                  | Java 开发包                                                  | 1.8                               |
| MySQL                                | 提供后端数据库                                               | 8.0.23                            |
| MyBatisPlus                          | 提供连接数据库和快捷的增删改查                               | 3.5.1                             |
| SpringBoot-Configuration-processor   | 配置处理器 定义的类和配置文件绑定一般没有提示，因此可以添加配置处理器，产生相对应的提示. |                                   |
| SpringBoot-Starter-Web               | 后端集成Tomcat MVC                                           | 用于和前端连接                    |
| SpringBoot-starter-test              | Junit4单元测试前端在调用接口前，后端先调用单元测试进行增删改查，注意Junit4和5的问题，注解@RunWith是否添加 |                                   |
| Lombok                               | 实体类方法的快速生成 简化代码                                |                                   |
| mybatis-plus-generator               | 代码生成器                                                   | 3.5.1                             |
| MyBatisX                             | MyBatisPlus插件直接生成mapper,实体类,service                 |                                   |
| jjwt                                 | token工具包                                                  | 0.9.0                             |
| fastjson                             | 阿里巴巴的 JSON 工具类                                       | 1.2.83                            |
| hutool                               | hutool工具包(简化开发工具类)                                 | [文档](https://hutool.cn/docs/#/) |
| knife4j-openapi2-spring-boot-starter | Knife4j 在线接口文档测试工具                                 | 4.0.0                             |
| gson                                 | 谷歌的 JSON 工具类                                           | 2.8.5                             |
| Java-WebSocket                       | 讯飞星火 AI 配置                                             | 1.3.8                             |
| okhttp                               | 讯飞星火 AI 配置                                             | 4.10.0                            |
| okio                                 | 讯飞星火 AI 配置                                             | 2.10.0                            |
| jsoup                                | 简易爬虫工具                                                 | 1.15.3                            |
| guava                                | 谷歌工具类                                                   | 30.1-jre                          |
| spring-boot-starter-data-redis       | Redis 的 Starter                                             |                                   |
| broadscope-bailian-sdk-java          | 阿里云 AI 模型                                               | 1.1.7                             |
| spring-boot-starter-websocket        | WebSocket 的 Starter                                         |                                   |

## ☀️架构

![](https://pic.yupi.icu/5563/202403061541028.png)

## ☀️核心设计

### 智能推荐功能

1）用户输入自己的图书偏爱信息。

2）前端发送 Axios 请求。

3）后端先判断文本是否违法（为空或者文本字数过长）。

4）查看接口是否存在。

5）查看 AI 接口调用次数是否充足。

6）GuavaRateLimiter 进行单体限流，判断请求次数是否超出正常业务频次。

7）给 AI 模型人工预设，并且查询数据库中的书籍列表进行拼接。

8）查询 AI 模型与该用户最近的五条历史记录，用于上下文关联。

9）FutureTask 同步调用获取 AI 结果，并设置超时时间（超时抛出异常）

10）获取 AI 模型推荐信息后进行持久化，并且减少接口调用次数（判断是否成功）

11）返回处理好的 AI 推荐信息给前端，并设置响应状态码为 200 即可。

### 智能分析功能

1）用户输入分析目标、图标名称、选择图标类型、上传 Excel 文件，点击提交，发送 Axios 请求至后端。

2）校验文件是否为空、名称是否过长、文件大小检验、文件后缀校验

3）获取管理员 ID，从接口信息表查询管理员 ID 拥有的接口，接口判空。

4）判断 AI 接口调用次数是否足够

5）GuavaRateLimiter 进行单体限流，判断请求次数是否超出正常业务频次。

6）构造 AI 模型的提示词和角色

7）构造用户输入，拼接用户输入信息，并用工具类将 Excel 转为 CSV 字符串数据。

8）利用讯飞星火 AI 模型，传入调用者 ID 和输入参数，利用 FutureTask 同步获取，并设置超时时间（超时抛出异常）

9）对 AI 生成结果进行判断，格式错误就返回前端错误信息，并提示重新调用（后续考虑 RabbitMQ 进行重试和补偿机制）

10）将 AI 生成结果持久化到数据库，并更新接口调用次数（判断是否成功），动态给前端返回图标和数据结论。

## ☀️学完这个项目你能得到什么

1）简单地调用 AI 模型（讯飞星火 | 阿里百炼）获取自定义文本内容。

2）简单的 JWT 权限校验 ，利用后端拦截器进行登录校验。

3）上传 Excel 文件，Excel 文件转换为 CSV 数据，AIGC 在线生成可视化图表。

4）Jousp 批量爬取图书列表，可结合 SpringSchedule 定时任务执行。

5）简单的增删改查系统，前后端是如何联调协作的。

6）前端路由懒加载、CDN 静态资源缓存优化、图片懒加载是如何实现的

7）利用 Lodash 进行节流控制，尽量降低无效的恶意刷留言情况。

8）利用自定义线程池和 FutureTask 进行超时请求处理。

9）利用Google 的 GuavaRateLimiter 进行单体限流控制。

10）定时任务结合 Redis 做一个缓存预热，加快查询效率，提高用户体验。

## ☀️项目简介

+ 主要使用Vue2和SpringBoot2实现
+ 项目权限控制分别为：用户借阅，图书管理员，系统管理员
+ 开发工具：IDEA2022.1.3(真不推荐用eclipse开发，IDEA项目可以导出为eclipse项目，二者不影响，但需要自己学教程)
+ [IDEA->Eclipse](https://blog.csdn.net/HD202202/article/details/128076400)
+ [Eclipse->IDEA](https://blog.csdn.net/q20010619/article/details/125096051)

+ 学校老师硬性要求软件的话，还是按要求来。可以先问一下是否可以选择其他软件开发。
+ 用户账号密码：  相思断红肠 123456
+ 图书管理员账号密码:   admin 123456
+ 系统管理员账号密码:   root 123456
+ [前端样式参考](https://gitee.com/mingyuefusu/tushuguanlixitong)  感谢原作者**明月复苏**

+ 遇到交互功能错误，或者页面无法打开，请用开发者工具F12查看请求和响应状态码情况，当然可能小白不懂，那也没关系，可以加我**QQ：909088445**。白天上课，晚上有空才能回答，感谢体谅！⭐⭐⭐

## ☀️项目详细介绍（亮点)

+ 本项目采用前后端分离的模式，前端构建页面，后端作数据接口，前端调用后端数据接口得到数据，重新渲染页面。
+ 后端已开启 CORS 跨域支持
+ API 认证使用 Token 认证
+ 前端在 Authorization 字段提供 Token 令牌
+ 使用 HTTP Status Code 表示状态
+ 数据返回格式使用 JSON
+ 后端采用权限拦截器进行权限校验，并检查登录情况
+ 添加全局异常处理机制，捕获异常，增强系统健壮性
+ 前端用 Echarts 可视化库实现了图书借阅的分析图标（折线图、饼图），并通过 Loading 配置提高加载体验。
+ 留言组件采用弹幕形式，贴合用户的喜好。
+ 引入 knife4j 依赖，使用 Swagger + Knife4j 自动生成 OpenAPI 规范的接口文档，前端可以在此基础上使用插件自动生成接口请求代码，降低前后端协作成本
+ 使用 ElementUI 组件库进行前端界面搭建，快速实现页面生成，并实现了前后端统一权限管理，多环境切换等能力。
+ 基于 MyBatis Plus 框架的 QueryWrapper 实现对 MySQL 数据库的灵活查询，并配合 MyBatisX 插件自动生成后端 CRUD 基础代码，减少重复工作。
+ 前端路由懒加载、CDN 静态资源缓存优化、图片懒加载效果。

### ⭐用户模块功能介绍

![](https://pic.yupi.icu/5563/202403021406815.png)

+ 图书查询功能：分页构造器缓解数据过大压力，后端可设置请求数防止爬虫请求数过大，服务器负载过大。模糊查询进行字段搜索。表格均可导出PDF和EXCEL。
+ 读者规则功能：查询现有的借阅规则，借阅规则包括：借阅编号，可借阅图书数量，可借阅天数，可借阅图书馆，过期扣费/天。
+ 查看公告: 可以查询图书管理员发布的公告列表，文字滑动效果。

+ 个人信息: 可以查看个人的借阅证编号，借阅证姓名，规则编号，状态，可以修改个人账户的密码。

+ 借阅信息: 可以查看自身借阅过的图书记录和归还情况。
+ 违章信息: 可以查询自身归还的图书是否有违章信息。
+ 读者留言: 实现留言功能并以弹幕形式显示。

### ⭐图书管理员模块功能介绍

![](https://pic.yupi.icu/5563/202403021406227.png)

+ 借阅图书: 图书管理员输入借阅证号(用户)和要借的图书编号和当前的时间，点击借阅。
+ 归还图书: 输入图书编号查看图书是否逾期，并且可以设置违规信息，然后选择是否归还图书
+ 借书报表: 用于查询已经借阅并归还的书籍列表，同样使用分页构造器和模糊查询字段，显示借阅证编号，图书编号，借阅日期，截止日期，归还日期，违章信息，处理人。
+ 还书报表: 用于查询已经借阅但是还未归还的书籍列表，显示借阅证编号，图书编号，借阅日期，截止日期。

+ 发布公告: 可以查询当前发布的公告列表，并进行删除，修改，增加功能，分页构造器用于缓解数据量大的情况。

### ⭐系统管理员模块功能介绍

![](https://pic.yupi.icu/5563/202403021406443.png)

+ 书籍管理: 可以查询当前的所有图书，显示图书编号，图书昵称，作者，图书馆，分类，位置，状态，描述。可以进行添加，修改，删除图书。利用分页构造器实现批量查询。利用模糊查询实现图书搜索功能。利用插件实现PDF和EXCEL导出。
+ 书籍类型: 显示查询当前的所有图书类型，可以进行添加，修改，删除图书类型，利用分页构造器实现批量查询，缓解数据压力。
+ 借阅证管理: 可以查询当前的所有借阅证列表，也就是用户数量，可以进行添加，修改，删除操作。同样实现分页。
+ 借阅信息查询: 可以查询当前已经完成借阅和归还的记录，显示借阅证号，书籍编号，借阅日期，截止日期，归还日期，违章信息，处理人。分页功能，PDF和EXCEL导出。
+ 借阅规则管理: 可以查询当前所有的借阅规则，显示限制借阅天数，限制本数，限制图书馆，逾期费用，可以进行添加、删除、修改操作。
+ 图书管理员管理: 显示当前的图书管理员列表，显示账号，姓名，邮箱，可以进行添加、删除、修改操作。
+ 系统管理: 可以查询一个月内的借阅量，以一周为时间间隔，计算借阅量，用Echarts实现折线图的展示。

## ☀️数据库表设计

### t_users表

| 列名        | 数据类型以及长度 | 备注                                              |
| ----------- | ---------------- | ------------------------------------------------- |
| user_id     | int(11)          | 主键 非空 自增 用户表的唯一标识                   |
| username    | varchar(32)      | 用户名 非空                                       |
| password    | varchar(32)      | 密码(MD5加密) 非空                                |
| card_name   | varchar(10)      | 真实姓名 非空                                     |
| card_number | Bigint(11)       | 借阅证编号 固定 11位随机生成 非空(后文都改BigInt) |
| rule_number | int(11)          | 规则编号 可以自定义 也就是权限功能                |
| status      | int(1)           | 1表示可用 0表示禁用                               |
| create_time | datetime         | 创建时间 Java注解 JsonFormatter                   |
| update_time | datetime         | 更新时间 Java注解 JsonFormatter                   |

### t_admins表

| 列名        | 数据类型以及长度 | 备注                              |
| ----------- | ---------------- | --------------------------------- |
| admin_id    | int(11)          | 主键 非空 自增 管理员表的唯一标识 |
| username    | varchar(32)      | 用户名 非空                       |
| password    | varchar(32)      | 密码(MD5加密) 非空                |
| admin_name  | varchar(10)      | 管理员真实姓名 非空               |
| status      | int(1)           | 1表示可用 0表示禁用               |
| create_time | datetime         | 创建时间 Java注解 JsonFormatter   |
| update_time | datetime         | 更新时间 Java注解 JsonFormatter   |

### t_book_admins表

| 列名            | 数据类型以及长度 | 备注                            |
| --------------- | ---------------- | ------------------------------- |
| book_admin_id   | int(11)          | 主键 非空 自增 管理表的唯一标识 |
| username        | varchar(32)      | 用户名 非空                     |
| password        | varchar(32)      | 密码(MD5加密)非空               |
| book_admin_name | varchar(10)      | 图书管理员真实姓名 非空         |
| status          | int(1)           | 1表示可用 0表示禁用             |
| email           | varchar(255)     | 电子邮箱                        |
| create_time     | datetime         | 创建时间 Java注解 JsonFormatter |
| update_time     | datetime         | 更新时间 Java注解 JsonFormatter |

### t_books表

| 列名             | 数据类型以及长度 | 备注                            |
| ---------------- | ---------------- | ------------------------------- |
| book_id          | int(11)          | 主键 自增 非空 图书表的唯一标识 |
| book_number      | int(11)          | 图书编号 非空 图书的唯一标识    |
| book_name        | varchar(32)      | 图书名称 非空                   |
| book_author      | varchar(32)      | 图书作者 非空                   |
| book_library     | varchar(32)      | 图书所在图书馆的名称 非空       |
| book_type        | varchar(32)      | 图书类别 非空                   |
| book_location    | varchar(32)      | 图书位置 非空                   |
| book_status      | varchar(32)      | 图书状态(未借出/已借出)         |
| book_description | varchar(100)     | 图书描述                        |
| create_time      | datetime         | 创建时间 Java注解 JsonFormatter |
| update_time      | datetime         | 更新时间 Java注解 JsonFormatter |

### t_books_borrow表

| 列名        | 数据类型以及长度 | 备注                                                         |
| ----------- | ---------------- | ------------------------------------------------------------ |
| borrow_id   | int(11)          | 主键 自增 非空 借阅表的唯一标识                              |
| card_number | int(11)          | 借阅证编号 固定 11位随机生成 非空 用户与图书关联的的唯一标识 |
| book_number | int(11)          | 图书编号 非空 图书的唯一标识                                 |
| borrow_date | datetime         | 借阅日期 Java注解 JsonFormatter                              |
| close_date  | datetime         | 截止日期 Java注解 JsonFormatter                              |
| return_date | datetime         | 归还日期 Java注解 JsonFormatter                              |
| create_time | datetime         | 创建时间 Java注解 JsonFormatter                              |
| update_time | datetime         | 更新时间 Java注解 JsonFormatter                              |

### t_notice表

| 列名            | 数据类型以及长度 | 备注                                |
| --------------- | ---------------- | ----------------------------------- |
| notice_id       | int(11)          | 主键 非空 自增 公告表记录的唯一标识 |
| notice_title    | varchar(32)      | 公告的题目 非空                     |
| notice_content  | varchar(255)     | 公告的内容 非空                     |
| notice_admin_id | int(11)          | 发布公告的管理员的id                |
| create_time     | datetime         | 创建时间 Java注解 JsonFormatter     |
| update_time     | datetime         | 更新时间 Java注解 JsonFormatter     |

### t_violation表

| 列名               | 数据类型以及长度 | 备注                                |
| ------------------ | ---------------- | ----------------------------------- |
| violation_id       | int(11)          | 主键 非空 自增 违章表记录的唯一标识 |
| card_number        | int(11)          | 借阅证编号 固定 11位随机生成 非空   |
| book_number        | int(11)          | 图书编号 非空 图书的唯一标识        |
| borrow_date        | datetime         | 借阅日期 Java注解 JsonFormatter     |
| close_date         | datetime         | 截止日期 Java注解 JsonFormatter     |
| return_date        | datetime         | 归还日期 Java注解 JsonFormatter     |
| violation_message  | varchar(100)     | 违章信息 非空                       |
| violation_admin_id | int(11)          | 违章信息管理员的id                  |
| create_time        | datetime         | 创建时间 Java注解 JsonFormatter     |
| update_time        | datetime         | 更新时间 Java注解 JsonFormatter     |

### t_comment表

| 列名                  | 数据类型以及长度 | 备注                                |
| --------------------- | ---------------- | ----------------------------------- |
| comment_id            | int(11)          | 主键 非空 自增 留言表记录的唯一标识 |
| comment_avatar        | varchar(255)     | 留言的头像                          |
| comment_barrage_style | varchar(32)      | 弹幕的高度                          |
| comment_message       | varchar(255)     | 留言的内容                          |
| comment_time          | int(11)          | 留言的时间(控制速度)                |
| create_time           | datetime         | 创建时间 Java注解 JsonFormatter     |
| update_time           | datetime         | 更新时间 Java注解 JsonFormatter     |

### t_book_rule表

| 列名               | 数据类型以及长度 | 备注                                  |
| ------------------ | ---------------- | ------------------------------------- |
| rule_id            | int(11)          | 主键 非空 自增 借阅规则记录的唯一标识 |
| book_rule_id       | int(11)          | 借阅规则编号 非空                     |
| book_days          | int(11)          | 借阅天数 非空                         |
| book_limit_number  | int(11)          | 限制借阅的本数 非空                   |
| book_limit_library | varchar(255)     | 限制的图书馆 非空                     |
| book_overdue_fee   | double           | 图书借阅逾期后每天费用 非空           |
| create_time        | datetime         | 创建时间 Java注解 JsonFormatter       |
| update_time        | datetime         | 更新时间 Java注解 JsonFormatter       |

### t_book_type表

| 列名         | 数据类型以及长度 | 备注                                  |
| ------------ | ---------------- | ------------------------------------- |
| type_id      | int(11)          | 主键 非空 自增 图书类别记录的唯一标识 |
| type_name    | varchar(32)      | 借阅类别的昵称 非空                   |
| type_content | varchar(255)     | 借阅类别的描述 非空                   |
| create_time  | datetime         | 创建时间 Java注解 JsonFormatter       |
| update_time  | datetime         | 更新时间 Java注解 JsonFormatter       |

## 🐼功能演示图

### 用户模块功能图

**首页轮播图演示**

![](https://pic.yupi.icu/5563/202403021406581.png)

**图书查询演示**

![](https://pic.yupi.icu/5563/202403021406053.png)

**读者规则演示**

![](https://pic.yupi.icu/5563/202403021406571.png)

**查看公告演示**

![](https://pic.yupi.icu/5563/202403021406776.png)

**个人信息演示**

![](https://pic.yupi.icu/5563/202403021406779.png)

**借阅信息演示**

![](https://pic.yupi.icu/5563/202403021406890.png)

**违章信息演示**

![](https://pic.yupi.icu/5563/202403021406091.png)

**读者留言演示**

![](https://pic.yupi.icu/5563/202403021406261.png)

**智能推荐演示**

![](https://pic.yupi.icu/5563/202403021406234.png)

### 图书管理员功能图

**借阅图书演示**

![](https://pic.yupi.icu/5563/202403021406213.png)

**归还图书演示**

![](https://pic.yupi.icu/5563/202403021406604.png)

**借书报表演示**

![](https://pic.yupi.icu/5563/202403021406590.png)

**还书报表演示**

![](https://pic.yupi.icu/5563/202403021406562.png)

**发布公告演示**

![](https://pic.yupi.icu/5563/202403021406616.png)

### 系统管理员功能图

+ 由于篇幅受限，系统功能展示主要功能。

**系统管理演示**

![](https://pic.yupi.icu/5563/202403021406081.png)

![](https://pic.yupi.icu/5563/202403021406169.png)

**智能分析演示**

![](https://pic.yupi.icu/5563/202403021406245.png)

## 🐼部署项目

![](https://pic.yupi.icu/5563/202403021406282.png)

+ 可以下载ZIP压缩包或者使用克隆(Git clone)
+ 复制http或者ssh的链接（github建议ssh,gittee都可以)
+ 在D盘新建一个文件夹，点击进入该文件夹，右键Git Bash Here

![](https://pic.yupi.icu/5563/202403021406715.png)

+ 还没有下载Git或者不会Git的建议先看基础教程（30分钟左右)

+ 输入git init 初始化git项目 然后出现一个.git文件夹
+ 输入git remote add origin xxxxxx(xxx为刚刚复制的http或者ssh链接)

+ 输入git pull origin master 从远程代码托管仓库拉取代码
+ 成功拉取项目（前端后端都是如此)
+ 前端项目注意依赖下载使用npm install 或者 yarn install （Vscode或者Webstorm)
+ 后端项目注意maven依赖下载（IDEA(推荐)或者Ecplise)
+ 前端npm 镜像源建议淘宝镜像源，后端maven镜像源推荐阿里云镜像源（非必选，但更换后下载快速)

## 🐼部署项目问题

⭐

+ 乱码问题 项目采用的UFT-8
+ 一般出现乱码就是UTF-8和GBK二者相反
+ 请百度IDEA乱码和Eclipse乱码问题(描述清楚即可)

⭐

+ 点击交互按钮，没有发生反应。
+ 很明显，请求失败，浏览器打开开发者工具，Edge浏览器直接ctrl+shift+i,其他浏览器按F12
+ 查看红色的请求和响应状态码问题

⭐

+ 先阅读文档再进行问题的查询或者提问
+ 提问有技巧，模糊的发言，让高级架构师找BUG也无从下手


## 🐼需求分析和设计


![](https://pic.yupi.icu/5563/202403061545778.png)

## 🐼项目API接口文档

+ 接口文档篇幅过大
+ 本来想完全采用RESTFUL风格，做到一半忘记了
+ 看清楚文档的基准地址
+ 要API后端接口文档详细内容和数据库结构+内容一起的，将前后端**star**⭐的截图加我QQ：**909088445**发我即可领取~感谢支持

#### **数据库领取截图示例(Gitee&GitHub)：**

![](https://pic.yupi.icu/5563/202403021406801.png)

![](https://pic.yupi.icu/5563/202403021406821.png)

![](https://pic.yupi.icu/5563/202403092029471.png)

![](https://pic.yupi.icu/5563/202403092029399.png)
