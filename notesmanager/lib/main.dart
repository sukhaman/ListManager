import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesmanager/constans/routes.dart';
import 'package:notesmanager/services/auth/bloc/auth_State.dart';
import 'package:notesmanager/services/auth/bloc/auth_bloc.dart';
import 'package:notesmanager/services/auth/bloc/auth_event.dart';
import 'package:notesmanager/services/auth/firebase_auth_provider.dart';
import 'package:notesmanager/views/home_view.dart';
import 'package:notesmanager/views/login_view.dart';
import 'package:notesmanager/views/notes/create_update_note_view.dart';
import 'package:notesmanager/views/register_view.dart';
import 'views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const MainView(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        homeRoute: (context) => const HomeView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventIntialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomeView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
