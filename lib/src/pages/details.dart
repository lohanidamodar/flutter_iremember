import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_remember/src/models/item_model.dart';

class DetailsPage extends StatelessWidget {
  final ItemModel item;

  DetailsPage({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        elevation: 0,
      ),
      body: Image.file(File(item.image)),
    );
  }

}