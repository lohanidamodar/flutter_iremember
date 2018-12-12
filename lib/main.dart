import 'package:flutter/material.dart';
import 'package:i_remember/src/pages/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(title: 'iRemember'),
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        title: 'iRemember',
      );
    }
}