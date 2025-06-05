import '../../domain/entities/task.dart';
import '../../domain/value_objects/quadrant.dart';

/// 数据库表名
const String taskTable = 'tasks';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String quadrant; // 存储枚举的 name
  final int completed;   // 0 或 1
  final int createdAt;   // 毫秒时间戳

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.quadrant,
    required this.completed,
    required this.createdAt,
  });

  /// 从领域层实体转换
  factory TaskModel.fromDomain(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      quadrant: task.quadrant.name,
      completed: task.completed ? 1 : 0,
      createdAt: task.createdAt.millisecondsSinceEpoch,
    );
  }

  /// 转回领域层实体
  Task toDomain() {
    return Task(
      id: id,
      title: title,
      description: description,
      quadrant: Quadrant.values.firstWhere((e) => e.name == quadrant),
      completed: completed == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }

  /// 用于 sqflite 插入/更新的 Map
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'quadrant': quadrant,
      'completed': completed,
      'createdAt': createdAt,
    };
  }

  /// 从数据库查询结果构建
  factory TaskModel.fromMap(Map<String, Object?> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      quadrant: map['quadrant'] as String,
      completed: map['completed'] as int,
      createdAt: map['createdAt'] as int,
    );
  }
}
