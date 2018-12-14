import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_remember/src/form_inputs/image.dart';
import 'package:i_remember/src/models/item_model.dart';
import '../blocs/items_bloc.dart';

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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => _save(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: _buildTitleField(),
              ),
              ImageInput(onImagePicked: _imagePicked,),
            ],
          ),
        ),
      );
    }

  TextField _buildTitleField() {
    return TextField(
                onChanged: _titleChanged,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 24.0
                  )
                ),
              );
  }

  void _titleChanged(String value) {
    setState(() {
          _title = value;
        });
  }
}