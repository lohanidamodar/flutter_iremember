import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_remember/src/models/item_model.dart';
import 'package:i_remember/src/pages/add.dart';
import 'package:i_remember/src/pages/details.dart';
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
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          bloc.fetchItems();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          bloc.search(_filter.text);
        });
      }
    });
  }

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
  
  _openDetailsPage(BuildContext context, ItemModel item) {
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) {
          return DetailsPage(item: item);
        }
      )
    );
  }

  _delete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Are you sure you want to delete?'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: (){
            Navigator.pop(context);
            bloc.deleteItem(id);
          },),
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context),)
        ],
      )
    );
  }

  Widget _buildList(AsyncSnapshot<List> snapshot) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final ItemModel item = ItemModel.fromMap(snapshot.data[index]);
        return Column(
          key: Key(item.id.toString()),
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: CircleAvatar(
              backgroundImage: FileImage(File(item.image)),

              ),
              title: Text(item.title),
              trailing: IconButton(icon: Icon(Icons.delete_forever),onPressed: ()=>_delete(item.id)),
              onTap: () => _openDetailsPage(context, item),
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
          tooltip: 'Remember new item',
          onPressed: (){
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) {
                return AddPage();
              })
            );
          },
          child: Icon(Icons.library_add),
        ),
      );
    }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        title: TextField(
          controller: _filter,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'find my...',
            icon: Icon(Icons.search, color: Colors.black,),

          ),
        ),

      );
  }
}