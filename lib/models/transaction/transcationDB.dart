import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:hive_flutter/adapters.dart';
part 'transcationDB.g.dart';

@HiveType(typeId: 3)
class TranscationModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CatogaryType type;
  @HiveField(4)
  final CatogeryModel catogaryModel;
  @HiveField(5)
  final String id;

  // ignore: prefer_typing_uninitialized_variables
  var catogaryName;

  TranscationModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.catogaryModel,
      required this.id});
}


  //  {
  //   id = DateTime.now().microsecondsSinceEpoch.toString();
  // }

