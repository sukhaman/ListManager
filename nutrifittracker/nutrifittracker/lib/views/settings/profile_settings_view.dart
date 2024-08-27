import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/bloc/auth_bloc.dart';
import 'package:nutrifittracker/bloc/auth_event.dart';
import 'package:nutrifittracker/bloc/auth_state.dart';
import 'package:nutrifittracker/constants/routes.dart';

class ProfileSettingsView extends StatefulWidget {
  const ProfileSettingsView({super.key});

  @override
  State<ProfileSettingsView> createState() => _ProfileSettingsViewState();
}

class _ProfileSettingsViewState extends State<ProfileSettingsView> {
  bool _pushNotificationsEnabled = true;
  bool _faceIDEnabled = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          Navigator.of(context).pushNamed(loginRoute);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Expanded(
                      child: Text(
                        'Profile Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSettingsRow(
                        icon: Icons.notifications,
                        text: 'Push notifications',
                        trailing: Switch(
                          value: _pushNotificationsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _pushNotificationsEnabled = value;
                            });
                          },
                        ),
                      ),
                      _buildSettingsRow(
                        icon: Icons.face,
                        text: 'Face ID',
                        trailing: Switch(
                          value: _faceIDEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _faceIDEnabled = value;
                            });
                          },
                        ),
                      ),
                      _buildSettingsRow(
                        icon: Icons.lock,
                        text: 'PIN Code',
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      _buildSettingsRow(
                        icon: Icons.logout,
                        text: 'Logout',
                        textColor: Colors.red,
                        onTap: () {
                          context.read<AuthBloc>().add(
                                const AuthEventLogOut(),
                              );
                        },
                      ),
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

  Widget _buildSettingsRow({
    required IconData icon,
    required String text,
    Widget? trailing,
    Color? textColor,
    VoidCallback? onTap, // Callback function for tap action
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor ?? Colors.black,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
