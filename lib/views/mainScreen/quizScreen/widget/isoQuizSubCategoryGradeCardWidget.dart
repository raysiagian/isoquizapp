import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class IsoQuizSubCategoryGradeCardWidget extends StatelessWidget {
  const IsoQuizSubCategoryGradeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Container(
        width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // subcategory title
                'Belajar Bahasa Dasar',
                style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                // grade
                '90',
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