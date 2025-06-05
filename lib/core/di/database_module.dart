import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const String _tasksTable = 'tasks';

@module
abstract class DatabaseModule {
  @Named('AppDatabase')
  @preResolve
  Future<Database> get database async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'app.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tasksTable (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            quadrant TEXT NOT NULL,
            completed INTEGER NOT NULL,
            createdAt INTEGER NOT NULL
          )
        ''');
      },
    );
  }
}
