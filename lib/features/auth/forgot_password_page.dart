import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/auth/login_page.dart';
import 'package:face_count/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../main_screen.dart';
import 'cubit/auth_cubit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/icons/arrow_back.png'),
                  color: neutral950,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
              children: [
                Text(
                  'Lupa Password?',
                  style: mediumTS.copyWith(fontSize: 24, color: neutral950),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Atur ulang kata sandi akun Anda',
                  style: regularTS.copyWith(fontSize: 16, color: neutral400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Form Reset Password
                Container(
                  padding: const EdgeInsets.all(12),
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
                        isRequired: true,
                      ),
                      const SizedBox(height: 24),

                      // Button Confirm
                      state is AuthLoading
                          ? const CustomLoadingButton()
                          : CustomButton(
                              text: 'Confirm',
                              onTap: () async {
                                final email = _emailController.text.trim();

                                if (email.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Email tidak boleh kosong'),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  await context
                                      .read<AuthService>()
                                      .resetPassword(email);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Email reset password telah dikirim'),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Gagal mengirim email reset password: $e'),
                                    ),
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
