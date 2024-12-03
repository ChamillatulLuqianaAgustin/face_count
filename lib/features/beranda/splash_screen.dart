import 'dart:async';

import 'package:face_count/features/auth/login_page.dart';
import 'package:face_count/features/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../../../../core/common/colors.dart';
// import '../../../../core/common/fontstyles.dart';
import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/beranda/beranda_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Durations.extralong4, (timer) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MainScreen();
              }
              return const LoginPage();
            },
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral0,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 1,
            ),
            const SizedBox(height: 12),
            Text(
              'FaceCount',
              style: mediumTS.copyWith(fontSize: 30, color: neutral950),
            ),
          ],
        ),
      ),
    );
  }
}
