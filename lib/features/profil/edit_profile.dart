import 'package:face_count/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:face_count/widgets/custom_button.dart';
import '../../configs/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  // final _phoneController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Mengisi controller dengan data pengguna yang ada saat ini
    _namaController.text = user?.displayName ?? '';
    _emailController.text = user?.email ?? '';
    // _phoneController.text = user?.phoneNumber ?? '';
  }

  Future<void> _updateProfile() async {
    try {
      if (_namaController.text.isNotEmpty) {
        // Memperbarui nama pengguna
        await user?.updateDisplayName(_namaController.text);
      }

      if (_emailController.text.isNotEmpty &&
          _emailController.text != user?.email) {
        // Memperbarui email pengguna (harus memverifikasi ulang)
        await user?.updateEmail(_emailController.text);
        await user?.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Verifikasi email telah dikirim ke email baru.')),
        );
      }

      // if (_phoneController.text.isNotEmpty && _phoneController.text != user?.phoneNumber) {
      //   // Memperbarui nomor telepon pengguna
      //   await _verifyPhoneNumber();
      // }

      // Menyimpan perubahan setelah berhasil memperbarui
      await user?.reload();
      setState(() {}); // Update UI dengan data baru

      // Memberikan umpan balik bahwa profil berhasil diperbarui
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil berhasil diperbarui')),
      );

      // Kembali ke halaman sebelumnya setelah berhasil menyimpan profil
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  // Future<void> _verifyPhoneNumber() async {
  //   String phoneNumber = _phoneController.text.trim();
  //   if (phoneNumber.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nomor telepon tidak boleh kosong')));
  //     return;
  //   }

  //   try {
  //     // Kirim kode verifikasi ke nomor telepon baru
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // Jika verifikasi otomatis berhasil, lakukan update
  //         await user?.updatePhoneNumber(credential);
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nomor telepon berhasil diperbarui')));
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verifikasi gagal: ${e.message}')));
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         String smsCode = ''; // Ambil kode SMS dari input pengguna

  //         // Membuat PhoneAuthCredential dengan verificationId dan smsCode
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //           verificationId: verificationId,
  //           smsCode: smsCode,
  //         );

  //         // Update nomor telepon dengan credential
  //         await user?.updatePhoneNumber(credential);
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nomor telepon berhasil diperbarui')));
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
  //   }
  // }

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
        titleSpacing: 0,
        title: Text(
          'Edit Profil',
          style: mediumTS.copyWith(fontSize: 20, color: neutral950),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 85,
                  backgroundColor: yellow50,
                  backgroundImage: AssetImage('assets/images/memoji.png'),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: primaryBase,
                  ),
                  child: Image.asset(
                    'assets/icons/camera.png',
                    color: neutral0,
                    width: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: neutral0,
            ),
            child: Column(
              children: [
                CustomTextField(
                  controller: _namaController,
                  label: 'Nama',
                  hint: user?.displayName ?? 'Nama Tidak Tersedia',
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: user?.email ?? 'Email Tidak Tersedia',
                ),
                const SizedBox(
                  height: 16,
                ),
                // CustomTextField(
                //   controller: _phoneController,
                //   label: 'Nomor Handphone',
                //   hint: user?.phoneNumber ?? 'Nomor Tidak Tersedia',
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        color: neutral0,
        child: CustomButton(
          text: 'Simpan', // Menampilkan tombol 'Simpan'
          onTap: _updateProfile, // Menjalankan fungsi untuk memperbarui profil
        ),
      ),
    );
  }
}
