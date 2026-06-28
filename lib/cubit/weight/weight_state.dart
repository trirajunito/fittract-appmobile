import '../../models/weight_model.dart';

abstract class WeightState {}

class WeightInitial extends WeightState {}

class WeightLoading extends WeightState {}

class WeightLoaded extends WeightState {
  final List<WeightModel> weights;

  WeightLoaded(this.weights);
}

class WeightError extends WeightState {
  final String message;

  WeightError(this.message);
}