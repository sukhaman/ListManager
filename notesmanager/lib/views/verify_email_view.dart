import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesmanager/constans/routes.dart';
import 'package:notesmanager/services/auth/auth_exceptions.dart';
import 'package:notesmanager/services/auth/auth_service.dart';
import 'package:notesmanager/services/auth/bloc/auth_bloc.dart';
import 'package:notesmanager/services/auth/bloc/auth_event.dart';
import 'package:notesmanager/utilities/dialogs/error_dialog.dart';

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
                context.read<AuthBloc>().add(
                      const AuthEventSendEmailVerificaiton(),
                    );
              },
              child: const Text('Send email verification')),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                    const AuthEventLogOut(),
                  );
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
