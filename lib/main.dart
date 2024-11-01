import 'package:face_count/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/firebase_options.dart';
import 'configs/theme.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/login_page.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              RepositoryProvider.of<AuthService>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'FaceCount',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Colors.transparent),
            scaffoldBackgroundColor: neutral50,
            primarySwatch: Colors.blue,
            fontFamily: 'SFProDisplay',
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MainScreen();
              }
              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
