import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/weight_model.dart';
import '../../services/weight_service.dart';

import 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  WeightCubit() : super(WeightInitial());

  final WeightService _service = WeightService();

  Future<void> loadWeights() async {
    try {
      emit(WeightLoading());

      final weights = await _service.getWeights();

      emit(
        WeightLoaded(weights),
      );
    } catch (e) {
      emit(
        WeightError(e.toString()),
      );
    }
  }

  Future<void> addWeight(
    WeightModel weight,
  ) async {
    await _service.insertWeight(weight);

    loadWeights();
  }

  Future<void> updateWeight(
    WeightModel weight,
  ) async {
    await _service.updateWeight(weight);

    loadWeights();
  }

  Future<void> deleteWeight(
    int id,
  ) async {
    await _service.deleteWeight(id);

    loadWeights();
  }
}