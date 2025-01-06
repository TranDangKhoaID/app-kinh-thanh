import 'dart:async';

import 'package:app_kinh_thanh/models/bible_model.dart';
import 'package:app_kinh_thanh/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<BibleModel> _bibleBox;
  ObjectBox._init(this._store) {
    _bibleBox = Box<BibleModel>(_store);
  }
  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }

  BibleModel? getBible(int id) => _bibleBox.get(id);
  Stream<List<BibleModel>> getBibles() => _bibleBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());
  int insertBible(List<BibleModel> bibles) => _bibleBox.putMany(bibles).length;

  bool deleteInfor(int id) => _bibleBox.remove(id);

  //
  bool isBibleBoxEmpty() {
    return _bibleBox.isEmpty();
  }
}
