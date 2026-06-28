abstract class BMIState {}

class BMIInitial extends BMIState {}

class BMILoaded extends BMIState {
  final double bmi;
  final String category;

  BMILoaded({
    required this.bmi,
    required this.category,
  });
}