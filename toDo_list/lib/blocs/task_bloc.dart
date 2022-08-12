import 'dart:async';

import 'package:bloc_pure/blocs/task_state.dart';
import 'package:bloc_pure/blocs/tasks_events.dart';
import 'package:bloc_pure/models/task.dart';
import 'package:bloc_pure/repository/todo_repository.dart';

class TaskBloc {
  final _taskRepo = TodoRepository();

  final StreamController<TaskEvent> _inputTaskController =
      StreamController<TaskEvent>();
  final StreamController<TaskState> _outputTaskController =
      StreamController<TaskState>();

  Sink<TaskEvent> get inputEvent => _inputTaskController.sink;
  Stream<TaskState> get stream => _outputTaskController.stream;

  TaskBloc() {
    _inputTaskController.stream.listen(_mapEventToState);
  }

  Future<void> _mapEventToState(TaskEvent event) async {
    List<Task> tasks = [];

    if (event is LoadTasksEvent) {
      _outputTaskController.add(TaskLoadingState());
      try {
        tasks = await _taskRepo.loadTasks();
      } catch (e) {
        _outputTaskController.add(TaskLoadingErrorState());
      }
    } else if (event is AddTaskEvent) {
      tasks = _taskRepo.addTask(event.title);
    } else if (event is RemoveTaskEvent) {
      tasks = _taskRepo.removeTask(event.id);
    } else if (event is ToogleTaskEvent) {
      tasks = _taskRepo.toogleTaskCheck(event.id);
    }

    _outputTaskController.add(
      TaskLoadingSucessState(tasks: tasks),
    );
  }
}
