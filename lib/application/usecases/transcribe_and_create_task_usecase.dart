import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
// import 'package:workmanager/workmanager.dart';

import '../../domain/services/i_transcription_engine.dart';
import '../../domain/services/i_task_repository.dart';
import '../../domain/entities/task.dart';
import '../../domain/value_objects/quadrant.dart';
import 'schedule_task_reminder_usecase.dart';

@injectable
class TranscribeAndCreateTaskUseCase {
  final ITranscriptionEngine _transcriptionEngine;
  final ITaskRepository _taskRepository;
  final ScheduleTaskReminderUseCase _reminderUseCase;
  final Uuid _uuid = const Uuid();

  TranscribeAndCreateTaskUseCase(
    this._transcriptionEngine,
    this._taskRepository,
    this._reminderUseCase,
  );

  /// 启动录音、获取文字流并创建新任务（放在“不重要但紧急”象限）
  Stream<Task> execute() async* {
    await for (final text in _transcriptionEngine.startTranscription()) {
      final newTask = Task(
        id: _uuid.v4(),
        title: text,
        description: '',
        quadrant: Quadrant.notImportantUrgent,
        createdAt: DateTime.now(),
      );
      // 1. 存库
      await _taskRepository.addTask(newTask);
      // 2. 调度提醒：这里我们示例定在任务创建后 1 分钟提醒一次
      // final reminderTime = DateTime.now().add(const Duration(minutes: 1));
      final reminderTime = DateTime.now().add(const Duration(seconds: 10));
      _reminderUseCase.scheduleOneOffReminder(newTask.id, reminderTime);
      // 3. 将新任务通过 Stream 返回给 UI
      yield newTask;
    }
  }

  Future<void> stop() => _transcriptionEngine.stopTranscription();
}
