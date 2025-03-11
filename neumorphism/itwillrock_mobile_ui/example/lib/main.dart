import 'package:flutter/material.dart';
import 'menu_demo.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Kit Sample',
      theme: MaterialTheme.light(),
      darkTheme: MaterialTheme.dark(),
      home: const Main(),
    );
  }
}
