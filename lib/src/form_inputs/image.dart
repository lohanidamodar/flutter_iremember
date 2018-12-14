import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onImagePicked;

  ImageInput({this.onImagePicked});

  @override
    State<StatefulWidget> createState() {
      return _ImageInputState();
    }
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image != null) {
      widget.onImagePicked(image);
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: _image == null
                      ? new SizedBox()
                      : new Image.file(_image),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: RaisedButton(
            padding: EdgeInsets.all(10.0),
            onPressed: _getImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add_a_photo),
                SizedBox(width: 10.0,),
                Text("Add Image", style: TextStyle(fontSize: 18.0),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}