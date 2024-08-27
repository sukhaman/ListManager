// Define events for NutritionBloc
import 'package:nutrifittracker/bloc/nutrition/nutrition_type.dart';

abstract class NutritionEvent {}

class FetchNutrition extends NutritionEvent {}

class NutritionUpdated extends NutritionEvent {
  final Iterable<NutritionType> nutritions;

  NutritionUpdated(this.nutritions);
}
