import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/widgets/domain/entity/group.dart';

class TaskWidgetModel extends ChangeNotifier {
  int groupKey;

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
  }

  TaskWidgetModel({
    required this.groupKey,
  }) {
    _setup();
  }
}
