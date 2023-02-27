import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(){
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (NotificationResponse details) {
      print('did receive notification response');
      print(details.payload);
      print(details.payload != null);
    });
  }
  static void showNotification(RemoteMessage message) {
    final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            'com.example.tugas_state_management', 'tugas_state_management',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker')
    );
    flutterLocalNotificationsPlugin.show(
        DateTime.now().microsecond, message.notification!.title, message.notification!.body,
        notificationDetails,payload: message.data.toString());
  }
}