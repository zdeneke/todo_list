import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/widgets/domain/entity/group.dart';

class GroupsWidgetModel extends ChangeNotifier {
  var _groups = <Group>[];

  void showForm(BuildContext context) {
    Navigator.pushNamed(context, '/groups/form');
  }

  void showTasks(BuildContext context, int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    final groupKey = box.keyAt(groupIndex) as int;
    unawaited(
        Navigator.pushNamed(context, '/groups/tasks', arguments: groupKey));
  }

  List<Group> get groups => _groups.toList();

  GroupsWidgetModel() {
    _setup();
  }

  void deleteGroup(int index) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    await box.deleteAt(index);
  }

  void _radGroupsFromHive(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    _radGroupsFromHive(box);
    box.listenable().addListener(() => _radGroupsFromHive(box));
  }
}
