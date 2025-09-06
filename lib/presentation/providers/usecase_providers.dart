import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/transcribe_and_create_task_usecase.dart';
import '../../application/usecases/schedule_task_reminder_usecase.dart';
import '../../core/di/injection.dart';

/// 暴露转写并创建任务的 UseCase
final transcribeAndCreateTaskUseCaseProvider =
    Provider<TranscribeAndCreateTaskUseCase>((ref) {
  return getIt<TranscribeAndCreateTaskUseCase>();
});

/// 暴露调度任务提醒的 UseCase
final scheduleTaskReminderUseCaseProvider =
    Provider<ScheduleTaskReminderUseCase>((ref) {
  return getIt<ScheduleTaskReminderUseCase>();
});
