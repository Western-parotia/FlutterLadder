import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/model/banner_entity.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget(this._images, {Key? key, this.height = 200, this.onTap})
      : super(key: key);
  final List<BannerEntity> _images;
  final double height;
  final ValueChanged<BannerEntity>? onTap;

  @override
  State<StatefulWidget> createState() => _BannerState();
}

class _BannerState extends State<BannerWidget> {
  int _currIndex = 0;
  late Timer _timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    // Log.i("_timer initState");
    // _timer = Timer.periodic(const Duration(seconds: 3), (t) {
    //   controller.nextPage(
    //       duration: const Duration(milliseconds: 200), curve: Curves.ease);
    //   // Log.i("_timer ${controller.position}");
    // });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [_buildPageView(widget._images), _createIndicator()],
    );
  }

  Widget _createIndicator() {
    List<Widget> children = [];
    for (int i = 0; i < widget._images.length; i++) {
      Color color = i == _currIndex ? Colors.amberAccent : Colors.white;
      children.add(Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(45)),
        margin: const EdgeInsets.only(right: 4, bottom: 20),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: children,
    );
  }

  _onPageChanged(int index) {
    // Log.i("_onPageChanged $index");
    setState(() {});
  }

  int _calculateImgIndex(int index, List<BannerEntity> images) {
    int realIndex = index % (images.length);
    _currIndex = realIndex;
    return realIndex;
  }

  Widget _buildPageView(List<BannerEntity> images) {
    return Container(
      height: widget.height,
      child: PageView.builder(
          controller: controller,
          itemCount: 10000,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("点击图片"), duration: Duration(seconds: 2)));
              },
              child: Image.network(
                images[_calculateImgIndex(index, images)].imageUrl,
                fit: BoxFit.cover,
              ),
              // child: Container(
              //
              // ),
            );
          }),
    );
  }
}
