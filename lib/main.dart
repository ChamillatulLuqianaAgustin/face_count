import 'package:flutter/material.dart';

import 'configs/theme.dart';
import 'main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gender Detect',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        scaffoldBackgroundColor: neutral50,
        primarySwatch: Colors.blue,
        fontFamily: 'SFProDisplay',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
      },
    );
  }
}
