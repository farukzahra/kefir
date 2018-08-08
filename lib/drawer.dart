import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: new Image.asset('images/eternify.png'),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Minhas Mudas'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/MinhasMudas');
          },
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Nova Muda'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/NovaMuda');
          },
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('Sobre'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/Sobre');
          },
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Limpar Histórico'),
          onTap: () {
            _limparHistorico(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Sair'),
          onTap: () {
            exit(0);
          },
        )
      ],
    ),
  );
}

_limparHistorico(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> listaGeral = prefs.getStringList("listaGeral");

  listaGeral.forEach((l){
      prefs.remove(l);
  });

  prefs.remove('listaGeral');
  Navigator.pop(context);
  Navigator.of(context).pushReplacementNamed('/HomeScreen');
}
