
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class HDWebViewPage extends StatefulWidget {
    String url = "";
    String title = "";
    bool isLocalUrl = false;
    HDWebViewPage({required String url,required String title,required bool isLocalUrl}) {
      this.url = url;
      this.title = title;
      this.isLocalUrl = isLocalUrl;
    }
    @override
   State <StatefulWidget> createState() => HDWebViewPageState();
}
class HDWebViewPageState extends State<HDWebViewPage> {
  late WebViewController _webViewController ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(elevation: 0,backgroundColor: Color(0xccd0d7),
          title: Text(widget.title, style: TextStyle(color: Colors.black),),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Color(0xFF23ADE5),),
          onPressed: () {
              Navigator.pop(context);
          })),
      body: getH5Body(),
    );
  }
  // 获取H5页面内容
  Widget getH5Body(){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 1,
          width: double.infinity,
          child: const DecoratedBox(decoration: BoxDecoration(color: Color(0xFFEEEEEE))),
        ),
        Expanded(
          flex: 1,
          child: WebView(
            initialUrl: widget.url,
            onWebViewCreated: (WebViewController controller){
              _webViewController = controller;
              controller.loadUrl(widget.url);
              controller.canGoBack().then((value) => debugPrint(value.toString()));
              controller.canGoForward().then((value) => debugPrint(value.toString()));
              controller.currentUrl().then((value) => debugPrint(value));
            },
            onPageFinished: (String value){
              _webViewController.evaluateJavascript('document.title')
                  .then((title) => debugPrint(title));
            },
          ),
        )
      ],
    );
  }
}