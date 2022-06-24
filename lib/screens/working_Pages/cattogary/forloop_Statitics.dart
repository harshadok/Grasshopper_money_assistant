import 'package:_save_karo/models/transaction/transcationDB.dart';

class ChartData {
  String? catogaryName;
  double? amount;

  ChartData({required this.catogaryName, required this.amount});
}

chartLogic(List<TranscationModel> model) {
  String catogaryNamee;
  double value;
  List visited = [];
  List<ChartData> newdatas = [];

  for (var i = 0; i < model.length; i++) {
    visited.add(0);
  }
  for (var i = 0; i < model.length; i++) {
    value = model[i].amount;
    catogaryNamee = model[i].catogaryModel.name;

    for (var j = i + 1; j < model.length; j++) {
      if (model[i].catogaryModel.name == model[j].catogaryModel.name) {
        value += model[j].amount;
        visited[j] = -1;
      }
    }

    if (visited[i] != -1) {
      newdatas.add(ChartData(catogaryName: catogaryNamee, amount: value));
    }
  }

  return newdatas;
}
