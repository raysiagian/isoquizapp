import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class IsoQuizSubCategoryGradeCardWidget extends StatelessWidget {

  final int score;
  final int quizCategoryId;
  final int subCategoryId;

  const IsoQuizSubCategoryGradeCardWidget({
    super.key,
    required this.score,
    required this.quizCategoryId,
    required this.subCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category ID: $quizCategoryId, Subcategory ID: $subCategoryId',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Score: $score',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
