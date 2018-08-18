import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: new Image.asset('images/kefir_logo.png'),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Minhas Mudas'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/MinhasMudas');
          },
        ),
        ListTile(
          leading: Icon(Icons.create),
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

class FMZIconButton extends StatelessWidget {
  final Function _onPressed;
  final IconData _icon;
  final Color _color;
  final String _text;

  FMZIconButton(this._onPressed,this._icon, this._color, this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: _color,
        textColor: Colors.white,
        elevation: 4.0,
        splashColor: Colors.blueGrey,
        onPressed: () {
          _onPressed();
        },
        child: Row(
          children: <Widget>[
            Icon(
              _icon,
              size: 18.0,
            ),
            Expanded(
              child: Text(
                _text,
                textAlign: TextAlign.center,
              ),
            ),
            Icon(_icon, size: 18.0, color: _color)
          ],
        ),
      ),
    );
  }
}

class LinkTextSpan extends TextSpan {

  // Beware!
  //
  // This class is only safe because the TapGestureRecognizer is not
  // given a deadline and therefore never allocates any resources.
  //
  // In any other situation -- setting a deadline, using any of the less trivial
  // recognizers, etc -- you would have to manage the gesture recognizer's
  // lifetime and call dispose() when the TextSpan was no longer being rendered.
  //
  // Since TextSpan itself is @immutable, this means that you would have to
  // manage the recognizer from outside the TextSpan, e.g. in the State of a
  // stateful widget that then hands the recognizer to the TextSpan.

  LinkTextSpan({ TextStyle style, String url, String text }) : super(
    style: style,
    text: text ?? url,
    recognizer: new TapGestureRecognizer()..onTap = () {
      launch(url, forceSafariVC: false);
    }
  );
}