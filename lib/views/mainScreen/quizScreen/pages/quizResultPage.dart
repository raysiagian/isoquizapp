import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoquizResultWidget.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';

class ResultPage extends StatefulWidget {
  final IsoQuizCategoryModel isoquizcategorymodel;

  const ResultPage({
    super.key,
    required this.isoquizcategorymodel,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: LocalColorsStyle.primaryColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 30, 
              left: screenWidth * 0.08, 
              right: screenWidth * 0.08,
            ),
            child: Center(
              child: QuizResultWidget(
                isoquizcategorymodel: widget.isoquizcategorymodel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
