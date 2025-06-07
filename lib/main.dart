import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/core/di/injection.dart';
import 'presentation/pages/quadrant_page.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'taskReminder') {
      // final taskId = inputData?['taskId'] as String?;
      // 这里可根据 taskId 获取更多信息并发送通知
      // … 通知逻辑 …
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(); // DI（依赖注入配置） 初始化
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
