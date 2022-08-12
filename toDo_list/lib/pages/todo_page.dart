import 'package:bloc_pure/blocs/task_bloc.dart';
import 'package:bloc_pure/blocs/task_state.dart';
import 'package:bloc_pure/blocs/tasks_events.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final TaskBloc bloc;
  final newTaskTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = TaskBloc();
    bloc.inputEvent.add(LoadTasksEvent());
  }

  @override
  void dispose() {
    bloc.inputEvent.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: TextField(
                          controller: newTaskTextController,
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              bloc.inputEvent.add(
                                AddTaskEvent(title: newTaskTextController.text),
                              );
                              newTaskTextController.text = "";
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<TaskState>(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<TaskState> snapshot) {
            final taskList = snapshot.data?.tasks ?? [];

            if (snapshot.data is TaskLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data is TaskLoadingErrorState) {
              return const Center(
                child: Text("Erro ao carregar"),
              );
            }

            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(
                    taskList[index].id.toString(),
                  ),
                  onDismissed: (directions) => bloc.inputEvent.add(
                    RemoveTaskEvent(id: taskList[index].id),
                  ),
                  child: ListTile(
                    title: Text(taskList[index].title),
                    trailing: Checkbox(
                      checkColor: Colors.white,
                      value: taskList[index].isDone,
                      onChanged: (bool? value) {
                        bloc.inputEvent.add(
                          ToogleTaskEvent(id: taskList[index].id),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
