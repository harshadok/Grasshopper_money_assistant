import 'dart:async';

import 'package:_save_karo/db/transcation/transactoin_db.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../working_Pages/homePage.dart';
import 'introductionPages.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({Key? key}) : super(key: key);

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () async {
      await TranscationDb.instance.refreshUi();
      // ignore: use_build_context_synchronously
      ceckLogin(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TranscationDb.instance.refreshUi();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 350,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: Image.asset(
                    "Assets/images/appstore.png",
                    height: 300,
                    width: 180,
                  ),
                ),
                const Text(
                  "GrssShoper ",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30),
                ),
              ],
            ),
            Row(
              children: const [
                SizedBox(
                  width: 150,
                ),
                Text(
                  "Will Bring Wealth.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(0, 0, 0, 55),
                    fontFamily: "Imprima",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

ceckLogin(BuildContext context) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final checkKeyValue = sharedPreferences.getBool("keyName") ?? false;
  if (checkKeyValue == false) {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const IndroScreen1(),
        ));
  } else {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
