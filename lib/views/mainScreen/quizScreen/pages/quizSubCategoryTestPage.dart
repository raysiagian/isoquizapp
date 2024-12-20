import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizSubCategoryCardWidget.dart';

class QuizSubCategoryTestPage extends StatelessWidget {
  final IsoQuizCategoryModel isoquizcategorymodel;
  final int id_quizCategory;

  const QuizSubCategoryTestPage({
    Key? key,
    required this.id_quizCategory,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Filter subkategori berdasarkan id_quizCategory
    final filteredSubCategories = IsoQuizSubCategoryModel.listIsoQuizCategory
        .where((subcategory) => subcategory.id_quizCategory == id_quizCategory)
        .toList();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: screenWidth * 0.08, right: screenWidth * 0.08),
        child: filteredSubCategories.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/page not found.png',
                      height: 100,
                      width: 150,
                    ),
                    const SizedBox(height: 40,),
                    const Text(
                      'Konten tidak tersedia',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Sepertinya belum ada content saat ini, cobalagi nanti',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: filteredSubCategories.length,
                itemBuilder: (context, index) {
                  final subcategory = filteredSubCategories[index];
                  // Menggunakan IsoQuizSubCategoryCardWidget
                  return IsoQuizSubCategoryCardWidget(
                    isoquizcategorymodel: isoquizcategorymodel,
                    isoquizsubcategorymodel: subcategory,
                  );
                },
              ),
      ),
    );
  }
}
