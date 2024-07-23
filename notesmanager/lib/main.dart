import 'package:flutter/material.dart';
import 'package:notesmanager/constans/routes.dart';
import 'package:notesmanager/services/auth/auth_service.dart';
import 'package:notesmanager/views/home_view.dart';
import 'package:notesmanager/views/login_view.dart';
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
      home: const MainView(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        homeRoute: (context) => const HomeView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final currentUser = AuthService.firebase().currentUser;
              if (currentUser != null) {
                if (currentUser.isEmailVerified) {
                  return const HomeView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const Text('Loading...');
          }
        });
  }
}
