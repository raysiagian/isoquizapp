import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizMaterialPage.dart';

class IsoQuizSubCategoryCardWidget extends StatelessWidget {
  final IsoQuizSubCategoryModel isoquizsubcategorymodel;
  final IsoQuizCategoryModel isoquizcategorymodel;

  const IsoQuizSubCategoryCardWidget({
    Key? key,
    required this.isoquizsubcategorymodel,
    required this.isoquizcategorymodel,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizMaterialPage(
              isoquizcategorymodel: isoquizcategorymodel,
              id_quizsubCategory: isoquizsubcategorymodel.id_quizsubCategory, isoquizsubcategorymodel: isoquizsubcategorymodel,
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
                isoquizsubcategorymodel.title,
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 7),
              // Text(
              //   isoquizsubcategorymodel.explanation,
              //   style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
              //     color: Colors.brown,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
