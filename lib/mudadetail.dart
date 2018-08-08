import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MudaDetail extends StatefulWidget {
  final String _muda;

  MudaDetail(this._muda);

  @override
  _MudaDetailState createState() => _MudaDetailState(_muda);
}

class _MudaDetailState extends State<MudaDetail> {
  String _muda;
  List<String> _values = [];

  _MudaDetailState(this._muda);

  Future<List<String>> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _values = prefs.getStringList(_muda);
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
          return new Scaffold(
              backgroundColor: Colors.white,
              appBar: new AppBar(
                title: const Text('Minhas Mudas'),
              ),
              floatingActionButton: new FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: new Icon(Icons.add),
              ),
              body: new ListView.builder(
                itemCount: _values != null ? _values.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return new Column(
                    children: <Widget>[
                      ListTile(
                        title: new Text(_values[index]),
                        trailing: _buildDeleteButton(context, _values[index]),
                      ),
                      new Divider(
                        height: 2.0,
                      ),
                    ],
                  );
                },
              ));
        });
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy HH:mm');
    setState(() {
      _values.add(formatter.format(now));
    });
    prefs.setStringList(_muda, _values);
  }

  Widget _buildDeleteButton(BuildContext context, String registro) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        _deletaRegistro(registro);
      },
    );
  }

  void _deletaRegistro(String registro) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _values.remove(registro);
    });
    prefs.setStringList(_muda, _values);
  }
}
