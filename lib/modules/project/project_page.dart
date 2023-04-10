import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 240,
              pinned: false,
              flexibleSpace: _HeaderWidget()),
          SliverList(
            delegate: SliverChildListDelegate(_menus()),
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.yellow,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('用户名')
          ],
        ),
      ),
    );
  }
}

List<Widget> _menus() {
  final lws = <Widget>[];
  for (int i = 0; i < 5; i++) {
    lws.add(Container(height: 50, child: const Text('test')));
  }
  return lws;
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // (1)根据坐标点绘制,size包含了子组件宽高
    // (2)若不是被贝塞尔曲线，依次直线相连lineTo设置的坐标路径剪裁
    // (3)若使用了贝塞尔曲线，则贝塞尔曲线的首尾点的前后的点先连也是贝塞尔曲线
    // 贝塞尔绘制弧线
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);
    // 贝塞尔曲线的两个坐标，根据高低通过弧线相连
    var firstPoint = Offset(size.width / 2, size.height + 10);
    var endPoint = Offset(size.width, size.height - 50);
    // 绘制贝塞尔曲线
    path.quadraticBezierTo(
        firstPoint.dx, firstPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    /*
    // 贝塞尔绘制波浪线
    path.lineTo(0,0);
    path.lineTo(0,size.height-40);
    // 波浪线需要四个贝塞尔坐标，分别在1/4、1/2.25，3/4，1处设置，会根据高低弧线相连
    var firstPoint=Offset(size.width/4,size.height);
    var secondPoint=Offset(size.width/2.25,size.height-30);
    path.quadraticBezierTo(firstPoint.dx, firstPoint.dy, secondPoint.dx, secondPoint.dy);
    var thirdPoint = Offset(size.width / 4 * 3, size.height - 90);
    var fourthPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
        thirdPoint.dx, thirdPoint.dy, fourthPoint.dx, fourthPoint.dy);
    path.lineTo(size.width, 0);
    * */
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
