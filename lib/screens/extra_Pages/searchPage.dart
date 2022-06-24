import 'package:_save_karo/db/transcation/transactoin_db.dart';
import 'package:_save_karo/models/transaction/transcationDB.dart';
import 'package:flutter/material.dart';

import 'editAndDeleteTransactionPage.dart';

class SerchClass extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TranscationDb.instance.transcationListNotifier,
      builder: (BuildContext ctx, List<TranscationModel> studentList,
          Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            if (query.toLowerCase() == data.catogaryModel.name.toLowerCase()) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditAndDelet(
                                  dats: data,
                                )));
                  },
                  title: Text(
                    data.catogaryModel.name,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (ctx, index) {
            return Container();
          },
          itemCount: studentList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TranscationDb.instance.transcationListNotifier,
      builder: (BuildContext ctx, List<TranscationModel> studentList,
          Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            if (query == data.catogaryModel.name[0].toLowerCase() ||
                query == data.catogaryModel.name[0].toUpperCase()) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditAndDelet(
                                  dats: data,
                                )));
                  },
                  title: Text(
                    data.catogaryModel.name,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (ctx, index) {
            return Container();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}
