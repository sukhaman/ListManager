import 'package:flutter/material.dart' show immutable;
import 'package:nutrifittracker/body/models/user_body.dart';

@immutable
abstract class BodyEvent {}

class BodyUpdated extends BodyEvent {
  final UserBody userBody;

  BodyUpdated({required this.userBody});
}

class BodyAddRequestEvent extends BodyEvent {
  final int age;
  final String gender;
  final int heightInFeet;
  final int heightInInches;
  final int weight;

  BodyAddRequestEvent(
      {required this.age,
      required this.gender,
      required this.heightInFeet,
      required this.heightInInches,
      required this.weight});
}
