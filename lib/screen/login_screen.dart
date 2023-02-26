import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tugas_state_management/resources/auth_method.dart';
import 'package:tugas_state_management/screen/bottom_navigation.dart';
import 'package:tugas_state_management/screen/home.dart';
import 'package:tugas_state_management/screen/register_screen.dart';
import 'package:tugas_state_management/utils/utils.dart';
import 'package:tugas_state_management/widget/text-field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tugas_state_management/screen/responsive_layout.dart';
import 'package:tugas_state_management/screen/loginPortrait.dart';
import 'package:tugas_state_management/screen/login_landscape.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        portraitBody: loginportrait(),
        landscapeBody: loginlandscape(),
      ),
    );
  }
}
