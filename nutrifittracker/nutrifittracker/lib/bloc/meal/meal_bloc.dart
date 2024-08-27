import 'package:bloc/bloc.dart';
import 'package:nutrifittracker/bloc/meal/meal_cloud_storge.dart';
import 'meal_event.dart';
import 'meal_state.dart';
import 'dart:async';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealCloudStorge mealCloudStorage;
  StreamSubscription? _mealSubscription;

  MealBloc({required this.mealCloudStorage}) : super(MealLoading()) {
    on<FetchMeals>((event, emit) {
      emit(MealLoading());
      _mealSubscription?.cancel();
      _mealSubscription = mealCloudStorage.allMeals().listen(
        (meals) {
          add(MealUpdated(meals: meals));
        },
        onError: (error) {
          emit(MealError(error.toString()));
        },
      );
    });

    on<MealUpdated>((event, emit) {
      emit(MealLoaded(meals: event.meals));
    });
  }

  @override
  Future<void> close() {
    _mealSubscription?.cancel();
    return super.close();
  }
}
