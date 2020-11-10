import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget createACardForTexts(
    BuildContext context, String header, List<String> texts) {
  return cardGenerator(context, header, texts);
}

Widget createACard(BuildContext context, String header, String text) {
  var texts = new List<String>();
  texts.add(text);
  return cardGenerator(context, header, texts);
}

Widget cardGenerator(BuildContext context, String header, List<String> texts) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
    child: ListTile(
      leading: Text(
        header + ':',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      title: Text(
        // todo: List
        texts.first,
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20.0),
      ),
    ),
  );
}
