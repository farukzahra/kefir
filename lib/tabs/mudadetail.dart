import 'package:flutter/material.dart';
import 'dart:async';

import 'package:kefir/model/kefir.dart';
import 'package:kefir/model_provider.dart';

import 'package:rx_widgets/rx_widgets.dart';

class MudaDetail extends StatelessWidget {
  final Kefir muda;

  MudaDetail(this.muda);

  //List<String> _values = [];

  //DateFormat _formatter = DateFormat('dd/MM/yyyy HH:mm');

  Future<List<String>> _getData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // _values = prefs.getStringList(muda);
    // if (_values == null) {
    //   _values = List<String>();
    // }
    // _ordenaLista();
    return ["1", "2"];
  }

  _ordenaLista() {
    // _values.sort((a, b) {
    //   DateTime adata = _formatter.parse(a);
    //   DateTime bdata = _formatter.parse(b);
    //   return bdata.compareTo(adata);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Registrar Troca'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addRegistro(context),
          tooltip: 'Registrar',
          child: Icon(Icons.add),
        ),
        body: new Column(children: <Widget>[
          FlatButton(
            onPressed: () {
              _removerMuda(context);
            },
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[Icon(Icons.delete), Text("Remover esta muda")],
            ),
          ),
          new Expanded(
            child:
                new Container(height: 200.0, child: _buildListViewRX(context)),
          ),
        ]));
  }

  void _removerMuda(BuildContext context) async {
    ModelProvider.of(context).removeKefirCommand(muda);
    Navigator.pop(context);
  }

  Widget _buildListViewRX(BuildContext context) {
    ModelProvider.of(context)
        .addRegistroKefirCommand({'kefir': muda, 'listar': true});

    return RxLoader<List<String>>(
      radius: 25.0,
      commandResults: ModelProvider.of(context).addRegistroKefirCommand,
      dataBuilder: (context, data) => _buildListView(context, data),
      placeHolderBuilder: (context) => Center(child: Text("")),
      errorBuilder: (context, ex) =>
          Center(child: Text("Error: ${ex.toString()}")),
    );
  }

  Widget _buildListView(BuildContext context, List<String> data) {
    return ListView.builder(
      itemCount: data != null ? data.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(data[index]),
              trailing: _buildDeleteButton(context, data[index]),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  void _addRegistro(BuildContext context) async {
    ModelProvider.of(context)
        .addRegistroKefirCommand({'kefir': muda, 'listar': false});
  }

  Widget _buildDeleteButton(BuildContext context, String registro) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        _deletaRegistro(context, registro);
      },
    );
  }

  void _deletaRegistro(BuildContext context, String registro) async {
    try {
      ModelProvider.of(context)
          .removeRegistroKefirCommand({'kefir': muda, 'registro': registro});
      ModelProvider.of(context)
          .addRegistroKefirCommand({'kefir': muda, 'listar': true});
    } catch (e) {
      print(e.toString());
    }
  }
}
