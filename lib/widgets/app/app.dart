import 'package:flutter/material.dart';
import 'package:todo_list/widgets/groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/groups',
      routes: {'/groups': (_) => GroupsWidget()},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}