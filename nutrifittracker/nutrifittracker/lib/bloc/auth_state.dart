import 'package:flutter/material.dart' show immutable;
import 'package:nutrifittracker/bloc/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;

  const AuthState({
    required this.isLoading,
    this.loadingText,
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading});
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;

  const AuthStateRegistering(
      {required super.isLoading, super.loadingText, this.exception});
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(
      {required this.exception, required isLoading, super.loadingText})
      : super(isLoading: false);

  List<Object?> get props => [exception, isLoading];
}
