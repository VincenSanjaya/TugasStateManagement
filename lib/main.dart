import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tugas_state_management/screen/login_screen.dart';
import 'package:tugas_state_management/screen/register_screen.dart';

import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas State Management',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        fontFamily: 'Montserrat',
      ),
      home: RegisterScreen()
    );
  }
}

