import 'package:flutter/cupertino.dart';
import 'package:todo_list/domain/data_provider/box_manadger.dart';
import 'package:todo_list/domain/entity/task.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskText = '';
  TaskFormWidgetModel({
    required this.groupKey,
  });
  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;
    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);

    box.add(task);
    // await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}
