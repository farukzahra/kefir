import 'package:flutter/material.dart';
import 'package:kefir/drawer.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: const Text('Sobre'),
        ),
        drawer: buildDrawer(context),
        body: new Center(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'images/kefir_logo.png',
              width: 341.0,
              height: 133.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            new Text('Para mais informações acesse',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15.0,
            ),
            //new Text('www.eternify.com.br'),
          ],
        )));
  }
}
