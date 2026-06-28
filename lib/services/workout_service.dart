import 'database_service.dart';
import '../models/workout_model.dart';

class WorkoutService {
  Future<int> insertWorkout(WorkoutModel workout) async {
    final db = await DatabaseService.database;

    return await db.insert(
      'workouts',
      workout.toMap(),
    );
  }

  Future<List<WorkoutModel>> getWorkouts() async {
    final db = await DatabaseService.database;

    final List<Map<String, dynamic>> maps =
        await db.query('workouts');

    return List.generate(
      maps.length,
      (i) => WorkoutModel.fromMap(maps[i]),
    );
  }

  Future<int> updateWorkout(WorkoutModel workout) async {
    final db = await DatabaseService.database;

    return await db.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }

  Future<int> deleteWorkout(int id) async {
    final db = await DatabaseService.database;

    return await db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}