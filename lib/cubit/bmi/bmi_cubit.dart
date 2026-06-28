import 'package:flutter_bloc/flutter_bloc.dart';

import 'bmi_state.dart';

class BMICubit extends Cubit<BMIState> {
  BMICubit() : super(BMIInitial());

  void calculateBMI({
    required double weight,
    required double height,
  }) {
    final heightMeter = height / 100;

    final bmi =
        weight /
        (heightMeter * heightMeter);

    String category = '';

    if (bmi < 18.5) {
      category = 'Kurus';
    } else if (bmi < 25) {
      category = 'Normal';
    } else if (bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obesitas';
    }

    emit(
      BMILoaded(
        bmi: bmi,
        category: category,
      ),
    );
  }
}