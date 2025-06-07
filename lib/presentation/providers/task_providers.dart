import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../domain/services/i_task_repository.dart';
import '../../core/di/injection.dart';

/// 从 GetIt 获取 ITaskRepository 单例
final taskRepositoryProvider = Provider<ITaskRepository>((ref) {
  return getIt<ITaskRepository>();
});

/// 异步加载所有任务
final tasksProvider = FutureProvider<List<Task>>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.getAllTasks();
});
