import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget createACard(BuildContext context, String header, List<String> text) {

// }

Widget createACard(BuildContext context, String header, String text) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
    child: ListTile(
      leading: Text(
        header + ':',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      title: Text(
        text,
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20.0),
      ),
    ),
  );
}
