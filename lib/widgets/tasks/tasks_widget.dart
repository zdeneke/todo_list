import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final groupKey = ModalRoute.of(context)!.settings.arguments as int;
    if (groupKey != null) {
      return ChangeNotifierProvider(
          create: (context) => TaskWidgetModel(groupKey: groupKey),
          child: const TasksWidgetBody());
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
