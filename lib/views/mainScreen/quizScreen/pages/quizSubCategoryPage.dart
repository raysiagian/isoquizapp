import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizSubCategoryCardWidget.dart';

class QuizSubCategoryPage extends StatelessWidget {
  final int id_quizCategory;

  const QuizSubCategoryPage({
    Key? key,
    required this.id_quizCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Filter subkategori berdasarkan id_quizCategory
    final filteredSubCategories = IsoQuizSubCategoryModel.listIsoQuizCategory
        .where((subcategory) => subcategory.id_quizCategory == id_quizCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subcategories',
          style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: filteredSubCategories.isEmpty
            ? Center(
                child: Text(
                  'No Subcategories Found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: filteredSubCategories.length,
                itemBuilder: (context, index) {
                  final subcategory = filteredSubCategories[index];
                  // Menggunakan IsoQuizSubCategoryCardWidget
                  return IsoQuizSubCategoryCardWidget(
                    isoquizsubcategorymodel: subcategory,
                  );
                },
              ),
      ),
    );
  }
}
