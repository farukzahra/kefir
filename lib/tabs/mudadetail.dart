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

  DateFormat _formatter = DateFormat('dd/MM/yyyy HH:mm');

  Future<List<String>> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _values = prefs.getStringList(_muda);
    if (_values == null) {
      _values = List<String>();
    }
    _ordenaLista();
    return _values;
  }

  _ordenaLista() {
    _values.sort((a, b) {
      DateTime adata = _formatter.parse(a);
      DateTime bdata = _formatter.parse(b);
      return bdata.compareTo(adata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Registrar Troca'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              body: new Column(children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _removerMuda();
                  },
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.delete),
                      Text("Remover esta muda")
                    ],
                  ),
                ),
                new Expanded(
                  child: new Container(height: 200.0, child: _buildListView()),
                ),
              ]));
        });
  }

  void _removerMuda() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _values = prefs.getStringList("listaGeral");

    _values.remove(_muda);

    prefs.setStringList("listaGeral", _values);

    Navigator.of(context).pushReplacementNamed('/MinhasMudas');
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _values != null ? _values.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(_values[index]),
              trailing: _buildDeleteButton(context, _values[index]),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var now = DateTime.now();
    setState(() {
      _values.add(_formatter.format(now));
      _ordenaLista();
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
      _ordenaLista();
    });
    prefs.setStringList(_muda, _values);
  }
}
