import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/ui/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  final int groupKey;
  const TaskFormWidget({Key? key, required this.groupKey}) : super(key: key);

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskFormWidgetModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _model, child: const _TextFormWidgetBody());
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskFormWidgetModel>(context, listen: true);
    final actionButton = FloatingActionButton(
      onPressed: () => model.saveTask(context),
      child: const Icon(Icons.done),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('New task'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _TaskTextWidget(),
          ),
        ),
        floatingActionButton: model.isValid ? actionButton : null);
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerModel =
        Provider.of<TaskFormWidgetModel>(context, listen: false);
    return TextField(
        decoration: const InputDecoration(
          hintText: 'Task text',
          border: InputBorder.none,
        ),
        minLines: null,
        maxLines: null,
        expands: true,
        onChanged: (value) => providerModel.taskText = value,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          providerModel.saveTask(context);
        });
  }
}
