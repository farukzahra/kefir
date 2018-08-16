import 'package:flutter/material.dart';
import 'package:kefir/model_provider.dart';
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
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          _criaMuda(nomeController.text);
                        }
                      },
                      child: Text('Criar'),
                    ),
                  ),
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }

  _criaMuda(String nome) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // List<String> lista = [];
    // prefs.setStringList(nome, lista);

    // List<String> listaGeral = prefs.getStringList("listaGeral");
    // if (listaGeral == null) {
    //   listaGeral = List<String>();
    // }
    // listaGeral.add(nome);
    // prefs.setStringList("listaGeral", listaGeral);
    //Navigator.of(context).pushReplacementNamed('/MinhasMudas');
    ModelProvider.of(context).createKefirCommand(nome);

    FocusScope.of(context).requestFocus(new FocusNode());
    widget.tabController.jumpTo(0.0);
  }
}
