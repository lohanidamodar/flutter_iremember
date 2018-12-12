import 'package:flutter/material.dart';
import 'package:i_remember/src/pages/add.dart';

class HomePage extends StatelessWidget {
  final String title;
  HomePage({this.title});

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'find my...',
              icon: Icon(Icons.search, color: Theme.of(context).accentColor,),

            ),
          ),
          elevation: 0,

        ),
        body: SafeArea(
          child:ListView(
            children: <Widget>[
              Text("Example Remembered item")
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) {
                return AddPage();
              })
            );
          },
          child: Icon(Icons.add_a_photo),
        ),
      );
    }
}