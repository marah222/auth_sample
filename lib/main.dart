import 'package:flutter/material.dart';

import 'core/design_system/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign-Up Flow',
      theme: AppTheme.lightTheme,
      home: Scaffold(),
    );
  }
}
