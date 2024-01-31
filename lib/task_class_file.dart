class Task {
  final int? id;
  final String title;
  final DateTime date;
  final double hours;
  final String genre;

  Task({this.id, required this.title, required this.date, required this.hours, required this.genre});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'hours': hours,
      'genre': genre,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      hours: map['hours'],
      genre: map['genre'],
    );
  }

  String get formattedDate {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
