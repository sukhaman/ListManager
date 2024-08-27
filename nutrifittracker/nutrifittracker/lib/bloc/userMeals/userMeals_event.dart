import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';

abstract class UsermealsEvent {}

class FetchUserMeals extends UsermealsEvent {
  final DateTime date;
  final String mealType;

  FetchUserMeals(this.date, this.mealType);
}

class AddNewMealEntry extends UsermealsEvent {}

class DismissAddNewMealEntry extends UsermealsEvent {}

class UserMealsUpdated extends UsermealsEvent {
  final Iterable<UserMeal> meals;

  UserMealsUpdated(this.meals);
}
