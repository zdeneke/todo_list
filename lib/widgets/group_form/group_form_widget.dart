import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => GroupFormWidgetModel(),
        child: const _GroupFormWidgetBody());
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _GroupNameWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<GroupFormWidgetModel>(context, listen: false)
                .saveGroup(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerModel =
        Provider.of<GroupFormWidgetModel>(context, listen: false);
    return TextField(
        decoration: const InputDecoration(
          hintText: 'Group name',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => providerModel.groupName = value,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          providerModel.saveGroup(context);
        });
  }
}
