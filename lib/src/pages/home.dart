import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_remember/src/models/item_model.dart';
import 'package:i_remember/src/pages/add.dart';
import '../blocs/items_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({this.title});

  @override
  _HomePageState createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    bloc.fetchItems();
    super.initState();
  }
  
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
  
  Widget _buildList(AsyncSnapshot<List> snapshot) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final ItemModel item = ItemModel.fromMap(snapshot.data[index]);
        return Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: CircleAvatar(
              backgroundImage: FileImage(File(item.image)),

              ),
              title: Text(item.title),
              onTap: (){},
            ),
            Divider()
          ],
        );
      },
      itemCount: snapshot.data.length,
    );
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child:StreamBuilder(
            stream: bloc.items,
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'find my...',
            icon: Icon(Icons.search, color: Theme.of(context).accentColor,),

          ),
        ),
        elevation: 0,

      );
  }
}