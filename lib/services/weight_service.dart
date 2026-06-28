import '../models/weight_model.dart';
import 'database_service.dart';

class WeightService {
  Future<int> insertWeight(
    WeightModel weight,
  ) async {
    final db = await DatabaseService.database;

    return await db.insert(
      'body_weight',
      weight.toMap(),
    );
  }

  Future<List<WeightModel>> getWeights() async {
    final db = await DatabaseService.database;

    final List<Map<String, dynamic>> maps =
        await db.query('body_weight');

    return List.generate(
      maps.length,
      (i) => WeightModel.fromMap(maps[i]),
    );
  }

  Future<int> updateWeight(
    WeightModel weight,
  ) async {
    final db = await DatabaseService.database;

    return await db.update(
      'body_weight',
      weight.toMap(),
      where: 'id=?',
      whereArgs: [weight.id],
    );
  }

  Future<int> deleteWeight(int id) async {
    final db = await DatabaseService.database;

    return await db.delete(
      'body_weight',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}