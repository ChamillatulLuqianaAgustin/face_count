import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/auth/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../main_screen.dart';
import 'cubit/auth_cubit.dart';
import 'register_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
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
                  'Lupa Password?',
                  style: mediumTS.copyWith(fontSize: 24, color: neutral950),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                Text(
                  'Atur ulang kata sandi akun anda',
                  style: regularTS.copyWith(fontSize: 16, color: neutral400),
                  textAlign: TextAlign.left ,
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
                        controller: _emailController,
                        label: 'Alamat Email',
                        hint: 'Masukkan alamat email',
                      ),
                      const SizedBox(height: 16),

                      // Lupa password
                     

                      const SizedBox(height: 24),

                      // Button (based on state)
                      state is AuthLoading
                          ? const CustomLoadingButton()
                          : CustomButton(
                              text: 'Confirm',
                              onTap: () => context.read<AuthCubit>().login(
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
                    text: 'Ingat kata sandi anda? ',
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
