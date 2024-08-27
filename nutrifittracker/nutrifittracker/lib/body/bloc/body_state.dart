import 'package:flutter/material.dart' show immutable;
import 'package:nutrifittracker/bloc/auth_user.dart';

@immutable
abstract class BodyState {}

class BodyLoading extends BodyState {}

class BodyError extends BodyState {
  final String message;

  BodyError(this.message);
}

class BodyAdded extends BodyState {
  final bool isAdded;

  BodyAdded(this.isAdded);
}
