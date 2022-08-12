import 'package:bloc_pure/models/task.dart';

abstract class TaskState {
  List<Task> tasks;
  TaskState({
    required this.tasks,
  });
}

class TaskInitialState extends TaskState {
  // initial state, before loading and everything
  TaskInitialState() : super(tasks: []);
}

class TaskLoadingState extends TaskState {
  // initial state, before loading and everything
  TaskLoadingState() : super(tasks: []);
}

class TaskLoadingSucessState extends TaskState {
  TaskLoadingSucessState({required super.tasks});
}

class TaskLoadingErrorState extends TaskState {
  TaskLoadingErrorState() : super(tasks: []);
}
