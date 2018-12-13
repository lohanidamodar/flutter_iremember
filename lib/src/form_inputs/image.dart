import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _ImageInputState();
    }
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text('Pick an Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Use Camera'),
                onTap: ()=>getImage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Use Gallery'),
                onTap: ()=>getImage(ImageSource.gallery),
              )
            ],
          ),
        );
      }
    );
  }

  Future getImage(ImageSource source) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200
          ),
          child: _image == null
              ? new Text('No image selected.')
              : new Image.file(_image),
        ),
        OutlineButton.icon(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor
          ),
          icon: Icon(Icons.add_a_photo),
          label: Text('Add Image'),
          onPressed: () => _openImagePicker(context),
        )
      ],
    );
  }
}