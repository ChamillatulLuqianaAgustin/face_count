import 'package:face_count/configs/theme.dart';
import 'package:face_count/widgets/custom_textfield.dart';
import 'package:face_count/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Menggunakan provider untuk mengakses AuthService
import '../../../services/auth_service.dart'; // Sesuaikan path sesuai dengan struktur project Anda

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      String oldPassword = _oldPasswordController.text.trim();
      String newPassword = _newPasswordController.text.trim();

      await authService.changePassword(
        currentPassword: oldPassword,
        newPassword: newPassword,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password berhasil diubah')),
      );

      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah berhasil
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
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
                  controller: _oldPasswordController,
                  label: 'Password Lama',
                  hint: 'Masukkan password lama',
                  isRequired: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _newPasswordController,
                  label: 'Password Baru',
                  hint: 'Masukkan password baru',
                  isRequired: true,
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
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        color: neutral0,
        child: CustomButton(
          text: 'Simpan',
          onTap: _changePassword,
        ),
      ),
    );
  }
}
