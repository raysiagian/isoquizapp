import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class IsoQuizCategoryCardWidget extends StatelessWidget {
  const IsoQuizCategoryCardWidget({
    Key? key,
    required this.isoquizcategorymodel,
  }): super(key: key);

  final IsoQuizCategoryModel isoquizcategorymodel;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 100.0,
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: LocalColorsStyle.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isoquizcategorymodel.title,
              style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              isoquizcategorymodel.explanation,
              style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}