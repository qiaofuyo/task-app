import 'package:flutter/material.dart';
import '../../domain/value_objects/quadrant.dart';

class QuadrantPage extends StatelessWidget {
  static const routeName = '/quadrants';

  const QuadrantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('四象限任务管理')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: Quadrant.values.map((q) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                q.displayName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
