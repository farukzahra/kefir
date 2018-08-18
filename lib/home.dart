import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './tabs/minhasmudas.dart';
import './tabs/novamuda.dart';
import './tabs/doar.dart';

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                child: new Center(
                  child: new FutureBuilder<FirebaseUser>(
                      future: _getUser(),
                      builder: (BuildContext context,
                          AsyncSnapshot<FirebaseUser> snapshot) {
                        return new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        snapshot.data.photoUrl),
                                  ),
                                ),
                              ),
                              new Text(snapshot.data.displayName, textScaleFactor: 1.3),
                              //new Text(snapshot.data.uid, textScaleFactor: 1.3),
                            ]);
                        // return new Image.network(snapshot.data.photoUrl);
                      }),
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
                title: new Text('Logout'),
                onTap: () => signout()),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _getUser() async {
    var user = await _auth.currentUser();
    print(user);
    return user;
  }

  void signout() async {
    await googleSignIn.signOut();
    await facebookSignIn.logOut();
    await FirebaseAuth.instance.signOut();
    print("User Signed out");
    Navigator.pop(context);
    exit(0);
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
