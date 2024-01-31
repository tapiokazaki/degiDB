import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'task_class_file.dart'; // Taskクラスをインポート

class DBServer {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'task_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, hours REAL, genre TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  static Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  static Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> printAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('tasks');
    for (var row in results) {
      print(row);
    }
  }

  static Future<Map<String, List<double>>> getUserData() async {
    final db = await database;
    // データベースからデータを取得するクエリを実行
    // 以下のクエリは例であり、実際のデータベース構造に合わせて調整が必要
    final List<Map<String, dynamic>> studyResults = await db.query('study_table');
    final List<Map<String, dynamic>> workResults = await db.query('work_table');
    final List<Map<String, dynamic>> exerciseResults = await db.query('exercise_table');

    // データを整形して返す
    List<double> studyData = studyResults.map((row) => row['hours'] as double).toList();
    List<double> workData = workResults.map((row) => row['hours'] as double).toList();
    List<double> exerciseData = exerciseResults.map((row) => row['hours'] as double).toList();

    return {
      'studyData': studyData,
      'workData': workData,
      'exerciseData': exerciseData,
    };
  }
}


