import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Mail'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text('Click the button below to verify your email'),
          TextButton(
            onPressed: () async {
              await AuthService.firbase().senEmailVerification();
              await AuthService.firbase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Verify Email'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firbase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Restart APP'),
          ),
        ],
      ),
    );
  }
}
