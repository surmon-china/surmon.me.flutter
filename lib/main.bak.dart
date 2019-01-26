import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/rendering.dart';

import 'views/home.dart';
import 'views/widget_page.dart';
import 'views/fourth_page.dart';
import 'views/collection_page.dart';

import 'routers/routers.dart';
import 'routers/application.dart';
import 'common/provider.dart';
import 'model/widget.dart';

import 'package:surmon/widgets/index.dart';
import 'package:surmon/components/search_input.dart';

// 全站配色 16进制
Color themeColor = const Color.fromRGBO(0, 136, 245, 1.0);
Color bgColor = const Color.fromRGBO(238, 238, 238, 1.0);
Color textColor = const Color.fromRGBO(85, 85, 85, 1.0);

// 根组件
class MyApp extends StatelessWidget {

  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Surmon.me',
      theme: new ThemeData(
        primaryColor: themeColor,
        backgroundColor: bgColor,
        accentColor: textColor,
        textTheme: TextTheme(
          // 设置 Material 的默认字体样式
          body1: TextStyle(color: textColor, fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: themeColor,
          size: 35.0,
        ),
      ),
      home: new MyHomePage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}

void main() async {
  final provider = new Provider();
  await provider.init(true);
  // db = Provider.db;
  runApp(new MyApp());
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  WidgetControlModel widgetControl = new WidgetControlModel();
  TabController controller;
  bool isSearch = false;
  String data = '无';
  String data2ThirdPage = '这是传给ThirdPage的值';
  String appBarTitle = tabData[0]['text'];
  static List tabData = [
    {'text': '业界动态', 'icon': new Icon(Icons.language)},
    {'text': 'WIDGET', 'icon': new Icon(Icons.extension)},
    {'text': '组件收藏', 'icon': new Icon(Icons.star)},
    {'text': '关于手册', 'icon': new Icon(Icons.favorite)}
  ];

  List<Widget> myTabs = [];

  @override
  void initState() {
    super.initState();
    controller = new TabController(
        initialIndex: 0, vsync: this, length: 4); // 这里的length 决定有多少个底导 submenus
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onWidgetTap(WidgetPoint widgetPoint, BuildContext context) {
    List widgetDemosList = new WidgetDemoList().getDemos();
    String targetName = widgetPoint.name;
    String targetRouter = '/category/error/404';
    widgetDemosList.forEach((item) {
      if (item.name == targetName) {
        targetRouter = item.routerName;
      }
    });
    Application.router.navigateTo(context, "$targetRouter");
  }

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
        List<WidgetPoint> list = await widgetControl.search(value);
        return list.map((item) => new MaterialSearchResult<String>(
          value: item.name,
          text: item.name,
          onTap: () {
            onWidgetTap(item, context);
          },
        ))
            .toList();
      } else {
        return null;
      }
    }, (value) {}, () {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: buildSearchInput(context)),
      body: new TabBarView(controller: controller, children: <Widget>[
        new HomePage(),
        new WidgetPage(),
        new CollectionPage(),
        new FourthPage()
      ]),
      bottomNavigationBar: Material(
        color: const Color(0xFFF0EEEF), //底部导航栏主题颜色
        child: SafeArea(
          child: Container(
            height: 65.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: const Color(0xFFd0d0d0),
              //     blurRadius: 3.0,
              //     spreadRadius: 2.0,
              //     offset: Offset(-1.0, -1.0),
              //   ),
              // ],
            ),
            child: TabBar(
              controller: controller,
              indicatorColor: Theme.of(context).primaryColor, //tab标签的下划线颜色
              // labelColor: const Color(0xFF000000),
              indicator: null,
              // indicatorWeight: 0.1,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: const Color(0xFF8E8E8E),
              tabs: <Tab>[
                Tab(text: '首页', icon: Icon(Icons.language)),
                Tab(text: '组件', icon: Icon(Icons.extension)),
                Tab(text: '百鸣苑', icon: Icon(Icons.star)),
                Tab(text: '其他', icon: Icon(Icons.favorite)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        print('改变了而');
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }
}
