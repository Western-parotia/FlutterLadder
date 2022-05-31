import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  final List bannerList;

  const BannerWidget(this.bannerList, {Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      loop: true,
      autoplay: true,
      autoplayDelay: 5000,
      pagination: const SwiperPagination(), //页码 ,默认剧中
      itemCount: widget.bannerList.length,
      itemBuilder: (ctx, index) {
        return InkWell(
            onTap: () {
              var banner = widget.bannerList[index];
              // 点击事件
            },
            child: BannerImage(widget.bannerList[index].imagePath));
      },
    );
  }
}

class BannerImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const BannerImage(this.url, {Key? key, this.fit = BoxFit.fill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) =>
            const Center(child: CupertinoActivityIndicator()), //加载中控件
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: fit);
  }
}
