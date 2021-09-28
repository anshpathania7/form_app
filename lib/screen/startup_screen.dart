import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_app/provider/auth_provider.dart';
import 'package:form_app/screen/auth_screen.dart';
import 'package:form_app/screen/weight_screen.dart';
import 'package:provider/provider.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

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
