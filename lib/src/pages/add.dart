import 'package:flutter/material.dart';
import 'package:i_remember/src/form_inputs/image.dart';

class AddPage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Remember my..'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(),
              ImageInput()
            ],
          ),
        ),
      );
    }
}