import 'package:nutrifittracker/models/meal.dart';

abstract class MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final Iterable<Meal> meals;

  MealLoaded({required this.meals});
}

class MealError extends MealState {
  final String message;

  MealError(this.message);
}
