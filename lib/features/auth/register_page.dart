import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../main_screen.dart';
import 'cubit/auth_cubit.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is Authenticated) {
            final user = FirebaseAuth.instance.currentUser!;
            await user.updateDisplayName(_namaController.text);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          }
          if (state is AuthError) {
            print(state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Bagian Logo dan Selamat Datang
                Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                ),
                const SizedBox(height: 8),
                Text(
                  'Selamat Datang! 👋',
                  style: mediumTS.copyWith(fontSize: 24, color: neutral950),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Masuk ke FaceCount untuk memulai\nperjalanan Anda bersama kami!',
                  style: regularTS.copyWith(fontSize: 16, color: neutral400),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Bagian Form Login
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _namaController,
                        label: 'Nama',
                        hint: 'Masukkan nama',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Alamat Email',
                        hint: 'Masukkan alamat email',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Masukkan password',
                      ),

                      const SizedBox(height: 24),

                      // Register
                      state is AuthLoading
                          ? const CustomLoadingButton()
                          : CustomButton(
                              text: 'Register',
                              onTap: () => context.read<AuthCubit>().register(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                            ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Text.rich(
                  TextSpan(
                    text: 'Sudah punya akun? ',
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: regularTS.copyWith(
                            fontSize: 16, color: primaryBase),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                  style: regularTS.copyWith(fontSize: 16, color: neutral400),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
