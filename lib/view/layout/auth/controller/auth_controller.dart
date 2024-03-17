import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:symstax/helpers/utils/common_methods.dart';

import '../../../../helpers/utils/navigator_methods.dart';

class AuthController extends ChangeNotifier {
  Future<void> register({
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('${credential.user?.uid}');
      onSuccess.call();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CommonMethods.showError(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommonMethods.showError(
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      CommonMethods.showError(message: e.toString());
    }
    NavigatorMethods.loadingOff();
  }

  Future<void> login({
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log('${credential.user?.uid}');
      onSuccess.call();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CommonMethods.showError(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommonMethods.showError(
            message: 'Wrong password provided for that user.');
      }
    }
    NavigatorMethods.loadingOff();
  }

  Future<void> logout({
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    await FirebaseAuth.instance.signOut();
    onSuccess.call();
    NavigatorMethods.loadingOff();
  }
}
