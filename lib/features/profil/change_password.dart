import 'package:face_count/configs/theme.dart';
import 'package:face_count/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  final _passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow_back.png',
            color: neutral950,
            width: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Ubah Password',
          style: mediumTS.copyWith(fontSize: 20, color: neutral950),
        ),
        titleSpacing: 0,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: neutral0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password Lama',
                  hint: 'Masukkan password lama',
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password Baru',
                  hint: 'Masukkan password baru',
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Lupa Password?',
                  style: mediumTS.copyWith(
                    fontSize: 16,
                    color: primaryBase,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
