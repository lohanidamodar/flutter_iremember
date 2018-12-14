import 'dart:async';
import 'db_provider.dart';
import '../models/item_model.dart';

class Repository {
  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    item = await DbProvider().fetchItem(id);
    return item;
  }

  Future<List> fetchItems() async {
    return await DbProvider().fetchItems();
  }

  Future<List> searchItems(String term) async {
    return await DbProvider().searchItems(term);
  }

  Future<int> addItem(ItemModel item) async {
    return await DbProvider().addItem(item);
  }
}