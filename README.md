# surmon.me.flutter
Surmon.me App by flutter, the project forked from [flutter-go](https://github.com/surmon-china/flutter-go).

设置全局 PUB 库地址变量：

```bash
vim ~/.bash_profile

# 加入变量
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

1. 检查 flutter 环境依赖

```bash
flutter doctor
```

2. 安装依赖

    - 安装 Android Sudio，同时会安装 SDK
    - IOS 依赖：
        ```brew update```
        ```brew install --HEAD usbmuxd```
        ```brew link usbmuxd```
        ```brew install --HEAD libimobiledevice```
        ```brew install ideviceinstaller```
        ```brew install ios-deploy```
        ```brew install cocoapods```
        ```pod setup```

3. 查看可用于调试的设备或模拟器，如果没有有效设备可能无法正常开发

```bash
flutter devices
```

4. 启动 IOS 模拟器（或者安卓模拟器）

```bash
# 启动 IOS 模拟器
open -a Simulator
```

5. 安装项目依赖

```bash
flutter packages get
```

6. 跑

```bash
flutter run
```


### 依赖库

- fluro 负责导航路由
- markdown 负责文章内容的解析

### 文件目录结构(以LIb文件说明)

- lib
  - main.dart 入口文件
  - common 公共的method
  - components widget
  - generated
  - model 存放模型, 不应该加入逻辑层
  - router 路由
  - views 展示界面
  - widget (与components概念重合,废弃)

``` javascript
├── main.dart //入口文件
├── common 公共的method
│   ├── Style.dart
│   ├── eventBus.dart
│   ├── provider.dart
│   └── sql.dart
├── components //app展示框架用到的组件
│   ├── Input.dart
│   ├── List.dart
│   ├── Pagination.dart
│   ├── Pagination2.dart
│   ├── SearchInput.dart
│   └── homeBanner.dart
├── generated
│   └── i18n.dart
├── model //本地存放模型, 不应该加入逻辑层
│   ├── base.dart
│   ├── cat.dart
│   ├── story.dart
│   └── widget.dart
├── routers //路由
│   ├── application.dart
│   ├── router_handler.dart
│   └── routers.dart
├── views //app展示界面
│   ├── Detail.dart
│   ├── FirstPage.dart
│   ├── FourthPage.dart
│   ├── ThirdPage.dart
│   ├── category.dart
│   ├── demos
│   │   ├── home.dart
│   │   └── layout
│   │       ├── SamplePage.dart
│   │       └── layout_type.dart
│   └── widgetPage.dart
└── widgets
    └── ... //下面详细说明
```

``` javascript
└── widgets // 对flutter所有元素和组件的分类
    ├── 404.dart
    ├── index.dart // widgets 的总入口文件
    ├── components // 组件的分类 (区别于上面的components)
    │   └── index.dart
    ├── elements // 基础元素的分类
    │   ├── index.dart // elements下的 elements 类型入口文件
    │   ├── Form // elements下的 From 类型集合
    │   │   ├── Button // button 元素，里面是 文件夹代表类名/index.dart
    │   │   │   ├── FlatButton
    │   │   │   │   └── index.dart
    │   │   │   ├── RaisedButton
    │   │   │   │   └── index.dart
    │   │   │   └── index.dart
    │   │   ├── CheckBox
    │   │   ├── Input
    │   │   ├── Radio
    │   │   ├── Slider
    │   │   ├── Switch
    │   │   ├── Text
    │   │   └── index.dart
    │   ├── Frame // elements下的 Frame 类型集合
    │   │   ├── Align
    │   │   ├── Axis
    │   │   ├── Box
    │   │   ├── Expanded
    │   │   ├── Layout
    │   │   ├── Stack
    │   │   ├── Table
    │   │   └── spacing
    │   └── Media // elements下的 Media 类型集合
    │       ├── Canvas
    │       ├── Icon
    │       └── Image
    └── themes
        └── index.dart
```

```javascript
widget 里的文件结构，用来存放封装的逻辑组件, 文件目录应为, 类比rax
- widget // widget 下详细元素或组件的目录结构
  - hello-world // 例如
    - mods    // (可选, 子模块)
    - mocks // (可选)
    - utils // (可选, 存放暂时的私有method)
    - schema
    - index.dart
```
