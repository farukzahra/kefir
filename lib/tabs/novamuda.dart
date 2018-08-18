import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kefir/model_provider.dart';
import 'package:kefir/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovaMuda extends StatefulWidget {
  PageController tabController;

  NovaMuda(this.tabController);

  @override
  _NovaMudaState createState() => _NovaMudaState();
}

class _NovaMudaState extends State<NovaMuda> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nomeController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome da Muda'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nome é obrigatório!';
                      }
                    },
                    controller: nomeController,
                  ),
                  SizedBox(height: 20.0),
                  FMZIconButton(_criaMuda, Icons.save,
                      Theme.of(context).accentColor, 'Criar'),
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }

  _criaMuda() async {
    if (_formKey.currentState.validate()) {
      var nome = nomeController.text;
      ModelProvider.of(context).createKefirCommand(nome);
      FocusScope.of(context).requestFocus(new FocusNode());
      widget.tabController.jumpTo(0.0);
    }
  }
}
