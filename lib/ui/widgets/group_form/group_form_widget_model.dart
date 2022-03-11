import 'package:flutter/cupertino.dart';
import 'package:todo_list/domain/data_provider/box_manadger.dart';
import 'package:todo_list/domain/entity/group.dart';

class GroupFormWidgetModel {
  var groupName = '';
  Future<void> saveGroup(BuildContext context) async {
    if (groupName.isEmpty) return;

    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: groupName);
    await box.add(group);
    // await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}
