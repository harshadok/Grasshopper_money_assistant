// ignore_for_file: non_constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

// ignore: constant_identifier_names
const CATOGARY_DB_NAME = 'Catogary_db';

abstract class CatogerydbFunctions {
  Future<List<CatogeryModel>> getCatogaries();
  Future<void> insertCatogry(CatogeryModel value);
  Future<void> deletCatogry(String catogaryID);
  //Future<void> editCatogry(CatogeryModel value , index);
}

class CatogaryDB implements CatogerydbFunctions {
  CatogaryDB.internal();
  static CatogaryDB instance = CatogaryDB.internal();

  factory CatogaryDB() {
    return instance;
  }

  ValueNotifier<List<CatogeryModel>> incomeCatogaryList = ValueNotifier([]);
  ValueNotifier<List<CatogeryModel>> expenseCatogaryList = ValueNotifier([]);
  @override
  Future<void> insertCatogry(CatogeryModel value) async {
    // ignore:
    final CatogryDB = await Hive.openBox<CatogeryModel>(CATOGARY_DB_NAME);
    await CatogryDB.put(value.id, value);
    refreshUi();
  }

  @override
  Future<List<CatogeryModel>> getCatogaries() async {
    final CatogryDB = await Hive.openBox<CatogeryModel>(CATOGARY_DB_NAME);
    return CatogryDB.values.toList();
  }

  Future<void> refreshUi() async {
    final allCatogerys = await getCatogaries();
    incomeCatogaryList.value.clear();
    expenseCatogaryList.value.clear();
    await Future.forEach(allCatogerys, (CatogeryModel catogary) {
      if (catogary.type == CatogaryType.icome) {
        incomeCatogaryList.value.add(catogary);
      } else {
        expenseCatogaryList.value.add(catogary);
      }
    });
    incomeCatogaryList.notifyListeners();
    expenseCatogaryList.notifyListeners();
  }

  @override
  Future<void> deletCatogry(String catogaryID) async {
    final catogaryDb = await Hive.openBox<CatogeryModel>(CATOGARY_DB_NAME);
    await catogaryDb.delete(catogaryID);
    refreshUi();
  }

  // @override
  // Future<void> editCatogry(CatogeryModel value, int index) async {
  //   final _CatogryDB = await Hive.openBox<CatogeryModel>(CATOGARY_DB_NAME);

  //   await _CatogryDB.putAt( index, value);
  //   refreshUi();
  // }
}
