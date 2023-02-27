import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gap/gap.dart';
import 'package:tugas_state_management/local-push/local_pushnotfication.dart';
import 'package:tugas_state_management/resources/auth_method.dart';
import 'package:tugas_state_management/screen/bottom_navigation.dart';
import 'package:tugas_state_management/screen/home.dart';
import 'package:tugas_state_management/screen/register_screen.dart';
import 'package:tugas_state_management/utils/utils.dart';
import 'package:tugas_state_management/widget/text-field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class loginportrait extends StatefulWidget {
  loginportrait({Key? key}) : super(key: key);

  @override
  State<loginportrait> createState() => _loginportraitState();
}

class _loginportraitState extends State<loginportrait> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'Success Sign In') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()));
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 1),
              Image(
                image: AssetImage(
                  'assets/images/person-login.png',
                ),
                fit: BoxFit.fitHeight,
                width: 300,
                height: 250,
              ),
              const Gap(20),
              Container(
                width: double.infinity,
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Gap(30),
              TextFieldInput(
                icon: Icon(
                  Icons.alternate_email,
                ),
                textEditingController: _emailController,
                hintText: "Enter Email",
                textInputType: TextInputType.emailAddress,
                isPass: false,
              ),
              const Gap(20),
              TextFieldInput(
                  icon: Icon(
                    Icons.lock_outline_rounded,
                  ),
                  textEditingController: _passwordController,
                  hintText: "Enter Password",
                  textInputType: TextInputType.visiblePassword,
                  isPass: true),
              const Gap(20),
              Container(
                width: double.infinity,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const Gap(20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    loginUser();
                    Noti.showBigTextNotification(
                        title: "Login Berhasil !",
                        body: "Selamat Datang Masbro",
                        fln: flutterLocalNotificationsPlugin);
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const Gap(15),
              Container(
                width: double.infinity,
                child: Text(
                  'Or',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(15),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/images/google.png',
                        ),
                        fit: BoxFit.fitWidth,
                        width: 25,
                        height: 25,
                      ),
                      Expanded(child: Container()),
                      Text(
                        'LOGIN WITH GOOGLE',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Container(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
