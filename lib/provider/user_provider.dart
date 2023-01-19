import 'package:flutter/material.dart';
import 'package:tugas_state_management/models/user.dart';
import 'package:tugas_state_management/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();

    _user = user;

    notifyListeners();
  }
}
