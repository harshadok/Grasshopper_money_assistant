import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:_save_karo/screens/working_Pages/cattogary/expancePieChart.dart';
import 'package:_save_karo/screens/working_Pages/cattogary/incomePiechart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'overViewCatogary.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with TickerProviderStateMixin {
  List<String> items = ['Monthly', 'Yearly', 'period'];
  DateTime datetime = DateTime.now();

  String? selectedItem = "Monthly";
  select() {
    String? formateDate;

    if (selectedItem == items[0]) {
      formateDate = DateFormat.yMMM().format(datetime);
    } else if (selectedItem == items[1]) {
      formateDate = DateFormat.y().format(datetime);
    }
    return formateDate;
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
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
                  "Statistics Window",
                  style: TextStyle(
                      fontFamily: fontFamilyCustome,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: fontcolure),
                ),
              ),
            )),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                  color: backroundUnselectedColur,
                  borderRadius: BorderRadius.circular(12)),
              child: TabBar(
                labelColor: backroundUnselectedColur,
                unselectedLabelColor: fontcolure,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backroundColure),
                labelPadding: const EdgeInsets.symmetric(horizontal: 15),
                controller: tabController,
                tabs: const [
                  Tab(
                    child: Text(
                      "OVERVIEW",
                      style: TextStyle(fontFamily: fontFamilyCustome),
                    ),
                  ),
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
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(controller: tabController, children: const [
            CatogryOverView(),
            IncomeCatogary(),
            ExapanceCatogary()
          ]),
        ),
      ])),
    );
  }
}
