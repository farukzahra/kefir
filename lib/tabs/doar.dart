import 'package:flutter/material.dart';
import 'package:kefir/utils/utils.dart';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

class Doar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<TextSpan>>(
      future: _getData(context), // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<TextSpan>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: new SizedBox(
                height: 50.0,
                width: 50.0,
                child: new CircularProgressIndicator(
                  value: null,
                  strokeWidth: 7.0,
                ),
              ),
            );
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new RichText(
                  text: new TextSpan(
                    children: snapshot.data,
                  ),
                ),
              );
        }
      },
    );
  }

  Future<List<TextSpan>> _getData(BuildContext context) async {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;

    final TextStyle linkStyle =
        themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    var urls = new List<TextSpan>();
    urls.add(new TextSpan(
        style: aboutTextStyle, text: 'Grupos para doação de Kefir\n\n'));

    await http
        .get('https://kefir-1e0d8.firebaseio.com/grupos-kefir.json')
        .then((http.Response response) {
      print(response.body);
      final List<dynamic> grupoListData = json.decode(response.body);
      grupoListData.forEach((dynamic grupoData) {
        urls.add(LinkTextSpan(
            style: linkStyle,
            url: grupoData['url'],
            text: grupoData['descricao'] + '\n\n'));
      });
    });
    urls.add(new TextSpan(
        style: aboutTextStyle,
        text:
            'Para divulgar seu grupo envie um email para farukz@gmail.com\n\n'));
    return urls;
  }
}
