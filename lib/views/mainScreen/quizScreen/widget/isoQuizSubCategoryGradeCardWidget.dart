import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class IsoQuizSubCategoryGradeCardWidget extends StatelessWidget {
  final String subCategoryTitle;
  final int grade;

  const IsoQuizSubCategoryGradeCardWidget({
    super.key,
    required this.subCategoryTitle,
    required this.grade,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subCategoryTitle,
              style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              grade.toString(),
              style: LocalTextStyle.textTheme.bodyLarge!.copyWith(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
