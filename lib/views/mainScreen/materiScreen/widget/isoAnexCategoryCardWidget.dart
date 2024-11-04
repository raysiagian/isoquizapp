import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoAnexCategoryModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

class IsoAnexCategoryCardWidget extends StatelessWidget {
  const IsoAnexCategoryCardWidget({
    Key? key,
    required this.isoanexcategorymodel,
  }): super(key: key);

  final IsoAnexCategoryModel isoanexcategorymodel;

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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isoanexcategorymodel.title,
              style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              isoanexcategorymodel.explanation,
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