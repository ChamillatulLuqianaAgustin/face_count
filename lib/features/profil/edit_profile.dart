import 'package:face_count/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../configs/theme.dart';
// import 'package:face_count/features/acara/scan_pengunjung.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final isEventEmpty = false;

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
                  hint: user!.displayName.toString(),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: user!.email.toString(),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _phoneController,
                  label: 'Nomor Handphone',
                  hint: user!.phoneNumber.toString(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
