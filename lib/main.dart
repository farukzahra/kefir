import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kefir/home.dart';
import 'package:kefir/tabs/login.dart';
import 'dart:async';

import './screens/about.dart' as _aboutPage;
import './screens/support.dart' as _supportPage;

import 'package:kefir/model/homepage_model.dart';
import 'package:kefir/model_provider.dart';
import 'package:kefir/service/kefirservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  KefirService _service;
  HomePageModel _model;

  @override
  void initState() {
    super.initState();
    _service = new KefirService();
    _model = new HomePageModel(_service);
  }

  @override
  Widget build(BuildContext context) {
    return new ModelProvider(
      model: _model,
      child: new MaterialApp(
        title: 'Kefir - Compartilhe',
        theme: new ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.green,
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
          '/login': (BuildContext context) => new Login(),
        },
      ),
    );
  }
}

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
  _SplashScreenState createState() => new  _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  startTime() async {
    _user = await _auth.currentUser();
    var _duration = new Duration(seconds: 2);
    if (_user != null) {
      return new Timer(_duration, navigationPageHome);
    } else {
      return new Timer(_duration, navigationPageLogin);
    }
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('/tabs');
  }

  void navigationPageLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
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
