import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './tabs/minhasmudas.dart';
import './tabs/novamuda.dart';
import './tabs/doar.dart';

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  
  PageController _tabController;
  MinhasMudas _minhasMudas;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
    _minhasMudas = MinhasMudas();    
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //App Bar
      appBar: new AppBar(
        title: new Text(
          _title_app,
          style: new TextStyle(
            fontSize:
                Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),

      //Content of tabs
      body: new PageView(
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[_minhasMudas, NovaMuda(_tabController), Doar()],
      ),

      //Tabs
      bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS
          ? new CupertinoTabBar(
              activeColor: Colors.blueGrey,
              currentIndex: _tab,
              onTap: onTap,
              items: TabItems.map((TabItem) {
                return new BottomNavigationBarItem(
                  title: new Text(TabItem.title),
                  icon: new Icon(TabItem.icon),
                );
              }).toList(),
            )
          : new BottomNavigationBar(
              currentIndex: _tab,
              onTap: onTap,
              items: TabItems.map((TabItem) {
                return new BottomNavigationBarItem(
                  title: new Text(TabItem.title),
                  icon: new Icon(TabItem.icon),
                );
              }).toList(),
            ),

      //Drawer
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Container(
              height: 120.0,
              child: new DrawerHeader(
                padding: new EdgeInsets.all(0.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: new Center(
                  child: new Image.asset('images/kefir_logo.png'),
                ),
              ),
            ),
            new ListTile(
                leading: new Icon(Icons.chat),
                title: new Text('Sugestões'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/support');
                }),
            new ListTile(
                leading: new Icon(Icons.info),
                title: new Text('Sobre'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/about');
                }),
            new Divider(),
            new ListTile(
                leading: new Icon(Icons.exit_to_app),
                title: new Text('Sair'),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
        break;

      case 1:
        this._title_app = TabItems[1].title;
        break;

      case 2:
        this._title_app = TabItems[2].title;
        break;
    }
  }
}

class TabItem {
  const TabItem({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Minhas Mudas', icon: Icons.list),
  const TabItem(title: 'Nova Muda', icon: Icons.create),
  const TabItem(title: 'Doar', icon: Icons.share)
];
