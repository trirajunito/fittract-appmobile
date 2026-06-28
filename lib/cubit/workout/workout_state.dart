import '../../models/workout_model.dart';

abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final List<WorkoutModel> workouts;

  WorkoutLoaded(this.workouts);
}

class WorkoutError extends WorkoutState {
  final String message;

  WorkoutError(this.message);
}