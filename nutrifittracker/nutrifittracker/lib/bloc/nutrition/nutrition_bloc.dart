import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/bloc/nutrition/nutrition_cloud_storage.dart';
import 'package:nutrifittracker/bloc/nutrition/nutrition_event.dart';
import 'package:nutrifittracker/bloc/nutrition/nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final NutritionCloudStorage nutritionCloudStorage;
  StreamSubscription? _nutritionSubscription;

  NutritionBloc(this.nutritionCloudStorage) : super(NutritionLoading()) {
    on<FetchNutrition>((event, emit) {
      emit(NutritionLoading());
      _nutritionSubscription?.cancel();
      _nutritionSubscription = nutritionCloudStorage.allNutritions().listen(
        (nutritions) {
          add(NutritionUpdated(nutritions));
        },
        onError: (error) {
          emit(NutritionError(error.toString()));
        },
      );
    });

    on<NutritionUpdated>((event, emit) {
      emit(NutritionLoaded(event.nutritions));
    });
  }

  @override
  Future<void> close() {
    _nutritionSubscription?.cancel();
    return super.close();
  }
}
