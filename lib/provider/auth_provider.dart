// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_app/repository/auth_repository.dart';
import 'package:form_app/repository/weights_repository.dart';
import 'package:form_app/screen/common/snackbar.dart';

class AuthProvider extends ChangeNotifier {
  //
  bool isLoading;
  BuildContext? context;
  final AuthRepository _authRepository = AuthRepository();

  AuthProvider(this.context) : isLoading = false;

  set _updateLoading(bool v) {
    isLoading = v;
    notifyListeners();
  }

  Future<bool> signUp({required String email, required String password}) async {
    //
    _updateLoading = true;
    bool successfullySignedIn;
    try {
      await _authRepository.registerWithEmail(email: email, password: password);
      await _authRepository.signinWithEmail(email: email, password: password);
      successfullySignedIn = true;
    } on String catch (e) {
      successfullySignedIn = false;
      print(e);
      if (context != null) {
        ScaffoldMessenger.of(context!)
            // ignore: prefer_const_constructors
            .showSnackBar(Snackbar(
          message: e.toString(),
        ));
      }
    } finally {
      _updateLoading = false;
    }
    return successfullySignedIn;
  }

  Future<bool> signIn({required String email, required String password}) async {
    //
    _updateLoading = true;
    bool successfullySignedIn;
    try {
      await _authRepository.signinWithEmail(email: email, password: password);
      successfullySignedIn = true;
    } on String catch (e) {
      successfullySignedIn = false;
      if (context != null) {
        ScaffoldMessenger.of(context!)
            // ignore: prefer_const_constructors
            .showSnackBar(Snackbar(
          message: e,
        ));
      }
    } finally {
      _updateLoading = false;
    }
    return successfullySignedIn;
  }

  void logoutCurrentUser() async {
    try {
      await _authRepository.logout();
    } catch (e) {
      ScaffoldMessenger.of(context!)
          // ignore: prefer_const_constructors
          .showSnackBar(Snackbar(
        message: "Couldn't Sign out, Try again",
      ));
    }
  }
}
