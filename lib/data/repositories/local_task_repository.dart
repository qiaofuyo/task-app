import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/task.dart';
import '../../domain/services/i_task_repository.dart';
import '../models/task_model.dart';

@LazySingleton(as: ITaskRepository)
class LocalTaskRepository implements ITaskRepository {
  final Database _db;

  LocalTaskRepository(@Named('AppDatabase') this._db);

  @override
  Future<void> addTask(Task task) async {
    final model = TaskModel.fromDomain(task);
    await _db.insert(
      taskTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    await _db.delete(
      taskTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final maps = await _db.query(taskTable);
    return maps.map((m) => TaskModel.fromMap(m).toDomain()).toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    final model = TaskModel.fromDomain(task);
    await _db.update(
      taskTable,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
