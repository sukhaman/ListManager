import 'package:nutrifittracker/models/meal.dart';

abstract class MealEvent {}

class FetchMeals extends MealEvent {}

class MealUpdated extends MealEvent {
  final Iterable<Meal> meals;

  MealUpdated({required this.meals});
}
