import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';

abstract class UsermealsState {}

class UserMealsLoading extends UsermealsState {}

class UserMealLoaded extends UsermealsState {
  final Iterable<UserMeal> userMeals;

  UserMealLoaded(this.userMeals);
}

class UserMealError extends UsermealsState {
  final String message;

  UserMealError(this.message);
}

class MealAddedSuccess extends UsermealsState {}

class NavigateToAddMealScreenState extends UsermealsState {}

class DismissAddMealScreenState extends UsermealsState {}
