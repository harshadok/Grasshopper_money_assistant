import 'package:hive_flutter/adapters.dart';
part 'categoryModel.g.dart';

@HiveType(typeId: 2)
enum CatogaryType {
  @HiveField(1)
  icome,
  @HiveField(2)
  expence;
}

@HiveType(typeId: 1)
class CatogeryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CatogaryType type;

  CatogeryModel(
      {required this.id,
      required this.name,
      this.isDeleted = false,
      required this.type});
}
