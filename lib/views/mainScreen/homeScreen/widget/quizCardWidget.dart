import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryPage.dart';

class QuizCardWidget extends StatelessWidget {
  const QuizCardWidget({
    Key? key,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  final IsoQuizCategoryModel isoquizcategorymodel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizSubCategoryPage(
              id_quizCategory: isoquizcategorymodel.id_quizCategory, // Kirim ID
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: double.infinity,
          height: 150.0,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isoquizcategorymodel.title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
