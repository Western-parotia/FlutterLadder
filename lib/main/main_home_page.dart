import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_app/ext/arrays_ext.dart';
import 'package:wanandroid_app/ext/obj_ext.dart';
import 'package:wanandroid_app/ext/refresh_ext.dart';
import 'package:wanandroid_app/main/widget/article_item_widget.dart';

import 'model/article_model.dart';
import 'model/banner_model.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainHomeState();
  }
}

class _MainHomeState extends State<MainHomePage> {
  int _page = 0;

  var _bannerList = <BannerModel>[];
  final _articleList = <ArticleModel>[];

  final _refreshController = RefreshController(initialRefresh: true);

  // 获取banner数据
  loadBannerData() async {
    String url = 'https://www.wanandroid.com/banner/json';
    try {
      Response response = await Dio().get(url);
      _bannerList = response.data['data'].map<BannerModel>((item) => BannerModel.fromJson(item)).toList();
      '1---$_bannerList'.println();
    } catch (e, v) {
      v.println(title: e);
    }
  }

  loadArticlesData() async {
    String url = 'https://www.wanandroid.com/article/list/$_page/json';
    try {
      Response response = await Dio().get(url);
      List<ArticleModel> dataModelList = response.data['data']['datas'].map<ArticleModel>((item) => ArticleModel.fromJsonMapToModel(item)).toList();
      '3---$dataModelList'.println();

      /// 分页加载
      _articleList.addAllCheckClear(_page == 0, dataModelList);
      _refreshController.refreshAndLoadCompleted();
      setState(() {});
    } catch (e, s) {
      s.println(title: e);
    }
  }

  loadAll() {
    loadBannerData();
    loadArticlesData();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () {
        _page = 0;
        loadAll();
      },
      onLoading: () {
        _page++;
        loadArticlesData();
      },
      child: CustomScrollView(slivers: [
        Container(
          height: 201,
          child: _bannerList.isEmpty
              ? Container()
              : Swiper(
                  loop: true,
                  autoplay: true,
                  autoplayDelay: 5000,
                  pagination: const SwiperPagination(),
                  //页码 ,默认剧中
                  itemCount: _bannerList.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                        onTap: () {
                          var banner = _bannerList[index];
                          // 点击事件
                        },
                        child: CachedNetworkImage(
                            imageUrl: _bannerList[index].imagePath,
                            placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()), //加载中控件
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.fill));
                  },
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
        ),
      ]),
    );
  }
}
