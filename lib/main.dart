import 'package:_save_karo/models/catogary/categoryModel.dart';
import 'package:_save_karo/models/transaction/transcationDB.dart';
import 'package:_save_karo/screens/extra_Pages/notification.dart';
import 'package:_save_karo/screens/firstTime_Login/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CatogaryTypeAdapter().typeId)) {
    Hive.registerAdapter(CatogaryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CatogeryModelAdapter().typeId)) {
    Hive.registerAdapter(CatogeryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TranscationModelAdapter().typeId)) {
    Hive.registerAdapter(TranscationModelAdapter());
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            //brightness: Brightness.dark),
            primarySwatch: Colors.grey),
        home: const SplashSCreen());
  }
}
