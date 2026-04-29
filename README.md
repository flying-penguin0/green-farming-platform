# 绿色农产品种养殖平台

基于 `JSP + Spring + Spring MVC + MyBatis + MySQL` 的绿色农产品种养殖平台毕业设计项目。

系统围绕“种植/养殖周期管理 + 过程记录 + 农产品展示销售 + 订单交易 + 透明溯源”展开，支持管理员、种植户、养殖户、普通用户四类角色，适合课程设计、毕业设计演示与二次开发。

## 1. 技术栈

- 后端：Spring、Spring MVC、MyBatis
- 前端：JSP、JSTL、Bootstrap、jQuery、ECharts
- 数据库：MySQL 8.x
- 连接池：Druid
- 文件上传：Commons FileUpload
- 运行环境：JDK 8+、Tomcat 9+
- 项目构建：Maven Web

## 2. 项目特色

- 支持多角色登录与权限区分
- 支持种植周期、养殖周期统一管理
- 支持环节模板配置与种养殖过程记录
- 支持首页农产品展示、商户聚合展示、搜索与详情查看
- 支持周期时间线溯源展示，提升过程透明度
- 支持购物车、立即购买、订单流转、收货地址选择
- 支持评论、回复、收藏、公告、轮播图运营
- 支持管理员、种植户、养殖户订单数据导出 Excel
- 支持头像、产品图、记录图、轮播图等图片上传

## 3. 角色与功能模块

### 3.1 前台门户

- 首页展示
  - 顶部导航展示种植周期、养殖周期、农产品、平台公告
  - 首页轮播图展示
  - 周期卡片展示
  - 商户及旗下农产品展示
![img_1.png](images/img_1.png)
- 种植周期展示
  - 周期列表
  - 时间线展开查看
  - 记录图片展示
![img_2.png](images/img_2.png)
- 养殖周期展示
  - 周期列表
  - 时间线展开查看
  - 记录图片展示
![img_3.png](images/img_3.png)
- 农产品浏览
  - 按关键字搜索
  - 按商户聚合展示
  - 查看商户全部商品
![img_4.png](images/img_4.png)
- 农产品详情
  - 商品图文信息
  - 所属周期信息
  - 周期时间线
  - 用户评价展示
  - 加入购物车
  - 立即购买
  - 收藏商品
![img_5.png](images/img_5.png)
- 平台公告
  - 公告列表
  - 公告详情展示
![img_6.png](images/img_6.png)
- 登录注册
  - 多角色登录
  - 普通用户注册
  - 注册头像上传
![img_7.png](images/img_7.png)
### 3.2 普通用户模块

- 个人中心
  - 统计信息展示
  - 快捷入口导航
![img_8.png](images/img_8.png)
- 个人信息
  - 基本资料维护
  - 头像上传
  - 原密码校验后修改密码
![img_9.png](images/img_9.png)
- 收货地址管理
  - 新增地址
  - 编辑地址
  - 删除地址
  - 设置默认地址
![img_10.png](images/img_10.png)
- 购物车
  - 加入购物车
  - 数量增减
  - Ajax 更新数量
  - 删除购物车商品
  - 选择收货地址后提交订单
![img_11.png](images/img_11.png)
- 立即购买
  - 商品详情页直接下单
  - 选择收货地址
- 我的订单
  - 订单列表
  - 查看商品明细
  - 确认收货
![img_12.png](images/img_12.png)
- 我的收藏
  - 收藏商品
  - 取消收藏
![img_13.png](images/img_13.png)
- 我的评价
  - 对已完成订单商品评分
  - 提交文字评价
  - 查看已评价记录
![img_14.png](images/img_14.png)
### 3.3 种植户模块

- 数据看台
  - 周期数、产品数、订单数、销售额统计
  - ECharts 图表展示
![img_15.png](images/img_15.png)
- 种植周期管理
  - 新增、编辑、删除周期
  - 设置公开状态、周期状态
![img_16.png](images/img_16.png)
- 种植环节记录
  - 记录依附于周期计划
  - 选择环节模板
  - 填写记录标题、内容、时间、图片
![img_17.png](images/img_17.png)
- 农产品管理
  - 商品新增、编辑、删除
  - 关联产品分类
  - 关联所属周期
![img_18.png](images/img_18.png)
- 订单管理
  - 查看买家订单
  - 查看收货信息
  - 更新订单状态
  - 导出 Excel
![img_19.png](images/img_19.png)
![img_20.png](images/img_20.png)
- 评价管理
  - 查看商品评价
  - 展示买家昵称与头像
  - 回复评价
![img_21.png](images/img_21.png)
- 个人中心
  - 基本资料维护
  - 头像上传
  - 修改密码
![img_22.png](images/img_22.png)
### 3.4 养殖户模块（功能基本和种植户一致）

- 数据看台
  - 周期数、产品数、订单数、销售额统计
  - ECharts 图表展示
- 养殖周期管理
  - 新增、编辑、删除周期
  - 设置公开状态、周期状态
- 养殖环节记录
  - 记录依附于周期计划
  - 选择环节模板
  - 填写记录标题、内容、时间、图片
