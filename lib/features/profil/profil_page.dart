import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/profil/edit_profile.dart';
import 'package:face_count/widgets/custom_button.dart';
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
                      'Ravi Wimar',
                      style: mediumTS.copyWith(fontSize: 16, color: neutral950),
                    ),
                    Text(
                      'raviwm@gmail.com',
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.lock_outline_rounded),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Ubah Password',
                        style:
                            mediumTS.copyWith(fontSize: 16, color: neutral950),
                      ),
                      Spacer(),
                      Image.asset('assets/icons/arrow_right.png')
                    ],
                  ),
                ),
                Divider(
                  color: neutral50,
                ),
                Padding(
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
                        style: mediumTS.copyWith(fontSize: 16, color: redBase),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/icons/arrow_right.png',
                        color: redBase,
                      )
                    ],
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
