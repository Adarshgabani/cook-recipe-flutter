import 'dart:developer';

import 'package:cook_recipe/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  static User? _user = FirebaseAuth.instance.currentUser;
  static User? get currentUser => _user;

  static Future<String> registerUser({required BuildContext context, required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      log("SUCCESS::: registerUser :: $credential");
      return 'SUCCESS';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'The account already exists for that email.';
      }
      return e.code;
    } catch (e) {
      print(e);
      return 'Something went wrong';
    }
  }

  static Future<String?> signinWithEmail(BuildContext context, {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);
      log("SUCCESS::: registerUser :: $credential");
      _user = FirebaseAuth.instance.currentUser;
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      return e.code;
    } catch (e) {
      print(e);
      showErrorMessage(context, errorMessage: 'Something went wrong');

      return 'Something went wrong';
    }
  }
}