- 农产品管理
  - 商品新增、编辑、删除
  - 关联产品分类
  - 关联所属周期
- 订单管理
  - 查看买家订单
  - 查看收货信息
  - 更新订单状态
  - 导出 Excel
- 评价管理
  - 查看商品评价
  - 展示买家昵称与头像
  - 回复评价
- 个人中心
  - 基本资料维护
  - 头像上传
  - 修改密码

### 3.5 管理员模块

- 数据看台
  - 用户、周期、商品、订单、评价、公告等统计
  - 平台核心数据概览
![img_23.png](images/img_23.png)
- 用户管理
  - 管理普通用户、种植户、养殖户
  - 启用/停用状态维护
  - 支持头像维护
  - 管理员账号不可删除
![img_24.png](images/img_24.png)
- 环节模板管理
  - 配置种植/养殖环节模板
  - 启用状态管理
![img_25.png](images/img_25.png)
- 种养殖周期管理
  - 查看所有种植/养殖周期
  - 维护周期基础信息
![img_26.png](images/img_26.png)
- 产品分类管理
  - 分类新增、编辑、删除
  - 分类状态维护
![img_27.png](images/img_27.png)
- 产品管理
  - 查看全平台商品
  - 商品新增、编辑、删除
![img_28.png](images/img_28.png)
- 订单管理
  - 查看全平台订单
  - 更新订单状态
  - 导出 Excel
![img_29.png](images/img_29.png)
- 评价管理
  - 查看买家评价
  - 展示买家/商家头像昵称
  - 评价状态管理
![img_30.png](images/img_30.png)
- 公告管理
  - 公告新增、编辑、删除
  - 发布状态管理
![img_31.png](images/img_31.png)
- 首页轮播图管理
  - 轮播图新增、编辑、删除
  - 轮播图状态管理
![img_32.png](images/img_32.png)
- 个人中心
  - 基本资料维护
  - 头像上传
  - 修改密码
![img_33.png](images/img_33.png)
## 4. 当前项目结构

```text
farmer
├─ sql
│  ├─ green_farming_platform.sql
│  └─ fix_garbled_demo_data.sql
├─ src
│  └─ main
│     ├─ java/com/farmer
│     │  ├─ controller
│     │  ├─ service
│     │  ├─ service/impl
│     │  ├─ mapper
│     │  ├─ entity
│     │  ├─ dto
│     │  ├─ interceptor
│     │  └─ util
│     ├─ resources
│     │  ├─ mapper
│     │  ├─ spring
│     │  └─ jdbc.properties
│     └─ webapp
│        ├─ static
│        └─ WEB-INF
│           └─ views
├─ pom.xml
└─ README.md
```

## 5. 数据库说明

数据库名称建议使用：

```sql
green_farming_platform
```

SQL 文件说明：

- `sql/green_farming_platform.sql`：主建表与初始化数据


## 6. 运行说明

### 6.1 开发环境要求

- JDK 8 及以上
- Maven
- Tomcat 9 及以上
- MySQL 8.x

### 6.2 配置数据库

编辑：

`src/main/resources/jdbc.properties`

重点修改以下配置为你自己的本地环境：

```properties
jdbc.url=jdbc:mysql://127.0.0.1:3306/green_farming_platform?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&useSSL=false
jdbc.username=你的数据库账号
jdbc.password=你的数据库密码
```

### 6.3 启动方式

1. 用 IDEA 导入为 Maven Web 项目
2. 配置 Tomcat
3. 部署项目
4. 启动后访问首页：

```text
http://localhost:8080/green-farming-platform/portal/home
```

### 6.4 编码说明

项目已统一设置 UTF-8：

- `web.xml` 中启用了 `CharacterEncodingFilter`
- JSP 页面统一按 UTF-8 编码处理
- 数据库连接使用 `characterEncoding=UTF-8`

如果仍出现乱码，优先检查：

- IDEA 文件编码是否为 UTF-8
- MySQL 库、表、连接字符集是否为 UTF-8
- Tomcat 控制台与 JSP 编译编码是否一致

## 7. 图片上传说明

系统已实现图片上传，主要用于：

- 用户头像
- 商户头像
- 商品图片
- 周期记录图片
- 轮播图

上传接口：

```text
/upload/image
```

说明：

- 适合本地 Tomcat 演示环境
- 上传目录会按运行环境落到项目静态资源目录
- 重新部署时，如清空部署目录，上传文件可能需要重新同步

## 8. 订单导出说明

订单管理已支持 Excel 导出，适用角色：

- 管理员
- 种植户
- 养殖户

导出内容包括：

- 编号
- 订单号
- 买家/卖家
- 订单状态
- 收货人
- 联系电话
- 收货地址
- 商品明细
- 订单金额
- 下单时间
- 支付时间

## 9. 默认演示账号

以数据库初始化脚本中的实际数据为准，常用演示账号通常包括：

- 管理员
- 种植户
- 养殖户
- 普通用户

如果你改过初始化数据，请直接以数据库中的 `user` 表记录为准。
## ⭐ 支持一下
如果本项目对你有帮助，欢迎点个 Star，你的鼓励是持续更新的动力！