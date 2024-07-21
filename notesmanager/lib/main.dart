import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesmanager/firebase_options.dart';
import 'package:notesmanager/views/login_view.dart';

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
      home: const LoginView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final currentUser = FirebaseAuth.instance.currentUser;
                print(currentUser);
                if (currentUser?.emailVerified ?? false) {
                  return const Text('Done');
                } else {
                  return const VerifyEmailView();
                }
              default:
                return const Text('Loading...');
            }
          }),
    );
  }
}

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Please verify your email address'),
        TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Send email verification'))
      ],
    );
  }
}
