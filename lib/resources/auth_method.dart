import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_state_management/resources/storage_methods.dart';
import 'package:tugas_state_management/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
          user.toJson(),
        );
        res = "Success Sign In";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Invalid Email";
      } else if (err.code == 'email-already-in-use') {
        res = "Email Already In Use";
      } else if (err.code == 'weak-password') {
        res = "Weak Password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Login User
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success Log In";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Invalid Email";
      } else if (err.code == 'user-not-found') {
        res = "User Not Found";
      } else if (err.code == 'wrong-password') {
        res = "Wrong Password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
