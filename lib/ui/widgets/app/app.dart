import 'package:flutter/material.dart';
import 'package:todo_list/ui/navigation/main_navigaition.dart';

class MyApp extends StatelessWidget {
  static final mainNavigaition = MainNavigaition();
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: mainNavigaition.initialRoute,
      routes: mainNavigaition.routes,
      onGenerateRoute: mainNavigaition.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
