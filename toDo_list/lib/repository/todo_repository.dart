import 'package:bloc_pure/models/task.dart';

class TodoRepository {
  final List<Task> _tasks = [];
  int _nextId = 0;

  Future<List<Task>> loadTasks() async {
    _tasks.addAll([
      Task(id: 1, title: "go to the gym"),
      Task(id: 2, title: 'clean the house'),
      Task(id: 3, title: "call mom"),
      Task(id: 4, title: 'feed the dog'),
    ]);

    _nextId = 5;

    await Future.delayed(const Duration(seconds: 3));

    return [..._tasks];
  }

  List<Task> addTask(String title) {
    _tasks.add(Task(id: _nextId, title: title));
    _nextId++;

    return [..._tasks];
  }

  List<Task> removeTask(int id) {
    for (var task in _tasks) {
      if (task.id == id) {
        _tasks.remove(task);
        break;
      }
    }

    return [..._tasks];
  }

  List<Task> toogleTaskCheck(int id) {
        for (var task in _tasks) {
      if (task.id == id) {
        task.isDone = !task.isDone;
        break;
      }
    }

    return [..._tasks];
  }
}
