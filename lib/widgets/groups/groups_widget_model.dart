import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/widgets/domain/entity/group.dart';

class GroupsWidgetModel extends ChangeNotifier {
  void showForm(BuildContext context) {
    Navigator.pushNamed(context, '/groups/form');
  }

  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  GroupsWidgetModel() {
    _setup();
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
