// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:_save_karo/models/transaction/transcationDB.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../db/transcation/transactoin_db.dart';
import '../../genaralItems/constentItems.dart';
import 'forloop_Statitics.dart';

class CatogryOverView extends StatefulWidget {
  const CatogryOverView({Key? key}) : super(key: key);

  @override
  State<CatogryOverView> createState() => _CatogryOverViewState();
}

class _CatogryOverViewState extends State<CatogryOverView> {
  late TooltipBehavior _tooltipBehavior;
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
    _tooltipBehavior = TooltipBehavior(enable: true);
    initialDate = DateTime.now();
    finalDate = DateTime.now();
    currentDate = dateFormatterFull.format(initialDate);
    lastDate = dateFormatterFull.format(finalDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filteFuction();

    List<ChartData> dataIncome;
    popupItem == "Monthly"
        ? dataIncome = chartLogic(filterMonthNotification.value)
        : popupItem == "Yearly"
            ? dataIncome = chartLogic(filterYearNotification.value)
            : dataIncome = chartLogic(filterDayNotification.value);
    filteFuction();

    return ValueListenableBuilder(
        valueListenable: TranscationDb.instance.balanceNotifier,
        builder: (BuildContext context, double value, Widget? child) {
          return Column(children: [
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
                                    DateTime(monthYear.year, monthYear.day - 1);
                                  }
                                },
                              );
                              filteFuction();
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
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Yearly',
                      child: Text(
                        'Yearly',
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Day',
                      child: Text('Day'),
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
                          ),
                          const Icon(Icons.keyboard_arrow_down_outlined)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SfCircularChart(
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                    dataSource: dataIncome,
                    xValueMapper: (ChartData datas, _) => datas.catogaryName,
                    yValueMapper: (ChartData datas, _) => datas.amount),
              ],
            ),
          ]);
        });
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
}
