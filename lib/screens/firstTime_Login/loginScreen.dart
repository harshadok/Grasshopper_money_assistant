import 'package:_save_karo/screens/genaralItems/constentItems.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../working_Pages/homePage.dart';

class LginScreen extends StatelessWidget {
  const LginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Imprima",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Imprima",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                submited(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(217, 217, 217, 23),
                  fixedSize: const Size(400, 50)),
              child: const Text(
                "Sing Up With Google ",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 55),
                  fontFamily: "Imprima",
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                gotoTransaction(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(217, 217, 217, 23),
                  fixedSize: const Size(400, 50)),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 55),
                  fontFamily: "Imprima",
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  submited(con) {
    {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: backroundColure,
        content: const Text(
            ' This option will be added,\n Start with get started',
            style: TextStyle(fontSize: 15, fontFamily: fontFamilyCustome)),
        action: SnackBarAction(
          label: 'Ok',
          textColor: backroundUnselectedColur,
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(con).showSnackBar(snackBar);
    }
  }
}

gotoTransaction(BuildContext context) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("keyName", true);
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()));
}
