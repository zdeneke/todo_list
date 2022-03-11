import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/ui/widgets/tasks/tasks_widget_model.dart';

class TaskWidgetConfiguration {
  final int groupKey;
  final String title;

  TaskWidgetConfiguration(this.groupKey, this.title);
}

class TasksWidget extends StatelessWidget {
  final TaskWidgetConfiguration configuration;
  const TasksWidget({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final groupKey = ModalRoute.of(context)!.settings.arguments as int;
    return ChangeNotifierProvider(
      create: (context) => TaskWidgetModel(configuration: configuration),
      child: const TasksWidgetBody(),
    );
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskWidgetModel>(context);
    final title = model.configuration.title;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksCount = Provider.of<TaskWidgetModel>(context).tasks.length;
    return ListView.separated(
      itemCount: tasksCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(
          indexInList: index,
        );
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskWidgetModel>(context, listen: false);
    final task = model.tasks[indexInList];
    final icon = task.isDone ? Icons.done : null;
    final style = task.isDone
        ? const TextStyle(
            decoration: TextDecoration.lineThrough,
          )
        : null;

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (_) => model.deleteTask(indexInList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.

      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(
            task.text,
            style: style,
          ),
          trailing: Icon(icon),
          onTap: () => model.doneToggle(indexInList),
        ),
      ),
    );
  }
}
