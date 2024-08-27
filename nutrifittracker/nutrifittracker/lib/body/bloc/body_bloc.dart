import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/body/bloc/body_cloud_storage.dart';
import 'package:nutrifittracker/body/bloc/body_event.dart';
import 'package:nutrifittracker/body/bloc/body_state.dart';

class BodyBloc extends Bloc<BodyEvent, BodyState> {
  final BodyCloudStorage bodyCloudStorage;
  BodyBloc(this.bodyCloudStorage) : super(BodyLoading()) {
    on<BodyAddRequestEvent>((event, emit) async {
      try {
        await bodyCloudStorage.addBodyEntry(
          age: event.age,
          gender: event.gender,
          heightInFeet: event.heightInFeet,
          heightInInches: event.heightInInches,
          weight: event.weight,
        );
        emit(BodyAdded(true));
      } catch (e) {
        emit(BodyError(e.toString()));
      }
    });
  }
}
