import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kefir/tabs/mudadetail.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MinhasMudas extends StatefulWidget {
  @override
  _MinhasMudasState createState() => _MinhasMudasState();
}

class _MinhasMudasState extends State<MinhasMudas> {
  Future<List<String>> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _values = prefs.getStringList("listaGeral");
    if (_values == null) {
      _values = new List<String>();
    }
    return _values;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<String> _values = snapshot.data;
        return new ListView.builder(
          itemCount: _values != null ? _values.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                ListTile(
                  title: new Text(_values[index]),
                  //trailing: _buildSearchButton(context, _values[index]),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new MudaDetail(_values[index])));
                  },
                ),
                new Divider(
                  height: 2.0,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSearchButton(BuildContext context, String muda) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new MudaDetail(muda)));
      },
    );
  }
}
