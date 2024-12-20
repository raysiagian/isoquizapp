import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizSubCategoryWrapperPage.dart';

class QuizCardWidget extends StatelessWidget {
  final IsoQuizCategoryModel isoquizcategorymodel;
  
  const QuizCardWidget({
    Key? key,
    required this.isoquizcategorymodel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizSubCategoryWrapperPage(
              isoquizcategorymodel: isoquizcategorymodel,
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
            color: LocalColorsStyle.primaryColor,
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
