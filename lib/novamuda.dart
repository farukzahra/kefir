import 'package:flutter/material.dart';
import 'package:kefir/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovaMuda extends StatefulWidget {
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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nome é obrigatório!';
                      }
                    },
                    controller: nomeController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          _criaMuda(nomeController.text);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            )
          ],
        )));
  }

  _criaMuda(String nome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> lista = [];
    prefs.setStringList(nome, lista);

    List<String> listaGeral = prefs.getStringList("listaGeral");
    if (listaGeral == null) {
      listaGeral = new List<String>();
    }
    listaGeral.add(nome);
    prefs.setStringList("listaGeral", listaGeral);
    Navigator.of(context).pushReplacementNamed('/MinhasMudas');
  }
}
