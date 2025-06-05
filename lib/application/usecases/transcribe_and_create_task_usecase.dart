import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../domain/services/i_transcription_engine.dart';
import '../../domain/services/i_task_repository.dart';
import '../../domain/entities/task.dart';
import '../../domain/value_objects/quadrant.dart';

@injectable
class TranscribeAndCreateTaskUseCase {
  final ITranscriptionEngine _transcriptionEngine;
  final ITaskRepository _taskRepository;
  final Uuid _uuid = const Uuid();

  TranscribeAndCreateTaskUseCase(
    this._transcriptionEngine,
    this._taskRepository,
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
      await _taskRepository.addTask(newTask);
      yield newTask;
    }
  }

  Future<void> stop() => _transcriptionEngine.stopTranscription();
}
