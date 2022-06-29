// ignore: file_names
import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:flutter/material.dart';

import '../../../db/catogary/catogrydb.dart';

Future openDailoge(context, type) async {
  final nameEditingControler = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add  Catogery"),
          content: TextField(
            controller: nameEditingControler,
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter Catogery"),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  final namecheck = nameEditingControler.text;
                  if (namecheck.isEmpty) {
                    return;
                  }
                  final typeLocal = type;
                  final catogryModel = CatogeryModel(
                      name: namecheck,
                      type: typeLocal,
                      id: DateTime.now().microsecondsSinceEpoch.toString());
                  CatogaryDB().insertCatogry(catogryModel);

                  Navigator.of(context).pop();
                },
                child: const Text("Submited"))
          ],
        );
      });
}
