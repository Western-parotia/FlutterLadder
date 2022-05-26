import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              Container(
                child: const Text("我的"),
              )
            ],
            backgroundColor: Colors.deepOrange,
            expandedHeight: 200 + MediaQuery.of(context).padding.top,
            pinned: true,
            flexibleSpace: Container(
              color: Colors.amber,
            ),
          ),
          _MenusWidget()
        ],
      ),
    );
  }
}

class _MenusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
        delegate: SliverChildListDelegate(_menus()),
      ),
    );
  }

  List<Widget> _menus(){
    var iconColor = Colors.red;

    final lws = <Widget>[];
    for(int i = 0;i<100;i++){
      lws.add(ListTile(
        title: Text("title:$i"),
        onTap: ()=>{

        },
        leading: Icon(
          Icons.settings,
          color: iconColor,
        ),
        trailing: const Icon(Icons.chevron_right),
      ));
    }
    return lws;
  }
}

