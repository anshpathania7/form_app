import 'package:flutter/material.dart';
import 'package:form_app/provider/auth_provider.dart';
import 'package:form_app/screen/weight/weight_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool showSignIn;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    showSignIn = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().context = context;
    return Consumer<AuthProvider>(
      builder: (context, state, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                const SizedBox(height: 40),
                Center(
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final wasSuccess =
                                    await context.read<AuthProvider>().signIn(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                if (wasSuccess) {
                                  Navigator.of(context)
                                    ..pop()
                                    ..push(MaterialPageRoute(
                                        builder: (context) =>
                                            const WeightScreen()));
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    bottomLeft: Radius.circular(2),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final wasSuccess =
                                    await context.read<AuthProvider>().signUp(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                if (wasSuccess) {
                                  Navigator.of(context)
                                    ..pop()
                                    ..push(MaterialPageRoute(
                                        builder: (context) =>
                                            const WeightScreen()));
                                }
                              },
                              style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  ),
                                  side: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              child: const Text("Sign Up"),
                            )
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
