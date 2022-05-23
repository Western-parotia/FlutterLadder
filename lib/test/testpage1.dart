import 'package:flutter/cupertino.dart';

class TestPageViewPage extends StatelessWidget {
  const TestPageViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Container(
      child: PageView.builder(itemBuilder: (context, index) {
        return Center(
          child: Text("Text1"),
        );
      }),
    );
    return PageView(
      controller: controller,
      reverse: true,
      children: const [
        Center(
          child: Text("Text1"),
        ),
        Center(
          child: Text("Text2"),
        ),
        Center(
          child: Text("Text3"),
        ),
      ],
    );
  }
}
