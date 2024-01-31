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

class MyHomePageB extends StatefulWidget {
  @override
  _MyHomePageBState createState() => _MyHomePageBState();
}

class _MyHomePageBState extends State<MyHomePageB> {
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
    DateTime selectedDate = DateTime.parse("2024-01-14");
    double hours = 14.0;
    selectedGenre = "勉強";
    Task newTask = Task("Flutter開発", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-15");
    hours = 13.0;
    selectedGenre = "勉強";
    newTask = Task("Flutter開発", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-16");
    hours = 12.0;
    selectedGenre = "勉強";
    newTask = Task("Flutter開発", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-17");
    hours = 11.0;
    selectedGenre = "勉強";
    newTask = Task("Flutter開発", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-07");
    hours = 8.0;
    selectedGenre = "運動";
    newTask = Task("ビリヤード 練習", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-08");
    hours = 13.0;
    selectedGenre = "運動";
    newTask = Task("ダーツ 練習", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-09");
    hours = 9.0;
    selectedGenre = "運動";
    newTask = Task("スケボー 練習", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-12");
    hours = 12.0;
    selectedGenre = "仕事";
    newTask = Task("プログラミングスクール講師", selectedDate, hours, selectedGenre);
    addTask(newTask);

    selectedDate = DateTime.parse("2024-01-13");
    hours = 13.0;
    selectedGenre = "仕事";
    newTask = Task("プログラミングスクール講師", selectedDate, hours, selectedGenre);
    addTask(newTask);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザBの詳細'),
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
