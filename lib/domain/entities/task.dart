import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/quadrant.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    required Quadrant quadrant,
    @Default(false) bool completed,
    required DateTime createdAt,
  }) = _Task;
}
