// userA.dart

import 'package:flutter/material.dart';

class Task {
  final String title;
  final DateTime date;
  final double hours;
  final String genre;

  Task(this.title, this.date, this.hours, this.genre);

  String get formattedDate {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class MyHomePageA extends StatefulWidget {
  @override
  _MyHomePageAState createState() => _MyHomePageAState();
}

class _MyHomePageAState extends State<MyHomePageA> {
  List<Task> tasks = [];
  List<String> genres = ['勉強', '仕事', '運動'];

  String selectedGenre = '勉強';

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    DateTime selectedDate = DateTime.parse("2024-01-17");
    double hours = 12.0;
    selectedGenre = "勉強";
    Task newTask = Task("C言語", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-17");
    hours = 6.0;
    selectedGenre = "勉強";
    newTask = Task("幾何学", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-17");
    hours = 4.0;
    selectedGenre = "運動";
    newTask = Task("バスケシュート練習", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-17");
    hours = 6.0;
    selectedGenre = "運動";
    newTask = Task("ビリヤード 大会", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-17");
    hours = 10.0;
    selectedGenre = "仕事";
    newTask = Task("ガソリンスタンド バイト", selectedDate, hours, selectedGenre);
    addTask(newTask);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザAの詳細'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(
              'ジャンル: ${tasks[index].genre}, 日時: ${tasks[index].formattedDate}, 時間: ${tasks[index].hours} 時間',
            ),
          );
        },
      ),
      floatingActionButton: null,
    );
  }
}
