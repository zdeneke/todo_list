import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/data_provider/box_manadger.dart';
import 'package:todo_list/ui/navigation/main_navigaition.dart';

import 'package:todo_list/domain/entity/task.dart';
import 'package:todo_list/ui/widgets/tasks/tasks_widget.dart';

class TaskWidgetModel extends ChangeNotifier {
  final TaskWidgetConfiguration configuration;
  late final Future<Box<Task>> _box;
  ValueListenable<Box<Task>>? _listenableBox;
  var _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  Future<void> _readTasksFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    await _readTasksFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readTasksFromHive);
  }

  void showForm(BuildContext context) {
    Navigator.pushNamed(context, MainNavigaitionRouteNames.tasksForm,
        arguments: configuration.groupKey);
  }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  Future<void> doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();
  }

  TaskWidgetModel({
    required this.configuration,
  }) {
    _setup();
  }
  @override
  Future<void> dispose() async {
    await BoxManager.instance.closeBox(await _box);
    _listenableBox?.removeListener(_readTasksFromHive);

    super.dispose();
  }
}
