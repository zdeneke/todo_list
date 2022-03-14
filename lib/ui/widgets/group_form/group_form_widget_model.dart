import 'package:flutter/cupertino.dart';
import 'package:todo_list/domain/data_provider/box_manadger.dart';
import 'package:todo_list/domain/entity/group.dart';

class GroupFormWidgetModel extends ChangeNotifier {
  var _groupName = '';
  String? errorText;

  set groupName(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _groupName = value;
  }

  Future<void> saveGroup(BuildContext context) async {
    final groupName = this._groupName.trim();
    if (groupName.isEmpty) {
      errorText = 'Enter group name';
      notifyListeners();
      return;
    }

    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: groupName);
    await box.add(group);
    // await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}
