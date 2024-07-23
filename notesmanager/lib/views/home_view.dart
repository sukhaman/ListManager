import 'package:flutter/material.dart';
import 'package:notesmanager/constans/routes.dart';
import 'package:notesmanager/enums/menu_action.dart';
import 'package:notesmanager/services/auth/auth_exceptions.dart';
import 'package:notesmanager/services/auth/auth_service.dart';
import 'package:notesmanager/utilities/show_error_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                // TODO: Handle this case.
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  try {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  } on GenericAuthException {
                    await showErrorDialog(context, 'Unable to log out');
                  }
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: MenuAction.logout,
                child: Text('Log out'),
              )
            ];
          })
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
