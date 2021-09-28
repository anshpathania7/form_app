import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_app/screen/auth/auth_screen.dart';
import 'package:form_app/screen/weight/weight_screen.dart';

class AuthWrapperScreen extends StatelessWidget {
  const AuthWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) =>
            snap.data == null ? const AuthScreen() : const WeightScreen(),
      ),
    );
  }
}
