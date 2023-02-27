import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_state_management/resources/LocalNotification.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> getFcmToken() async {
    if(Platform.isIOS){
      _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      String? fcmKey = await _firebaseMessaging.getToken();
      return fcmKey;
    }
    String? fcmKey = await _firebaseMessaging.getToken();
    return fcmKey;
  }
  @override
  Widget build(BuildContext context) {
    LocalNotification.initialize();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotification.showNotification(message);
    });
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('Profile Page'),
            Text(
              "Login as " + FirebaseAuth.instance.currentUser!.email.toString(),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Sign Out'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: ()async{
                String? fcmToken = await getFcmToken();
                print("FCM Key : $fcmToken");
              },
              child: Text('Get FCM Token'),
            )
          ],
        ),

      ),
    );
  }
}
