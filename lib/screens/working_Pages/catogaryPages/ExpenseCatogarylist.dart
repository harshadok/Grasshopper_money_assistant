import 'package:_save_karo/db/catogary/catogrydb.dart';
import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:flutter/material.dart';

import '../../genaralItems/constentItems.dart';

class ExpenseCatogryList extends StatelessWidget {
  const ExpenseCatogryList({Key? key}) : super(key: key);
  final type = CatogaryType.expence;
  //final _type1 = CatogaryType.icome;
  //final _type2 = CatogaryType.expence;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CatogaryDB().expenseCatogaryList,
        builder: (
          BuildContext context,
          List<CatogeryModel> newList,
          Widget? _,
        ) {
          return newList.isEmpty
              ? const Card(child: Center(child: Text(" No Data")))
              : Column(
                  children: [
                    Expanded(
                      child: Card(
                        color: commonIconColure,
                        child: ListView.separated(
                          itemBuilder: ((context, index) {
                            final catogary = newList[index];
                            return Card(
                              child: ListTile(
                                title: Text(catogary.name),
                                trailing: Wrap(
                                  spacing: 5, // space between two icons
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: () {
                                          showConfrom(context, catogary);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: expenseTextColure,
                                        )),

                                    /// icon-2
                                  ],
                                ),
                              ),
                            );
                          }),
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 20,
                            );
                          },
                          itemCount: newList.length,
                        ),
                      ),
                    ),
                  ],
                );
        });
  }

  Future<void> showConfrom(context, catogary) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete  Catogary',
            style: genaralTextStyle,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                // Text('This is a demo alert dialog.'),
                Text(
                  'Are you sure want to delete this  expense category',
                  style: genaralTextStyle,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Confirm',
                style: TextStyle(
                    color: expenseTextColure, fontFamily: fontFamilyCustome),
              ),
              onPressed: () {
                CatogaryDB.instance.deletCatogry(catogary.id);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: totelTextColure, fontFamily: fontFamilyCustome),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
