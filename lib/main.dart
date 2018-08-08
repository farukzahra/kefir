import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kefir/minhasmudas.dart';
import 'package:kefir/novamuda.dart';

import './home.dart';
import './sobre.dart';
  
  


void main() {  

  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new HomeScreen(),
      '/Sobre': (BuildContext context) => new Sobre(),
      '/MinhasMudas': (BuildContext context) => new MinhasMudas(),
      '/NovaMuda': (BuildContext context) => new NovaMuda(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();    
    // prefs.remove('lista');

    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/MinhasMudas');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white ,
      body: new Center(
        child: new Image.asset('images/eternify.png'),
      ),
    );
  }
}
