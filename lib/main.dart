import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kefir/home.dart';
import 'dart:async';

import './screens/about.dart' as _aboutPage;
import './screens/support.dart' as _supportPage;

void main() => runApp(new MaterialApp(
        title: 'Kefir - Compartilhe',
        theme: new ThemeData(
            primarySwatch: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.blueGrey,
            backgroundColor: Colors.white),
        home: new SplashScreen(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/about':
              return new FromRightToLeft(
                builder: (_) => new _aboutPage.About(),
                settings: settings,
              );
            case '/support':
              return new FromRightToLeft(
                builder: (_) => new _supportPage.Support(),
                settings: settings,
              );
          }
        },
        routes: <String, WidgetBuilder>{
          '/tabs': (BuildContext context) => new Tabs(),
        }));

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 25.0,
          )
        ]),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(new CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      )),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/tabs');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Image.asset('images/kefir_logo.png'),
      ),
    );
  }
}
