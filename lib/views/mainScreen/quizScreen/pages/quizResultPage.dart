import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoquizResultWidget.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';

class ResultPage extends StatefulWidget {
  final IsoQuizCategoryModel? isoquizcategorymodel;

  const ResultPage({
    super.key,
    this.isoquizcategorymodel, // Nullable tanpa `required`
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
              child: widget.isoquizcategorymodel != null
                  ? QuizResultWidget(
                      isoquizcategorymodel: widget.isoquizcategorymodel,
                    )
                  : Text(
                      'Data kategori tidak tersedia.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
