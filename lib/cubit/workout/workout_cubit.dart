import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/workout_model.dart';
import '../../services/workout_service.dart';

import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutInitial());

  final WorkoutService _service = WorkoutService();

  Future<void> loadWorkouts() async {
    try {
      emit(WorkoutLoading());

      final workouts = await _service.getWorkouts();

      emit(WorkoutLoaded(workouts));
    } catch (e) {
      emit(
        WorkoutError(e.toString()),
      );
    }
  }

  Future<void> addWorkout(
    WorkoutModel workout,
  ) async {
    await _service.insertWorkout(workout);

    loadWorkouts();
  }

  Future<void> updateWorkout(
    WorkoutModel workout,
  ) async {
    await _service.updateWorkout(workout);

    loadWorkouts();
  }

  Future<void> deleteWorkout(
    int id,
  ) async {
    await _service.deleteWorkout(id);

    loadWorkouts();
  }
}