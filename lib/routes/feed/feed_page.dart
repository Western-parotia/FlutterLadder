import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wanandroid_app/common/color_list.dart';
import 'package:wanandroid_app/ext/ext.dart';
import 'package:wanandroid_app/model/base_entity.dart';
import 'package:wanandroid_app/wiget/banner_widget.dart';
import 'package:wanandroid_app/model/banner_entity.dart';
import 'package:wanandroid_app/net/http.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedPageStateDio();
}

class _FeedPageStateDio extends State<FeedPage> {
  List<BannerEntity> banners = [
    BannerEntity(
        "http://tva1.sinaimg.cn/large/005Jb6GUgy1gvnb1l8cnqj60d206h76302.jpg"),
    BannerEntity(
        "http://tva1.sinaimg.cn/large/005Jb6GUgy1gvamn2yey2j609t05ggms02.jpg"),
    BannerEntity(
        "http://tva1.sinaimg.cn/large/008sVhfmgy1h25puseaepj30fm07rgs4.jpg")
  ];

  List<FeedItem> feeds = [];
  int pageSize = 0;
  bool noMoreData = false;

  void _fetchData() async {
    if (pageSize > 1) {
      //不可以立即调刷新
      Future.delayed(const Duration(seconds: 2)).then((value) => {
            setState(() {
              noMoreData = true;
            })
          });
      return;
    }

    Response res = await HttpClient.getDio()
        .get(ServiceApiConstants.feeds + "$pageSize/json");
    print("res:${res.data}");
    BaseEntity root = BaseEntity.fromJson(res.data);
    print(
        "errorCode:${root.errorCode} errorMsg:${root.errorMsg} data:${root.data}");
    PageData feedPage = PageData.fromJson(root.data);
    print("feedPage:${feedPage.curPage}");
    List<FeedItem> datas = FeedItem.fromJsonList(feedPage.datas.cast());
    print("datas:${datas.length}");
    pageSize += 1;
    Future.delayed(const Duration(seconds: 1)).then((value) => {
          setState(() {
            feeds.addAll(datas);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: MColors.pageBackground,
        backgroundColor: Colors.amber,
        body: Column(
          children: [
            // Expanded(flex: 0, child: BannerWidget(banners)),
            Expanded(
                flex: 1,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: feeds.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: BannerWidget(banners),
                      );
                    } else if ((index - 1) == feeds.length && !noMoreData) {
                      _fetchData();
                      return Container(
                        padding: const EdgeInsets.all((16.0)),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                      );
                    } else if ((index - 1) < feeds.length) {
                      // return ListTile(title: Text(feeds[index].title));
                      return _buildItems(index - 1);
                    } else {
                      return Container(
                        padding: const EdgeInsets.all((16.0)),
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "——再拉就过分了哈——",
                            style: TextStyle(color: MColors.textColorDark),
                          ),
                        ),
                      );
                    }
                  },
                ))
          ],
        ));
  }

  Widget _buildItems(int index) {
    FeedItem item = feeds[index];
    return Card(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        elevation: 1,
        child: Container(
            padding: const EdgeInsets.all(10),
            // color: MColors.cardBackground,
            color: Colors.black12,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.envelopePic,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 90,
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 90,
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                              flex: 0,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(item.title,
                                    maxLines: 1, //softWrap 会展示半个字
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: MColors.textColorLight,
                                    )),
                              )),
                          Expanded(
                            flex: 0,
                            child: Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: Text(item.desc,
                                  maxLines: 2, //softWrap 会展示半个字
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: MColors.textColorDark,
                                  )),
                            ),
                          ),
                          Expanded(flex: 0, child: Container()),
                          Expanded(
                            flex: 0,
                            child: Container(
                                child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 2, right: 2),
                                  alignment: const Alignment(0, 0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.account_circle_rounded,
                                        size: 15,
                                        color: MColors.textColorDark,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        constraints:
                                            const BoxConstraints(maxWidth: 50),
                                        child: Text(
                                          item.author.joinGhostCharacter(),
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: MColors.textColorDark,
                                              fontSize: 15),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 1, child: Container()),
                                Expanded(
                                    flex: 0,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      alignment: const Alignment(0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            " ${item.niceDate}",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: MColors.textColorDark,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            )),
                          )
                        ],
                      ),
                    ))
              ],
            )));
  }
}
