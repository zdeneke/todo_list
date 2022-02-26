import 'package:flutter/material.dart';
import 'package:todo_list/widgets/group_form/group_form_widget.dart';
import 'package:todo_list/widgets/groups/groups_widget.dart';
import 'package:todo_list/widgets/task_form/task_form_widget_model.dart';
import 'package:todo_list/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/groups',
      routes: {
        '/groups': (_) => const GroupsWidget(),
        '/groups/form': (_) => const GroupFormWidget(),
        '/groups/tasks': (_) => const TasksWidget(),
        '/groups/tasks/form': (_) => const TaskFormWidget(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
