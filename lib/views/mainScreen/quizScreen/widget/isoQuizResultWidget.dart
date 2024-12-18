import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryWrapperPage.dart';

// class QuizResultWidget extends StatelessWidget {
//   final IsoQuizCategoryModel? isoquizcategorymodel;

//   const QuizResultWidget({
//     Key? key,
//     required this.isoquizcategorymodel,
//   }): super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Center(
//       child: Container(
//         height: 700,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           color: Colors.white
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Container(
//                 height: 350,
//                 width: 400,
//                 child: Center(
//                   child: Image.asset(
//                     'assets/images/result.png',
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 60,),
//             Text(
//               'Kuis Selesai',
//               style: LocalTextStyle.textTheme.titleMedium!.copyWith(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10,),
//             Text(
//               'Nilai kamu : 100',
//             ),
//             SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: SizedBox(
//               height: 50,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                    Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => QuizSubCategoryWrapperPage(
//                         quizCategory: isoquizcategorymodel!,
//                         id_quizCategory: isoquizcategorymodel!.id_quizCategory,
//                         isoquizcategorymodel: isoquizcategorymodel!,
//                       ),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: LocalColorsStyle.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 child: Text(
//                   'Selesai',
//                   style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class QuizResultWidget extends StatelessWidget {
  final IsoQuizCategoryModel? isoquizcategorymodel;

  const QuizResultWidget({
    Key? key,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isoquizcategorymodel == null) {
      // Bisa menampilkan pesan error atau UI lain jika model null
      return Center(
        child: Text('Data kategori kuis tidak tersedia'),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: 700,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 350,
                width: 400,
                child: Center(
                  child: Image.asset('assets/images/result.png'),
                ),
              ),
            ),
            SizedBox(height: 60),
            Text(
              'Kuis Selesai',
              style: LocalTextStyle.textTheme.titleMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Nilai kamu : 100',
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizSubCategoryWrapperPage(
                          quizCategory: isoquizcategorymodel!,
                          id_quizCategory: isoquizcategorymodel!.id_quizCategory,
                          isoquizcategorymodel: isoquizcategorymodel!,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LocalColorsStyle.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Selesai',
                    style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}