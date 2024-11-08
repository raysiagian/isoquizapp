// QuizMaterialWidget.dart
import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizMaterialModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class QuizMaterialWidget extends StatelessWidget {
  const QuizMaterialWidget({
    Key? key,
    required this.isoquizmaterialmodel,
  }) : super(key: key);

  final IsoQuizMaterialModel isoquizmaterialmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isoquizmaterialmodel.title,
          style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          isoquizmaterialmodel.data,
          style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
