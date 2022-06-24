import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notoficatoionService =
      NotificationService._internal();

  factory NotificationService() {
    return _notoficatoionService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationService._internal();
  Future<void> initNotification() async {
    const AndroidInitializationSettings intiolizationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(android: intiolizationSettingsAndroid);

    await flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    await flutterLocalNotificationPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),

        // ignore: prefer_const_constructors
        NotificationDetails(
            android: const AndroidNotificationDetails(
                "main Channel"
                    "Main Channel",
                "Save it  Notification",
                importance: Importance.max,
                priority: Priority.max,
                icon: "@mipmap/ic_launcher")),
        //payload: TranscationDb.instance.balanceNotifier.value.toString(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future<void> cancellAllNotification() async {
    await flutterLocalNotificationPlugin.cancelAll();
  }
}
