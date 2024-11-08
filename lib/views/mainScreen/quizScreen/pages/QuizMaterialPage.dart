// QuizMaterialPage.dart
import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizMaterialModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizQuestionPage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizMaterialWidget.dart';

class QuizMaterialPage extends StatefulWidget {
  final IsoQuizCategoryModel isoquizcategorymodel;
  final int id_quizCategory;

  const QuizMaterialPage({
    Key? key,
    required this.id_quizCategory,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  @override
  State<QuizMaterialPage> createState() => _QuizMaterialPageState();
}

class _QuizMaterialPageState extends State<QuizMaterialPage> {
  late List<IsoQuizMaterialModel> questions;
  int currentMaterialIndex = 0;

  @override
  void initState() {
    super.initState();
    // Filter listIsoQuizMaterial berdasarkan id_quizCategory
    questions = IsoQuizMaterialModel.listIsoQuizMaterial
        .where((material) => material.id_quizCategory == widget.id_quizCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Anex ${currentMaterialIndex + 1}'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            if (questions.isNotEmpty)
              QuizMaterialWidget(isoquizmaterialmodel: questions[currentMaterialIndex])
            else
              const Center(
                child: Text('No materials available for this category'),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizQuestionPage(
                          id_quizCategory: widget.isoquizcategorymodel.id_quizCategory,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Mulai Test',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LocalColorsStyle.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Mengubah radius border tombol
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
