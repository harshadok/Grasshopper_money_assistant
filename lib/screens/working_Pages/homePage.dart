// ignore_for_file: prefer_const_construct

import 'package:_save_karo/db/catogary/catogrydb.dart';
import 'package:_save_karo/db/transcation/transactoin_db.dart';
import 'package:_save_karo/screens/extra_Pages/notification.dart';
import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:_save_karo/screens/working_Pages/catogaryPages/catogaryPage.dart';
import 'package:_save_karo/screens/working_Pages/cattogary/statistcsPage.dart';
import 'package:flutter/material.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'settingsPage.dart';
import 'transactionP_age.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _curretnindex = 0;
  @override
  void initState() {
    tz.initializeTimeZones();
    showNotification();
    super.initState();
  }

  Future<void> showNotification() async {
    String balace = TranscationDb.instance.balanceNotifier.value.toString();
    String income = TranscationDb.instance.incomeNotifier.value.toString();
    String expanec = TranscationDb.instance.expanceNotifier.value.toString();
    await NotificationService().showNotification(
      1,
      "GrassShopper : Will Bring Wealth",
      "Don't Forget To Add Your Transaction",
      3,
    );
    await NotificationService().showNotification(
      2,
      "💰 Your Total Balance: $balace 💰",
      "🔼 Income : $income   🔽 Expance : $expanec",
      3,
    );
  }

  final _page = [
    const TransactionPage(),
    const StatisticsPage(),
    const CatogaryPage(),
    const SettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    CatogaryDB.instance.refreshUi();
    return Scaffold(
      body: _page[_curretnindex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: const BoxDecoration(
            color: backroundColure,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: BottomNavigationBar(
              currentIndex: _curretnindex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: backroundColure,
              selectedFontSize: 14,
              unselectedFontSize: 12,
              selectedLabelStyle:
                  const TextStyle(fontFamily: fontFamilyCustome),
              selectedItemColor: Colors.black,
              unselectedItemColor: commonIconColure,
              onTap: (newIndex) {
                setState(() {
                  _curretnindex = newIndex;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_rounded),
                  label: "Transaction",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart),
                  label: "Statistics",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: "Category"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ]),
        ),
      ),
    );
  }
}
