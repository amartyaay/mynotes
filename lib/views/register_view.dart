// ignore_for_file: avoid_devtools.log

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'dart:developer' as devtools show log;
import '../firebase_options.dart';
import '../utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    autofocus: true,
                    decoration:
                        const InputDecoration(hintText: 'Enter your Mail'),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Password',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          devtools.log('pass too weak');
                          await showErrorDialog(
                            context,
                            "Weak password",
                          );
                        } else if (e.code == 'email-already-in-use') {
                          devtools.log('email arelady in use');
                          await showErrorDialog(
                            context,
                            "Email already in Use",
                          );
                        } else if (e.code == 'invalid-email') {
                          devtools.log('mail add not valid');
                          await showErrorDialog(
                            context,
                            "Invalid E-Mail address",
                          );
                        } else {
                          devtools.log(e.toString());
                          await showErrorDialog(
                            context,
                            "Error: ${e.code.toString()}",
                          );
                        }
                      } catch (e) {
                        await showErrorDialog(
                          context,
                          "Error: ${e.toString()}",
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false);
                    },
                    child: const Text(
                      'Already registered? Login Here',
                    ),
                  )
                ],
              );
            default:
              return const Text('Loading');
          }
        },
      ),
    );
  }
}
