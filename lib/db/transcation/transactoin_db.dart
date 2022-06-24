// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:_save_karo/models/transaction/transcationDB.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../catogary/catogrydb.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = "Trasnaction-db";

abstract class TranscationDbFunction {
  Future addTransaction(TranscationModel obj);
  Future<List<TranscationModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
  Future<void> editTransaction(String id, TranscationModel obj);
  Future<void> deleteall();
}

class TranscationDb implements TranscationDbFunction {
  TranscationDb._internal();
  static TranscationDb instance = TranscationDb._internal();
  factory TranscationDb() {
    return instance;
  }

  ValueNotifier<List<TranscationModel>> transcationListNotifier =
      ValueNotifier([]);

  ValueNotifier<List<TranscationModel>> incomeTranscationNotider =
      ValueNotifier([]);

  ValueNotifier<List<TranscationModel>> expanceTranscationNotifier =
      ValueNotifier([]);

  ValueNotifier<List<TranscationModel>> filterListNotification =
      ValueNotifier([]);

  ValueNotifier<List<TranscationModel>> sortpiechartlisener = ValueNotifier([]);
  ValueNotifier<double> balanceNotifier = ValueNotifier(0);
  ValueNotifier<double> incomeNotifier = ValueNotifier(0);
  ValueNotifier<double> expanceNotifier = ValueNotifier(0);

  @override
  Future addTransaction(TranscationModel obj) async {
    final addtrnsactionDb =
        await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
    await addtrnsactionDb.put(obj.id, obj);
  }

  Future<void> refreshUi() async {
    balanceNotifier.value = 0;
    incomeNotifier.value = 0;
    expanceNotifier.value = 0;
    final list = await getAllTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    transcationListNotifier.value.clear();
    incomeTranscationNotider.value.clear();
    expanceTranscationNotifier.value.clear();
    transcationListNotifier.value.addAll(list);
    // ignore: ,

    for (var cataogary in list) {
      if (cataogary.type == CatogaryType.icome) {
        incomeTranscationNotider.value.add(cataogary);
      } else {
        expanceTranscationNotifier.value.add(cataogary);
      }
    }

    await Future.forEach(list, (TranscationModel obj) {
      if (obj.catogaryModel.type == CatogaryType.icome) {
        incomeNotifier.value = incomeNotifier.value + obj.amount;
      } else {
        expanceNotifier.value = expanceNotifier.value + obj.amount;
      }
      balanceNotifier.value = incomeNotifier.value - expanceNotifier.value;
    });

    balanceNotifier.notifyListeners();

    incomeNotifier.notifyListeners();
    expanceNotifier.notifyListeners();

    transcationListNotifier.notifyListeners();
    expanceTranscationNotifier.notifyListeners();
    transcationListNotifier.notifyListeners();
  }

  @override
  Future<List<TranscationModel>> getAllTransactions() async {
    final addDb = await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);

    return addDb.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final deletdb = await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
    await deletdb.delete(id);
    refreshUi();
  }

  @override
  Future<void> editTransaction(String id, TranscationModel obj) async {
    final editTranscation =
        await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
    editTranscation.put(id, obj);
  }

  @override
  Future<void> deleteall() async {
    final deletTransaction =
        await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
    deletTransaction.clear();
    final deleteCatogary = await Hive.openBox<CatogeryModel>(CATOGARY_DB_NAME);
    deleteCatogary.clear();
    refreshUi();

    throw UnimplementedError();
  }
}
