import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tugas_state_management/widget/text-field_input.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'assets/images/person-signup.png',
                    ),
                    fit: BoxFit.fitHeight,
                    width: 300,
                    height: 250,
                  ),
                  const Gap(20),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'SIGN UP',
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
                      Icons.person_outline,
                    ),
                    textEditingController: _nameController,
                    hintText: "Enter Username",
                    textInputType: TextInputType.text,
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
                  const Gap(30),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'REGISTER',
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
                  Flexible(child: Container(), flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text("Already have an account?"),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: const Text("Login", style: TextStyle(
                              fontWeight: FontWeight.w900
                          ),),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
