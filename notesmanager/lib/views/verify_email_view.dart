import 'package:flutter/material.dart';
import 'package:notesmanager/constans/routes.dart';
import 'package:notesmanager/services/auth/auth_exceptions.dart';
import 'package:notesmanager/services/auth/auth_service.dart';
import 'package:notesmanager/utilities/show_error_dialog.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify your account."),
          const Text(
              "If you haven't received a verificaiton email yet, press the button below"),
          TextButton(
              onPressed: () async {
                try {
                  await AuthService.firebase().sendEmailVerification();
                } on GenericAuthException {
                  // ignore: use_build_context_synchronously
                  await showErrorDialog(context,
                      'Unable to send verification email at the moment. Please try again later.');
                }
              },
              child: const Text('Send email verification')),
          TextButton(
            onPressed: () async {
              try {
                await AuthService.firebase().logOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              } on GenericAuthException {
                // ignore: use_build_context_synchronously
                await showErrorDialog(context,
                    'Unable to send verification email at the moment. Please try again later.');
              }
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
