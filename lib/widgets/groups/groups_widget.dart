import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/widgets/groups/groups_widget_model.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GroupsWidgetModel(),
        child: const _GroupWidgetBody());
  }
}

class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: const SafeArea(
        child: _GroupListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<GroupsWidgetModel>(context, listen: false)
            .showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount = Provider.of<GroupsWidgetModel>(context).groups.length;
    return ListView.separated(
      itemCount: groupsCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return _GroupListRowWidget(
          indexInList: index,
        );
      },
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GroupsWidgetModel>(context, listen: false);
    final group = model.groups[indexInList];
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible:
            DismissiblePane(onDismissed: () => model.deleteGroup(indexInList)),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (_) => model.deleteGroup(indexInList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.

      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(group.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => model.showTasks(context, indexInList),
        ),
      ),
    );
  }
}
