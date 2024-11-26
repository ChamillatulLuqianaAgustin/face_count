import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/profil/change_password.dart';
import 'package:face_count/features/profil/edit_profile.dart';
import 'package:face_count/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/cubit/auth_cubit.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  final isEventEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: mediumTS.copyWith(fontSize: 20, color: neutral950),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: neutral0,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: yellow50,
                  backgroundImage: AssetImage('assets/images/memoji.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.displayName.toString(),
                      style: mediumTS.copyWith(fontSize: 16, color: neutral950),
                    ),
                    Text(
                      user!.email.toString(),
                      style: regularTS.copyWith(color: neutral400),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 19),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: primaryBase,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/edit.png',
                          color: neutral0,
                          width: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Edit',
                          style:
                              mediumTS.copyWith(fontSize: 16, color: neutral0),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: neutral0,
            ),
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangePassword(),
                    ));
                  },
                  child: Ink(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline_rounded),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Ubah Password',
                          style: mediumTS.copyWith(
                              fontSize: 16, color: neutral950),
                        ),
                        Spacer(),
                        Image.asset('assets/icons/arrow_right.png')
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: neutral50,
                  height: 0,
                ),
                InkWell(
                    onTap: () => showDialog(
                          barrierDismissible: false,
                          // barrierColor: neutral400,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              alignment: Alignment.center,
                              contentPadding: EdgeInsets.all(0),
                              // actionsPadding: EdgeInsets.all(0),
                              // insetPadding: EdgeInsets.all(0),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: Container(
                                width: double.infinity,
                                height: 170,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: neutral0,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Anda yakin ingin keluar?',
                                      style: mediumTS.copyWith(fontSize: 18),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Anda dapat login kembali untuk mengakses akun Anda.',
                                      style: regularTS.copyWith(
                                        fontSize: 14,
                                        color: neutral400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<AuthCubit>()
                                                  .logout(); //action logut
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryBase,
                                                border: Border.all(
                                                    color: primaryBase,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Text(
                                                'Keluar',
                                                style: mediumTS.copyWith(
                                                  fontSize: 16,
                                                  color: neutral0,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: neutral950,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Text(
                                                'Batal',
                                                style: mediumTS.copyWith(
                                                  fontSize: 16,
                                                  color: neutral950,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    child: Ink(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/exit.png',
                              color: redBase,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Log Out',
                              style: mediumTS.copyWith(
                                  fontSize: 16, color: redBase),
                            ),
                            Spacer(),
                            Image.asset(
                              'assets/icons/arrow_right.png',
                              color: redBase,
                            )
                          ],
                        ))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
