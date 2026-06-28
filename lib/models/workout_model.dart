class WorkoutModel {
  int? id;
  String nama;
  int setCount;
  int reps;
  double weight;
  String tanggal;

  WorkoutModel({
    this.id,
    required this.nama,
    required this.setCount,
    required this.reps,
    required this.weight,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'setCount': setCount,
      'reps': reps,
      'weight': weight,
      'tanggal': tanggal,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'],
      nama: map['nama'],
      setCount: map['setCount'],
      reps: map['reps'],
      weight: map['weight'],
      tanggal: map['tanggal'],
    );
  }
}