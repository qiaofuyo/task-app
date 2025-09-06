import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/core/di/injection.dart';
import 'presentation/pages/quadrant_page.dart';

import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// FFI 初始化所需
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final FlutterLocalNotificationsPlugin _notifPlugin = FlutterLocalNotificationsPlugin();
// 任务回调的调度器
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // 1. 初始化本地通知（仅首次调用时会生效）
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _notifPlugin.initialize(initSettings);

    // 2. 构造通知详情
    final notificationId = inputData?['taskId']?.hashCode ?? 0;
    const androidDetails = AndroidNotificationDetails(
      'task_channel',                // 通知渠道 ID
      '任务提醒',                     // 渠道名称
      channelDescription: '任务到期或定时提醒',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    // 3. 发送通知
    await _notifPlugin.show(
      notificationId,
      '任务提醒',
      inputData != null
        ? '任务 ${inputData['taskId']} 已到提醒时间'
        : '您有新提醒',
      platformDetails,
    );

    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 初始化 sqflite FFI
  sqfliteFfiInit();
  // 2. 把全局工厂指向 FFI
  databaseFactory = databaseFactoryFfi;

   // DI（依赖注入配置） ，依赖注入
  await configureDependencies();

  Workmanager().initialize(
    callbackDispatcher, 
    isInDebugMode: false,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // 创建 GoRouter 实例，并注册路由
  static final _router = GoRouter(
    initialLocation: QuadrantPage.routeName,
    routes: [
      GoRoute(
        path: QuadrantPage.routeName,
        builder: (context, state) => const QuadrantPage(),
      ),
      // 你可以在这里继续注册其他页面
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Task App',
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
