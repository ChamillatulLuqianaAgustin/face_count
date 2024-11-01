import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'configs/firebase_options.dart';
import 'configs/theme.dart';
import 'features/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FaceCount',
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
