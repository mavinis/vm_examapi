import 'package:flutter/material.dart';

import 'features/home/ui/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExamApi App',
      home: HomePage(),
    );
  }
}
