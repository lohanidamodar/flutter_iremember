import 'package:i_remember/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class ItemsBloc{
  final _repository = Repository();
  final _items = PublishSubject<List>();
  final _item = PublishSubject<ItemModel>();
  final _itemAdded = PublishSubject<bool>();

 //getter the stream
  Observable<List> get items => _items.stream;
  Observable<bool> get itemAdded => _itemAdded.stream;

  Function(ItemModel) get addItem => _item.sink.add;



  fetchItems() async{
    final items = await _repository.fetchItems();
    print(items);
    _items.sink.add(items);
  }

  ItemsBloc() {
    _item.stream.listen( (ItemModel item) async{
     if (await _repository.addItem(item) > 0 ) {
      _itemAdded.sink.add(true);
      fetchItems();
     } else {
      _itemAdded.sink.add(false);
     }
    });
  }

  dispose(){
    _items.close();
    _item.close();
    _itemAdded.close();
  }
}

final bloc = ItemsBloc();