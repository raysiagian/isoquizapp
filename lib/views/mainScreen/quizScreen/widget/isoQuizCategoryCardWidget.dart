import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizMaterialPage.dart';

class IsoQuizCategoryCardWidget extends StatelessWidget {
  const IsoQuizCategoryCardWidget({
    Key? key,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  final IsoQuizCategoryModel isoquizcategorymodel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizMaterialPage(
              id_quizCategory: isoquizcategorymodel.id_quizCategory, isoquizcategorymodel: isoquizcategorymodel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Container(
          height: 100.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isoquizcategorymodel.title,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                isoquizcategorymodel.explanation,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
