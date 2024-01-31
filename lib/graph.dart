import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_demo/userA.dart';
import 'package:flutter_demo/userB.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graph Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: WorkChart(),
            ),
          ),
          // SizedBox(height: 40.0), // 余白を追加
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // ボタン1が押されたときの処理
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePageA(),
                    ),
                  );
                },
                child: Text('ユーザA詳細'),
              ),
              ElevatedButton(
                onPressed: () {
                  // ボタン2が押されたときの処理
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePageB(),
                    ),
                  );
                },
                child: Text('ユーザB詳細'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<String> users = ['あなた', 'ユーザA', 'ユーザB'];
List<double> studyData = [0, 18, 46]; // 勉強時間
List<double> workData = [0, 10, 25];  // 仕事時間
List<double> exerciseData = [0, 10, 30]; // 運動時間

class WorkChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("動いています1");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return users[value.toInt()];
                },
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          barGroups: getBarGroups(),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < users.length; i++) {
      double y1 = studyData[i];
      double y2 = workData[i];
      double y3 = exerciseData[i];

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              y: y1,
              colors: [Colors.blue],
            ),
            BarChartRodData(
              y: y2,
              colors: [Colors.green],
            ),
            BarChartRodData(
              y: y3,
              colors: [Colors.orange],
            ),
          ],
          showingTooltipIndicators: [0, 1, 2],
        ),
      );
    }

    return barGroups;
  }
}

class UserDetailsScreen extends StatelessWidget {
  final String username;

  UserDetailsScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ユーザ名: $username'),
            // 他の詳細情報表示ウィジェットを追加できます
          ],
        ),
      ),
    );
  }
}
