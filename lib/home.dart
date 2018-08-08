import 'package:flutter/material.dart';
import 'package:kefir/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Kefir Brasil'),
        ),
        drawer: buildDrawer(context),
        resizeToAvoidBottomPadding: false,
        body: new Text(''));
  }
}
