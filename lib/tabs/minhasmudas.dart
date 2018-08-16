import 'package:flutter/material.dart';
import 'package:kefir/model/kefir.dart';
import 'package:kefir/tabs/mudadetail.dart';

import 'package:kefir/model_provider.dart';
import 'package:rx_widgets/rx_widgets.dart';

class MinhasMudas extends StatefulWidget {
  @override
  _MinhasMudasState createState() => _MinhasMudasState();
}

class _MinhasMudasState extends State<MinhasMudas> {
  @override
  Widget build(BuildContext context) {
    ModelProvider.of(context).createKefirCommand('');

    return RxLoader<List<Kefir>>(
      radius: 25.0,
      commandResults: ModelProvider.of(context).createKefirCommand,
      dataBuilder: (context, data) => _buildListView(context, data),
      placeHolderBuilder: (context) => Center(child: Text("")),
      errorBuilder: (context, ex) =>
          Center(child: Text("Error: ${ex.toString()}")),
    );
  }

  Widget _buildListView(BuildContext context, List<Kefir> data) {
    return new ListView.builder(
      itemCount: data != null ? data.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            ListTile(
              title: new Text(data[index].nome),
              trailing: _buildDeleteButton(data[index]),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new MudaDetail(data[index])));
              },
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeleteButton(Kefir kefir) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        ModelProvider.of(context).removeKefirCommand(kefir);
        ModelProvider.of(context).createKefirCommand('');
      },
    );
  }
}
