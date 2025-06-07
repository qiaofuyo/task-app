import 'package:injectable/injectable.dart';
import 'package:workmanager/workmanager.dart';

// 用于调度任务提醒的 UseCase
@injectable
class ScheduleTaskReminderUseCase {
  /// 调度一次性提醒，time 为绝对提醒时间
  void scheduleOneOffReminder(String taskId, DateTime time) {
    final delay = time.difference(DateTime.now());
    Workmanager().registerOneOffTask(
      taskId,               // 唯一任务名
      'taskReminder',       // callbackDispatcher 中匹配的 task 名称
      initialDelay: delay,
      inputData: {'taskId': taskId},
    );
  }

  /// 调度周期性提醒（例如每天固定时刻）
  void scheduleDailyReminder() {
    Workmanager().registerPeriodicTask(
      'dailyReminder',
      'taskReminder',
      frequency: const Duration(days: 1),
      initialDelay: const Duration(seconds: 10), // 启动后 10 秒第一次触发
    );
  }
}
