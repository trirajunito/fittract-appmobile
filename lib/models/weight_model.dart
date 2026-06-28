class WeightModel {
  int? id;
  double weight;
  String date;

  WeightModel({
    this.id,
    required this.weight,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weight': weight,
      'date': date,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      id: map['id'],
      weight: map['weight'],
      date: map['date'],
    );
  }
}