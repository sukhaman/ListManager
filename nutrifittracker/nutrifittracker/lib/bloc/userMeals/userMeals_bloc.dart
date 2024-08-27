import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/bloc/meal/meal_cloud_storge.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_event.dart';
import 'package:nutrifittracker/bloc/userMeals/userMeals_state.dart';
import 'package:nutrifittracker/bloc/userMeals/user_meal_cloud_storage.dart';

class UserMealsBloc extends Bloc<UsermealsEvent, UsermealsState> {
  final UserMealCloudStorage _mealCloudStorage;
  StreamSubscription? _mealSubscription;

  UserMealsBloc(this._mealCloudStorage) : super(UserMealsLoading()) {
    on<FetchUserMeals>((event, emit) {
      emit(UserMealsLoading());
      _mealSubscription?.cancel();
      _mealSubscription =
          _mealCloudStorage.getMealsForUser(event.date, event.mealType).listen(
        (nutritions) {
          add(UserMealsUpdated(nutritions));
        },
        onError: (error) {
          emit(UserMealError(error.toString()));
        },
      );
    });

    on<UserMealsUpdated>((event, emit) {
      emit(UserMealLoaded(event.meals));
    });
    on<AddNewMealEntry>(
      (event, emit) {
        emit(NavigateToAddMealScreenState());
      },
    );
    on<DismissAddNewMealEntry>(
      (event, emit) {
        emit(DismissAddMealScreenState());
      },
    );
  }

  @override
  Future<void> close() {
    _mealSubscription?.cancel();
    return super.close();
  }
}
