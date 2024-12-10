import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/auth/cubit/acara_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class ScanResultPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             const SizedBox(width: 8),
//             Text(
//               'Hasil Scan',
//               style: mediumTS.copyWith(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Text(
//               'Partisipan',
//               style: regularTS.copyWith(
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               decoration: BoxDecoration(
//                 color: neutral50,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: neutral100,
//                   strokeAlign: BorderSide.strokeAlignOutside,
//                 ),
//               ),
//               child: Column(
//                 children: ListTile.divideTiles(
//                   context: context,
//                   color: neutral100,
//                   tiles: [
//                     ListTile(
//                       leading: const Icon(Icons.male),
//                       title: const Text('70 orang'),
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.female),
//                       title: const Text('30 orang'),
//                     ),
//                   ],
//                 ).toList(),
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               'Foto',
//               style: regularTS.copyWith(
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 16),
//             GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemCount: 9, // Adjust the number of photos as needed
//               itemBuilder: (context, index) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.asset(
//                     'assets/images/result_scan.png',
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ScanResultPage extends StatelessWidget {
  // Dummy data for scan results
  final List<String> scanResults = []; // Adjust with actual data fetching logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocBuilder<AcaraCubit, AcaraState>(
        builder: (context, state) {
          if (state is AcaraLoaded) {
            if (state.acaraList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/no_event.png'),
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
                  if (scanResults.isNotEmpty)
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: scanResults.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            scanResults[index],
                            fit: BoxFit.cover,
                          ),
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
    );
  }
}

