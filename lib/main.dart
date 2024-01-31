import 'package:flutter/material.dart';
import 'notification_helper.dart';
import 'footer.dart'; // footer.dartをインポート
import 'graph.dart'; // graph.dartをインポート
import 'DBserver.dart'; // DBserver.dartをインポート
import 'task_class_file.dart';

void main() async {
  // 通知プラグインの初期化
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();

  // 日本時間の午前10時に通知をスケジュール
  await showNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ドリカムダイアリー',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  List<String> genres = ['勉強', '仕事', '運動']; // ジャンルのリスト

  String selectedGenre = '勉強'; // 選択されたジャンルの初期値

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    List<Task> loadedTasks = await DBServer.getTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }

  void addTask(Task task) async {
    await DBServer.insertTask(task);
    loadTasks();
  }

  void removeTask(int id) async {
    await DBServer.deleteTask(id);
    loadTasks();
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ドリカムダイアリー'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(
              'ジャンル: ${tasks[index].genre}, 日時: ${tasks[index].formattedDate}, 時間: ${tasks[index].hours} 時間',
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeTask(tasks[index].id!); // idを使用して削除
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: Text('今日やったこと'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(labelText: 'タイトル'),
                        ),
                        SizedBox(height: 20),
                        DropdownButton<String>(
                          value: selectedGenre,
                          items: genres.map((String genre) {
                            return DropdownMenuItem<String>(
                              value: genre,
                              child: Text(genre),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGenre = newValue!;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(labelText: '日付 (yyyy-MM-dd)'),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _hoursController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: '時間'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text('キャンセル'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('追加'),
                        onPressed: () {
                          String title = _titleController.text;
                          String dateText = _dateController.text;
                          String hoursString = _hoursController.text;

                          if (title.isNotEmpty && dateText.isNotEmpty && hoursString.isNotEmpty) {
                            DateTime selectedDate = DateTime.parse(dateText);
                            double hours = double.parse(hoursString);

                            Task newTask = Task(title: title, date: selectedDate, hours: hours, genre: selectedGenre);
                            addTask(newTask);
                            Navigator.of(context).pop();
                            _titleController.clear();
                            _dateController.clear();
                            _hoursController.clear();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Footer(
        onItemTapped: (index) {
          // フッターのアイテムがタップされたときの処理
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GraphScreen()), // GraphScreenを表示
            );
          }
        },
      ),
    );
  }
}
