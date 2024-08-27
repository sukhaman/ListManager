// Define states for NutritionBloc
import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';

abstract class NutritionState {}

class NutritionLoading extends NutritionState {}

class NutritionLoaded extends NutritionState {
  final Iterable<NutritionType> nutritions;

  NutritionLoaded(this.nutritions);
}

class NutritionError extends NutritionState {
  final String message;

  NutritionError(this.message);
}
