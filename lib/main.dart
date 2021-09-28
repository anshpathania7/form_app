import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_app/provider/auth_provider.dart';
import 'package:form_app/provider/weight_provider.dart';
import 'package:form_app/screen/auth/auth_wrapper_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => WeightProvider()..loadAllWeightEntries(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapperScreen(),
      ),
    );
  }
}
