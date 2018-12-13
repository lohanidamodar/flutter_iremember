import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_remember/src/form_inputs/image.dart';
import 'package:i_remember/src/models/item_model.dart';
import '../blocs/items_bloc.dart';
import '../resources/repository.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() {
    return new _AddPageState();
  }
}

class _AddPageState extends State<AddPage> {
  File _image;
  String _title = '';

  _imagePicked(File image) {
    _image = image;
  }

  _save(BuildContext context) async {
    bloc.itemAdded.listen((bool added) {
      if(added) Navigator.pop(context);
    });
    bloc.addItem(ItemModel(
      title: _title,
      image: _image.path
    ));
  }

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
              TextField(
                onChanged: _titleChanged,
              ),
              ImageInput(onImagePicked: _imagePicked,),
              RaisedButton(child: Text('Save'),onPressed: () => _save(context),)
            ],
          ),
        ),
      );
    }

  void _titleChanged(String value) {
    setState(() {
          _title = value;
        });
  }
}