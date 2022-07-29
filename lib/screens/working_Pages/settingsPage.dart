// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:_save_karo/db/transcation/transactoin_db.dart';
import 'package:_save_karo/screens/extra_Pages/notification.dart';
import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:flutter/material.dart';
import 'package:load_switch/load_switch.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool value = true;
  Future<bool> _getFuture() async {
    await Future.delayed(const Duration(seconds: 1));
    return !value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      "Settings Page",
                      style: TextStyle(
                          fontFamily: fontFamilyCustome,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: fontcolure),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      const Icon(
                        Icons.notifications_active,
                        color: IconsColure,
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      const Text(
                        "Notification",
                        style: SettingsTextStyle,
                      ),
                      const SizedBox(
                        width: 145,
                      ),
                      LoadSwitch(
                        width: 40.0,
                        height: 20.0,
                        trueColor: IconsColure,
                        falseColor: backroundUnselectedColur,
                        spinColor: const Color.fromRGBO(0, 0, 0, 55),
                        value: value,
                        future: _getFuture,
                        onChange: (v) {
                          value = v;

                          setState(() {});
                        },
                        onTap: (v) {
                          NotificationService().cancellAllNotification();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      showConfrom(context);
                    },
                    child: const ListTile(
                        title: Text(
                          "Reset Everything",
                          style: SettingsTextStyle,
                        ),
                        leading: Icon(
                          Icons.cleaning_services_sharp,
                          color: IconsColure,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      onshare(context);
                    },
                    child: const ListTile(
                        title: Text(
                          "Share",
                          style: SettingsTextStyle,
                        ),
                        leading: Icon(
                          Icons.share,
                          color: IconsColure,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      gottoplaystore();
                    },
                    child: const ListTile(
                        title: Text(
                          "Write A Reveiew",
                          style: SettingsTextStyle,
                        ),
                        leading: Icon(
                          Icons.rate_review_rounded,
                          color: IconsColure,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launcher();
                    },
                    child: const ListTile(
                        title: Text(
                          "FeedBack ",
                          style: SettingsTextStyle,
                        ),
                        leading: Icon(
                          Icons.feedback_rounded,
                          color: IconsColure,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      _gotoweb();
                    },
                    child: const ListTile(
                        title: Text("About Us", style: SettingsTextStyle),
                        leading: Icon(
                          Icons.perm_device_information_rounded,
                          color: IconsColure,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gottoplaystore() async {
    if (await launch(
        'https://play.google.com/store/apps/details?id=com.fouvty.grasshopper')) {
      throw "Try Again";
    }
  }

  submited() {
    {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: backroundColure,
        content: const Text('Reset Completed',
            style: TextStyle(fontSize: 15, fontFamily: fontFamilyCustome)),
        action: SnackBarAction(
          label: 'Ok',
          textColor: backroundUnselectedColur,
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> showConfrom(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!mvaskgit
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Reset Everything',
            style: genaralTextStyle,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text(
                  'Are you sure want to clear all your data',
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
                TranscationDb.instance.deleteall();
                submited();

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

  Future<void> _launcher() async {
    if (await launch('mailto:harshadodakkal@gmail.com')) {
      throw "Try Again";
    }
  }

  Future<void> _gotoweb() async {
    if (await launch('https://harshadok.github.io/myPersonal/')) {
      throw "Try Again";
    }
  }

  Future onshare(con) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      "Grasshopper: Money Assistant \n Click Here To Download The Application :https://play.google.com/store/apps/details?id=com.fouvty.grasshopper",
      subject: "subject",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
//random text deelt at eny time
