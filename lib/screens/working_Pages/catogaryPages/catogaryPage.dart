import 'package:_save_karo/db/catogary/catogrydb.dart';
import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:_save_karo/screens/working_Pages/catogaryPages/incomeCatogarylist.dart';
import 'package:flutter/material.dart';

import 'ExpenseCatogarylist.dart';
import 'editCatogry.dart';

class CatogaryPage extends StatefulWidget {
  const CatogaryPage({Key? key}) : super(key: key);

  @override
  State<CatogaryPage> createState() => _CatogaryPageState();
}

class _CatogaryPageState extends State<CatogaryPage>
    with TickerProviderStateMixin {
  final _type1 = CatogaryType.icome;
  final _type2 = CatogaryType.expence;

  // List<String> items = ['Monthly', 'Yearly', 'period'];
  // String? selectedItem = "Monthly";

  @override
  void initState() {
    CatogaryDB().refreshUi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (tabController.index == 0) {
                openDailoge(
                  context,
                  _type1,
                );
              } else {
                openDailoge(context, _type2);
              }
            },
            backgroundColor: backroundColure,
            child: const Icon(Icons.add)),
        body: Column(
          children: [
            Container(
                height: 60,
                width: 400,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: Color.fromRGBO(0, 0, 0, 70))),
                    color: backroundColure),
                child: const Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      "Category Window",
                      style: TextStyle(
                          fontFamily: fontFamilyCustome,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: fontcolure),
                    ),
                  ),
                )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: backroundUnselectedColur,
                      borderRadius: BorderRadius.circular(12)),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: backroundColure,
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                    labelColor: backroundUnselectedColur,
                    unselectedLabelColor: fontcolure,
                    tabs: const [
                      Tab(
                        child: Text(
                          "INCOME",
                          style: TextStyle(fontFamily: fontFamilyCustome),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "EXPENSE",
                          style: TextStyle(fontFamily: fontFamilyCustome),
                        ),
                      )
                    ],
                    controller: tabController,
                  ),
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [
                  IncomeCatogryWidget(),
                  ExpenseCatogryList()
                ])),
          ],
        ),
      ),
    );
  }
}
