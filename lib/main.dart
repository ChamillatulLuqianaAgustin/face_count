import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/auth/cubit/picture_cubit.dart';
import 'package:face_count/features/beranda/splash_screen.dart';
import 'package:face_count/services/acara_service.dart';
import 'package:face_count/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'configs/firebase_options.dart';
import 'configs/theme.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/login_page.dart';
import 'features/main_screen.dart';

Future<void> main() async {
  await initializeDateFormatting('id_ID', null);
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
        RepositoryProvider(
          create: (context) => AcaraService(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              RepositoryProvider.of<AuthService>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AcaraCubit(
              RepositoryProvider.of<AcaraService>(context),
            ),
          ),
          BlocProvider(
            create: (context) => PictureCubit(
              RepositoryProvider.of<AcaraService>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FaceCount',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Colors.transparent),
            scaffoldBackgroundColor: neutral50,
            primarySwatch: Colors.blue,
            fontFamily: 'SFProDisplay',
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
