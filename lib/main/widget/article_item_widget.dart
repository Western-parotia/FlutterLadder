import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/article_model.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleModel? model;

  final int? index;

  /// 是否为置顶文章 默认不是
  final bool isTopArt;

  const ArticleItemWidget({this.model, this.index, this.isTopArt = false, Key? key}) : super(key: key);

  Widget activityIndicator(double size) {
    return SizedBox(
      width: size,
      height: size,
      child: CupertinoActivityIndicator(radius: min(10.0, size / 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: isTopArt ? Colors.blue.withAlpha(10) : Colors.white,
          child: InkWell(
            onTap: () {
              /// 点击事件
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                bottom: Divider.createBorderSide(context, width: 0.7),
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: 'http://placeimg.com/20/20/${model?.author.hashCode.toString()}${model?.author.toString()}',
                          width: 20,
                          height: 20,
                          placeholder: (context, url) => activityIndicator(20),
                          errorWidget: (_, __, ___) => activityIndicator(20),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          model?.author != null && model?.author != '' ? model?.author ?? '' : model?.shareUser ?? '',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(model?.niceDate ?? '', style: Theme.of(context).textTheme.caption)
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  model?.envelopePic == null || model?.envelopePic == ''
                      ? Padding(
                          padding: const EdgeInsets.only(top: 7, bottom: 7),
                          child: Text(
                            model?.title ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model?.title ?? '',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CachedNetworkImage(
                              imageUrl: 'http://placeimg.com/60/60/${model?.author.hashCode.toString()}${model?.envelopePic.toString()}',
                              width: 60,
                              height: 60,
                              placeholder: (context, url) => activityIndicator(60),
                              errorWidget: (_, __, ___) => activityIndicator(60),
                            )
                          ],
                        ),
                  Row(
                    children: <Widget>[
                      isTopArt == true
                          ? Container(
                              margin: const EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              height: 16,
                              width: 30,
                              //边框设置
                              decoration: BoxDecoration(
                                //背景
                                // color: Colors.white,
                                //设置四周圆角 角度
                                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                                //设置四周边框
                                border: Border.all(width: 1, color: Colors.blue),
                              ),
                              child: const Text(
                                "置顶",
                                style: TextStyle(color: Colors.blue, fontSize: 10),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (model?.superChapterName == null || model?.superChapterName == '')
                              ? ''
                              : ('${model?.superChapterName}·') + (model?.chapterName ?? ''),
                          style: Theme.of(context).textTheme.overline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 25, 10),
            child: Icon(Icons.favorite_border, color: Colors.redAccent[100]),
          ),
        )
      ],
    );
  }
}
