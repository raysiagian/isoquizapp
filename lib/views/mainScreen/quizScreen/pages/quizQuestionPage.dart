import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizQuestionModel.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizResultPage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizQuestionWidget.dart';

class QuizQuestionPage extends StatefulWidget {
  final int id_quizsubCategory;
  final IsoQuizCategoryModel isoquizcategorymodel; // Add this parameter

  const QuizQuestionPage({
    Key? key,
    required this.id_quizsubCategory,
    required this.isoquizcategorymodel, // Include it in the constructor
  }) : super(key: key);

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
        .where((question) => question.id_quizsubCategory == widget.id_quizsubCategory)
        .toList();
        
    questions.shuffle();
  }

// Indexing Halaman 

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
        title: Text('Quiz ${widget.id_quizsubCategory} - Question ${currentQuestionIndex + 1}'),
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
                        if (currentQuestionIndex == questions.length -1) 
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(
                               isoquizcategorymodel: widget.isoquizcategorymodel,
                              ),
                            ),
                          );
                          } , //arakhkan kehalaman
                          child: Text('Selesaikan'),
                        ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Text('Pertanyaan tidak tersedia, coba lagi nanti'),
            ),
    );
  }
}
