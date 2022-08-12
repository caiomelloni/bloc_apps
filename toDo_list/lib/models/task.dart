class Task {
  bool isDone = false;
  final String _title;
  final int _id;

  Task({
    required int id,
    required String title,
  }) : _title = title, _id = id;

  String get title => _title;
  int get id => _id;
}
