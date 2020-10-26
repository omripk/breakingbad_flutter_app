import 'package:flutter/material.dart';
import 'package:flutter_app/screens/characterListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Breaking Bad App",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xFF67e6dc),
          accentColor: Color(0xFFeb4d4b),
          secondaryHeaderColor: Color(0xFF222f3e),
          backgroundColor: Colors.tealAccent),
      // Start screen
      home: SeriesCharacters(),
    );
  }
}
