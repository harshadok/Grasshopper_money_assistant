// ignore_for_file: prefer_const_constructors

import 'package:_save_karo/db/transcation/transactoin_db.dart';
import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:_save_karo/models/transaction/transcationDB.dart';
import 'package:_save_karo/screens/extra_Pages/addTransactionPage.dart';
import 'package:_save_karo/screens/extra_Pages/searchPage.dart';
import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../extra_Pages/editAndDeleteTransactionPage.dart';
import '../extra_Pages/transcationPage_fullView.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? income;
  DateTime monthYear = DateTime.now();
  String? currentDate;
  String? lastDate;
  late DateTime finalDate;
  late DateTime initialDate;
  String popupItem = 'Monthly';
  bool isVisible = true;

  @override
  void initState() {
    initialDate = DateTime.now();
    finalDate = DateTime.now();
    currentDate = dateFormatterFull.format(initialDate);
    lastDate = dateFormatterFull.format(finalDate);
    super.initState();
    // tz.initializeTimeZones();
    // NotificationService().showNotification(2, '', " INCOME : $income ", 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: Color.fromARGB(255, 178, 221, 157),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  height: 60,
                  width: 400,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 70))),
                      color: backroundColure),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: const Text(
                        "Transaction Window",
                        style: TextStyle(
                            fontFamily: fontFamilyCustome,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: fontcolure),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          elevation: 5,
                          child: IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: SerchClass());

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             SerchClass()));
                            },
                            icon: const Icon(
                              Icons.search,
                              color: totelTextColure,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              Padding(padding: EdgeInsets.all(8.0)),
              ValueListenableBuilder(
                valueListenable: TranscationDb.instance.balanceNotifier,
                builder: (BuildContext context, double value, Widget? child) {
                  return Column(
                    children: [
                      const Text(
                        "TOTAL BALANCE",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamilyCustome),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '₹ ${value > 0 ? value.toString() : 0.00.toString()}',
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "INCOME",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamilyCustome),
                    ),
                    Text(
                      "EXPENSE",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamilyCustome),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: TranscationDb.instance.incomeNotifier,
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                            children: [
                              WidgetSpan(
                                child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: backroundColure,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: const Icon(
                                      Icons.arrow_upward,
                                      color: incomeTextColure,
                                    )),
                              ),
                              TextSpan(
                                  text: ' ₹ $value',
                                  style: const TextStyle(
                                      color: incomeTextColure, fontSize: 20))
                            ],
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: TranscationDb.instance.expanceNotifier,
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                            children: [
                              WidgetSpan(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: backroundColure,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    padding: const EdgeInsets.all(2),
                                    child: const Icon(
                                      Icons.arrow_downward,
                                      color: expenseTextColure,
                                    )),
                              ),
                              TextSpan(
                                  text: ' ₹ $value',
                                  style: const TextStyle(
                                      color: expenseTextColure, fontSize: 20))
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: backroundColure)),
                    ),
                    height: 25,
                    child: const Text(
                      "Recent transactions",
                      style: genaralTextStyle,
                    )),
                trailing: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: backroundColure)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TransactionViewMore()));
                    },
                    child: const Text(
                      "See more",
                      style: TextStyle(
                          color: fontcolure,
                          fontSize: 12,
                          fontFamily: fontFamilyCustome),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: ValueListenableBuilder(
                      valueListenable:
                          TranscationDb.instance.transcationListNotifier,
                      builder: (BuildContext context,
                          List<TranscationModel> newList, Widget? _) {
                        return newList.isEmpty
                            ? const Text("No Transaction  ")
                            : Card(
                                elevation: 5,
                                color: commonIconColure,
                                child: ListView.separated(
                                  itemBuilder: ((context, index) {
                                    final values = newList[index];
                                    //edit transcation
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditAndDelet(
                                                      //keey: index,
                                                      dats: values,
                                                    )));
                                      },
                                      child: ListTile(
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              parseDate(values.date),
                                            )
                                          ],
                                        ),

                                        title: Center(
                                            child: Text(
                                          values.catogaryModel.name,
                                          style: genaralTextStyle,
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                          values.purpose,
                                          style: genaralTextStyle,
                                        )),
                                        //leading: ,
                                        trailing: Text.rich(
                                          TextSpan(
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '  ₹ ${values.amount}',
                                                style: TextStyle(
                                                    color: values.type ==
                                                            CatogaryType.icome
                                                        ? incomeTextColure
                                                        : expenseTextColure),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  separatorBuilder: (context, index) {
                                    return const Card(
                                      elevation: 6,
                                      color: backroundColure,
                                      child: SizedBox(
                                        height: 3,
                                      ),
                                    );
                                  },
                                  itemCount:
                                      newList.length <= 4 ? newList.length : 4,
                                ),
                              );
                      }),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TranscationPageAdd()));
            },
            backgroundColor: backroundColure,
            child: const Icon(
              Icons.add,
              color: backroundUnselectedColur,
            )));
  }

  String parseDate(DateTime date) {
    final datesplit = DateFormat.MMMd().format(date);
    final splitDate = datesplit.split(" ");

    return "${splitDate.last}  ${splitDate.first}";
  }
}
