import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizQuestionModel.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizQuestionWidget.dart';

class QuizQuestionPage extends StatefulWidget {
  final int id_quizCategory;

  const QuizQuestionPage({Key? key, required this.id_quizCategory}) : super(key: key);

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  late List<IsoQuizQuestionModel> questions = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    // Pastikan 'questions' diinisialisasi di sini
    questions = IsoQuizQuestionModel.listIsoQuizQuestion
        .where((question) => question.id_quizCategory == widget.id_quizCategory)
        .toList();
        
    questions.shuffle();
  }

  void _goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz ${widget.id_quizCategory} - Question ${currentQuestionIndex + 1}'),
      ),
      body: questions.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                children: [
                  // Display current question
                  Expanded(
                    child: QuisQuestionWidget(
                      isoquizquestionmodel: questions[currentQuestionIndex],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentQuestionIndex > 0)
                        ElevatedButton(
                          onPressed: _goToPreviousQuestion,
                          child: Text('Kembali'),
                        ),
                      if (currentQuestionIndex < questions.length - 1)
                        ElevatedButton(
                          onPressed: _goToNextQuestion,
                          child: Text('Selanjutnya'),
                        ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Text('No questions available for this category.'),
            ),
    );
  }
}
