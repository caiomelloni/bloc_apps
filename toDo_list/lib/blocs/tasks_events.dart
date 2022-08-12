abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  String title;

  AddTaskEvent({
    required this.title,
  });
}

class ToogleTaskEvent extends TaskEvent {
  int id;
  ToogleTaskEvent({
    required this.id,
  });
}

class RemoveTaskEvent extends TaskEvent {
  int id;
  RemoveTaskEvent({
    required this.id,
  });
}
