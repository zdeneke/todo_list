import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/ui/widgets/domain/entity/task.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  HiveList<Task>? tasks;
  Group({
    required this.name,
  });

  void addTasks(Box<Task> box, Task task) {
    tasks ??= HiveList(box);
    tasks?.add(task);
    save();
  }
}
