import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid_app/modules/home/model/article_model.dart';
import 'package:wanandroid_app/modules/home/model/banner_model.dart';
import 'package:wanandroid_app/modules/home/widget/article_item_widget.dart';
import 'package:wanandroid_app/modules/home/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ChangeNotifier {
  final double _expandedHeight = 200;
  final ScrollController _scrollController = ScrollController();
  //监听scroll滚动 是否显示naviBar  ValueNotifier 监听单个变量值或类
  final ValueNotifier _valueNotifier = ValueNotifier<bool>(false);

  List<BannerModel> _bannerList = [];
  List<ArticleModel> _topArticleList = [];
  List<ArticleModel> _articleList = [];
  // 这里直接使用dio请求banner等数据，不做任何空值等特殊处理的封装，实际项目中可使用公共处理的网络请求
  // 也可以创建独立处理请求viewModel做数据请求等

  // 获取banner数据
  getBannerData() async {
    String url = 'https://www.wanandroid.com/banner/json';
    try {
      Response response = await Dio().get(url);
      _bannerList = response.data['data']
          .map<BannerModel>((item) => BannerModel.fromJsonMapToModel(item))
          .toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  // 置顶文章
  getTopArticlesData() async {
    String url = 'https://www.wanandroid.com/article/top/json';
    try {
      Response response = await Dio().get(url);
      _topArticleList = response.data['data']
          .map<ArticleModel>((item) => ArticleModel().fromJsonMapToModel(item))
          .toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  // 文章，目前不做分页加载
  getArticlesData() async {
    String url = 'https://www.wanandroid.com/article/list/0/json';
    try {
      Response response = await Dio().get(url);
      _articleList = response.data['data']['datas']
          .map<ArticleModel>((item) => ArticleModel().fromJsonMapToModel(item))
          .toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  // 滚动监听
  scrollAddListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset >
              _expandedHeight - MediaQueryData.fromWindow(window).padding.top &&
          !_valueNotifier.value) {
        _valueNotifier.value = true;
        notifyListeners();
      } else if (_scrollController.offset <
              _expandedHeight - MediaQueryData.fromWindow(window).padding.top &&
          _valueNotifier.value) {
        _valueNotifier.value = false;
        notifyListeners();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollAddListener();
    getBannerData();
    getTopArticlesData();
    getArticlesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        child: CustomScrollView(
          controller: _scrollController,
          // sliver是特殊用途的小部件，可以使用CustomScrollView组合来创建自定义滚动效果
          slivers: [
            //const SliverToBoxAdapter(), //SliverToBoxAdapter 单一小部件，这里去掉之后SliverAppBar固定
            ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: (context, value, _) {
                  return SliverAppBar(
                    pinned: true,
                    expandedHeight: _expandedHeight,
                    backgroundColor: value == true ? Colors.blue : Colors.white,
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: _bannerList.isEmpty
                          ? Container()
                          : BannerWidget(_bannerList),
                      title:
                          value == true ? const Text('Flutter') : Container(),
                    ),
                    actions: [
                      value == true
                          ? IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            )
                          : const SizedBox()
                    ],
                  );
                }),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  ArticleModel item = _topArticleList[index];
                  return ArticleItemWidget(
                    model: item,
                    index: index,
                    isTopArt: true,
                  );
                },
                childCount: _topArticleList.length,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  ArticleModel item = _articleList[index];
                  return ArticleItemWidget(
                    model: item,
                    index: index,
                  );
                },
                childCount: _articleList.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'homeFab',
        onPressed: () {
          if (_valueNotifier.value == true) {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic);
          } else {
            // 搜索事件
          }
        },
        child: ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (context, value, _) {
            return value == true
                ? const Icon(
                    Icons.vertical_align_top,
                  )
                : const Icon(
                    Icons.search,
                  );
          },
        ),
      ),
    );
  }
}
