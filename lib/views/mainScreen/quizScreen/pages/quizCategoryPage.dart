import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizCategoryCardWidget.dart';

class QuizCategoryPage extends StatefulWidget {
  const QuizCategoryPage({super.key});

  @override
  State<QuizCategoryPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizCategoryPage> {
  @override
  Widget build(BuildContext context) {
   final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          children: [
            Expanded(  // Tambahkan Expanded di sini
              child: ListView.builder(
                itemCount: IsoQuizCategoryModel.listIsoQuizCategory.length,
                itemBuilder: (context, index) {
                  final category = IsoQuizCategoryModel.listIsoQuizCategory[index];
                  return IsoQuizCategoryCardWidget(
                    isoquizcategorymodel: category,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
