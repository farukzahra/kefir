import 'package:flutter/material.dart';
import 'package:kefir/utils/utils.dart';

class Doar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle =
        themeData.textTheme.body2.copyWith(color: themeData.accentColor);

    return new Padding(
      padding: const EdgeInsets.all(24.0),
      child: new RichText(
        text: new TextSpan(

          children: <TextSpan>[
            new TextSpan(
                style: aboutTextStyle,
                text:'Grupos para doação de Kefir\n\n'),
            new LinkTextSpan(
              style: linkStyle,
              url: 'https://www.facebook.com/groups/1159472460759116/about/',
              text: 'Kefir e outros Probióticos \n'
            ),            
          ],
        ),
      ),
    );
  }
}
