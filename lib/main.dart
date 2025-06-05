import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/pages/quadrant_page.dart';

void main() {
  runApp(const MyApp());
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
