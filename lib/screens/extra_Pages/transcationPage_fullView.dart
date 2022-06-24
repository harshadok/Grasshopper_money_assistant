// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../db/transcation/transactoin_db.dart';
import '../../models/catogary/categoryModel.dart';
import '../../models/transaction/transcationDB.dart';
import '../genaralItems/constentItems.dart';
import 'editAndDeleteTransactionPage.dart';

class TransactionViewMore extends StatefulWidget {
  const TransactionViewMore({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionViewMore> createState() => _TransactionViewMoreState();
}

class _TransactionViewMoreState extends State<TransactionViewMore> {
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
    filteFuction();
    initialDate = DateTime.now();
    finalDate = DateTime.now();
    currentDate = dateFormatterFull.format(initialDate);
    lastDate = dateFormatterFull.format(finalDate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filteFuction();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backroundColure,
        title: const Text(
          "Transaction Full View",
          style: TextStyle(
              fontFamily: fontFamilyCustome, color: backroundUnselectedColur),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                popupItem == 'Day'
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: totelTextColure),
                                borderRadius: BorderRadius.circular(5)),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "            Today            ",
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                      )
                    : Row(
                        children: [
                          const SizedBox(
                            width: .01,
                          ),
                          IconButton(
                            splashRadius: 0.01,
                            onPressed: () {
                              setState(
                                () {
                                  if (popupItem == 'Monthly') {
                                    monthYear = DateTime(
                                        monthYear.year, monthYear.month - 1);
                                  } else if (popupItem == 'Yearly') {
                                    monthYear = DateTime(
                                        monthYear.year - 1, monthYear.month);
                                  }
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                            visualDensity: const VisualDensity(horizontal: -4),
                          ),
                          Text(
                            popupItem == 'Monthly'
                                ? dateFormatterMonth.format(monthYear)
                                : popupItem == "Yearly"
                                    ? monthYear.year.toString()
                                    : dateFormatterFull.format(monthYear),
                          ),
                          IconButton(
                              splashRadius: .01,
                              onPressed: () {
                                setState(() {
                                  if (popupItem == "Day") {
                                    DateTime(monthYear.year, monthYear.day + 1);
                                  } else if (popupItem == 'Yearly') {
                                    monthYear = DateTime(
                                        monthYear.year + 1, monthYear.month);
                                  } else if (popupItem == 'Monthly') {
                                    monthYear = DateTime(
                                        monthYear.year, monthYear.month + 1);
                                  }
                                });
                                filteFuction();
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              visualDensity:
                                  const VisualDensity(horizontal: -4)),
                        ],
                      ),
                PopupMenuButton(
                  onSelected: (val) {
                    if (val != null) {
                      if (val == 'Monthly') {
                        monthYear = DateTime.now();
                        popupItem = val.toString();
                        setState(() {});
                      } else if (val == 'Yearly') {
                        monthYear = DateTime.now();
                        popupItem = val.toString();
                        setState(() {});
                      } else if (val == 'Day') {
                        monthYear = DateTime.now();
                        popupItem = val.toString();
                        setState(() {});
                      }
                    }
                  },
                  initialValue: popupItem,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Monthly',
                      child: Text(
                        'Monthly',
                        //  textSize: 14
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Yearly',
                      child: Text(
                        'Yearly',
                        //    textSize: 14
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Day',
                      child: Text('Day'
                          //   textSize: 14
                          ),
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.only(right: 03),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: fontcolure),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(
                            popupItem,
                            //textSize: 14
                          ),
                          const Icon(Icons.keyboard_arrow_down_outlined)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: SizedBox(
                child: ValueListenableBuilder(
                    valueListenable: popupItem == "Monthly"
                        ? filterMonthNotification
                        : popupItem == "Yearly"
                            ? filterYearNotification
                            : filterDayNotification,
                    builder: (BuildContext context,
                        List<TranscationModel> newList, Widget? _) {
                      return Card(
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
                                          builder: (context) => EditAndDelet(
                                                dats: values,
                                              )));
                                },
                                child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        parseDate(values.date),
                                      )
                                    ],
                                  ),
                                  title: Text(values.catogaryModel.name),
                                  subtitle: Text(values.purpose),
                                  trailing: Text.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                      children: [
                                        WidgetSpan(
                                            child: values.type ==
                                                    CatogaryType.icome
                                                ? const Icon(
                                                    Icons.arrow_circle_up,
                                                    color: incomeTextColure,
                                                  )
                                                : const Icon(
                                                    Icons.arrow_circle_down,
                                                    color: expenseTextColure,
                                                  )),
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
                            itemCount: newList.length),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ValueNotifier<List<TranscationModel>> filterMonthNotification =
      ValueNotifier([]);

  ValueNotifier<List<TranscationModel>> filterYearNotification =
      ValueNotifier([]);

  ValueNotifier<List<TranscationModel>> filterDayNotification =
      ValueNotifier([]);

  Future<void> filteFuction() async {
    final list = await TranscationDb.instance.getAllTransactions();
    filterYearNotification.value.clear();
    filterMonthNotification.value.clear();
    filterDayNotification.value.clear();
    await Future.forEach(list, (TranscationModel obj) {
      if (obj.date.day == monthYear.day) {
        filterDayNotification.value.add(obj);
      }
      if (obj.date.year == monthYear.year) {
        filterYearNotification.value.add(obj);
      }
      if (obj.date.month == monthYear.month) {
        filterMonthNotification.value.add(obj);
      }
    });
    filterDayNotification.notifyListeners();
    filterMonthNotification.notifyListeners();
    filterYearNotification.notifyListeners();
  }

  String parseDate(DateTime date) {
    final datesplit = DateFormat.MMMd().format(date);
    final splitDate = datesplit.split(" ");

    return "${splitDate.last}  ${splitDate.first}";
  }
}
