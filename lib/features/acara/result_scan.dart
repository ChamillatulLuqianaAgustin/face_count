import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/acara/cubit/picture/picture_cubit.dart';
import 'package:face_count/features/acara/cubit/picture/picture_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanResultPage extends StatefulWidget {
  final String idAcara;
  const ScanResultPage({super.key, required this.idAcara});
  @override
  State<ScanResultPage> createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PictureCubit()..fetchPicture(widget.idAcara),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Hasil Scan',
                style: mediumTS.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<PictureCubit, PictureState>(
          builder: (context, state) {
            if (state is PictureLoaded) {
              if (state.photosUrl.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Empty_Acara.png',
                        scale: 3,
                      ),
                      Text(
                        'Belum ada hasil scan yang tercatat.',
                        style: mediumTS.copyWith(fontSize: 20),
                      ),
                      const Text(
                        'Lakukan scan pertama kamu sekarang!',
                        style: regularTS,
                      )
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text(
                      'Partisipan',
                      style: regularTS.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: neutral50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: neutral100,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Column(
                        children: ListTile.divideTiles(
                          context: context,
                          color: neutral100,
                          tiles: [
                            ListTile(
                              leading: const Icon(Icons.male),
                              title: const Text('70 orang'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.female),
                              title: const Text('30 orang'),
                            ),
                          ],
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Foto',
                      style: regularTS.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Check if there are scan results before showing GridView
                    if (state.photosUrl.isNotEmpty)
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: state.photosUrl.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            'http://103.161.185.147:5000/${state.photosUrl[index]}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  'Failed to load image',
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
