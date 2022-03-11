import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/group_form/group_form_widget.dart';
import 'package:todo_list/ui/widgets/groups/groups_widget.dart';
import 'package:todo_list/ui/widgets/task_form/task_form_widget.dart';
import 'package:todo_list/ui/widgets/tasks/tasks_widget.dart';

abstract class MainNavigaitionRouteNames {
  static const groups = '/';
  static const groupsForm = '/groupsForm';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}

class MainNavigaition {
  final initialRoute = MainNavigaitionRouteNames.groups;
  final routes = {
    MainNavigaitionRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigaitionRouteNames.groupsForm: (context) => const GroupFormWidget(),
  };
  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigaitionRouteNames.tasks:
        final configuration = settings.arguments as TaskWidgetConfiguration;
        return MaterialPageRoute(
            builder: (context) => TasksWidget(
                  configuration: configuration,
                ));
      case MainNavigaitionRouteNames.tasksForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => TaskFormWidget(groupKey: groupKey));
      default:
        const widget = Text('Navigator Error');
        return MaterialPageRoute(
          builder: (context) => widget,
        );
    }
  }
}
