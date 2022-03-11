import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/domain/data_provider/box_manadger.dart';
import 'package:todo_list/ui/navigation/main_navigaition.dart';
import 'package:todo_list/domain/entity/group.dart';
import 'package:todo_list/ui/widgets/tasks/tasks_widget.dart';

class GroupsWidgetModel extends ChangeNotifier {
  late final Future<Box<Group>> _box;
  ValueListenable<Box<Group>>? _listenableBox;

  var _groups = <Group>[];

  void showForm(BuildContext context) {
    Navigator.pushNamed(context, MainNavigaitionRouteNames.groupsForm);
  }

  Future<void> showTasks(BuildContext context, int groupIndex) async {
    final group = (await _box).getAt(groupIndex);
    if (group != null) {
      final configuration =
          TaskWidgetConfiguration(group.key as int, group.name);
      unawaited(Navigator.pushNamed(context, MainNavigaitionRouteNames.tasks,
          arguments: configuration));
    }
  }

  List<Group> get groups => _groups.toList();

  GroupsWidgetModel() {
    _setup();
  }

  Future<void> deleteGroup(int groupIndex) async {
    final box = await _box;
    final groupKey = (await _box).keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);

    await box.deleteAt(groupIndex);
  }

  Future<void> _readGroupsFromHive() async {
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openGroupBox();
    await _readGroupsFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readGroupsFromHive);
  }

  @override
  Future<void> dispose() async {
    await BoxManager.instance.closeBox(await _box);
    _listenableBox?.removeListener(_readGroupsFromHive);
    super.dispose();
  }
}
