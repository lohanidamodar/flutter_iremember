import '../resources/constants.dart';

class ItemModel {
  final String title;
  final int id;
  final String image;

  ItemModel({
    this.title,
    this.id,
    this.image
  });

  ItemModel.fromMap(Map<String, dynamic> parsedJson) :
        id = parsedJson[columnId],
        title = parsedJson[columnTitle],
        image = parsedJson[columnImage];
        
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map[columnId] = id;
    map[columnTitle] = title;
    map[columnImage] = image;
    return map;
  }

}