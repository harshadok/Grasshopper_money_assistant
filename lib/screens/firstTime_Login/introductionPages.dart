import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'loginScreen.dart';

class IndroScreen1 extends StatelessWidget {
  const IndroScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: IntroductionScreen(
            showSkipButton: true,
            globalBackgroundColor: Colors.white,
            dotsDecorator: DotsDecorator(
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: const Color.fromRGBO(38, 31, 31, 100),
                size: const Size(10, 8),
                activeColor: Colors.black),
            next: const Text(
              'Next',
              style:
                  TextStyle(fontFamily: "Imprima", fontWeight: FontWeight.bold),
            ),
            skip: const Text(
              "Skip ",
              style:
                  TextStyle(fontFamily: "Imprima", fontWeight: FontWeight.bold),
            ),
            onSkip: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LginScreen()));
            },
            done: const Text("Done",
                style: TextStyle(fontWeight: FontWeight.w600)),
            onDone: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LginScreen()));
            },
            baseBtnStyle: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            skipStyle: TextButton.styleFrom(primary: Colors.black),
            doneStyle: TextButton.styleFrom(primary: Colors.black),
            nextStyle: TextButton.styleFrom(primary: Colors.black),
            pages: [
              PageViewModel(
                  decoration: const PageDecoration(
                      bodyPadding: EdgeInsets.all(20),
                      titlePadding: EdgeInsets.only(top: 10),
                      imageAlignment: Alignment.center,
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "InriaSerif"),
                      bodyTextStyle: TextStyle(fontFamily: "InriaSerif")),
                  title: "Simple and intuitive",
                  body:
                      "log any transaction within  second and,stay on top of your money.",
                  image: Image.asset(
                    'Assets/images/first befor login  1.png',
                    height: 250,
                    width: 250,
                  )),
              PageViewModel(
                  decoration: const PageDecoration(
                      bodyPadding: EdgeInsets.all(20),
                      titlePadding: EdgeInsets.only(top: 10),
                      imageAlignment: Alignment.center,
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "InriaSerif"),
                      bodyTextStyle: TextStyle(fontFamily: "InriaSerif")),
                  title: "Get detailed analysis",
                  body:
                      "informative statistics based on your behaviour.\n Make better decisions with your money!",
                  image: Image.asset(
                    'Assets/images/first before login 2.png',
                    height: 250,
                    width: 250,
                  )),
              PageViewModel(
                  decoration: const PageDecoration(
                      bodyPadding: EdgeInsets.all(20),
                      titlePadding: EdgeInsets.only(top: 10),
                      imageAlignment: Alignment.center,
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "InriaSerif"),
                      bodyTextStyle: TextStyle(fontFamily: "InriaSerif")),
                  title: "Stay on track with budgets",
                  body:
                      "Create a budget and,get future predictions if you are likely to overshoot.",
                  image: Image.asset(
                    'Assets/images/first before login 3 (copy).png',
                    height: 250,
                    width: 250,
                  )),
              PageViewModel(
                  decoration: const PageDecoration(
                      bodyPadding: EdgeInsets.all(20),
                      titlePadding: EdgeInsets.only(top: 10),
                      imageAlignment: Alignment.center,
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "InriaSerif"),
                      bodyTextStyle: TextStyle(fontFamily: "InriaSerif")),
                  title: "We respect your privacy!",
                  body:
                      "We stand firm on respectiong our users’ privacy and would never change our stand on that.",
                  image: Image.asset(
                    'Assets/images/first before  login 4.png',
                    height: 250,
                    width: 250,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
