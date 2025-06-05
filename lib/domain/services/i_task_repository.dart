import '../entities/task.dart';

abstract class ITaskRepository {
  Future<void> addTask(Task task);
  Future<List<Task>> getAllTasks();
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
}
