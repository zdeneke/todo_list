import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/entity/group.dart';
import 'package:todo_list/domain/entity/task.dart';

class BoxManager {
  static final BoxManager instance = BoxManager();

  Future<Box<Group>> openGroupBox() async {
    return _openBox('group_box', 1, GroupAdapter());
  }

  Future<Box<Task>> openTaskBox() async {
    return _openBox('task_box', 2, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
      String name, int typeId, TypeAdapter<T> adapter) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.isAdapterRegistered(typeId);
    }
    return Hive.openBox<T>(name);
  }
}
