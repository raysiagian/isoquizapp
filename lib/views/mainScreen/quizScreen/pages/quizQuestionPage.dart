import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizQuestionModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizResultPage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizQuestionWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_iso_app/static/apiUrl.dart';

class QuizQuestionPage extends StatefulWidget {
  final IsoQuizSubCategoryModel isoquizsubcategorymodel;
  final int id_quizsubCategory;
  final IsoQuizCategoryModel isoquizcategorymodel;

  const QuizQuestionPage({
    Key? key,
    required this.id_quizsubCategory,
    required this.isoquizcategorymodel,
    required this.isoquizsubcategorymodel,
  }) : super(key: key);

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  late Future<List<IsoQuizQuestionModel>> _questionFuture;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    _questionFuture = fetchQuestions();
  }

  Future<List<IsoQuizQuestionModel>> fetchQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedQuestion');

    if (cachedData != null) {
      final jsonData = jsonDecode(cachedData) as List<dynamic>;
      print('Data from API: $jsonData');
      final cachedQuestions =
          jsonData.map((e) => IsoQuizQuestionModel.fromJson(e)).toList();

      refreshQuestionsInBackground();
      return cachedQuestions;
    } else {
      final questions = await fetchQuestionsFromApi();
      await cacheQuestions(questions);
      return questions;
    }
  }

  Future<List<IsoQuizQuestionModel>> fetchQuestionsFromApi() async {
    try {
      final response = await http.get(Uri.parse(apiUrl + 'api/getQuestion'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
        return jsonData.map((e) => IsoQuizQuestionModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load questions from API  ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }

  Future<void> cacheQuestions(List<IsoQuizQuestionModel> questions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = questions.map((e) => e.toJson()).toList();
    prefs.setString('cachedQuestion', jsonEncode(jsonData));
  }

  Future<void> refreshQuestionsInBackground() async {
    try {
      final questions = await fetchQuestionsFromApi();
      await cacheQuestions(questions);
    } catch (e) {
      debugPrint('Failed to refresh questions in the background: $e');
    }
  }

  void _goToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
    });
  }

  void _goToPreviousQuestion() {
    setState(() {
      currentQuestionIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          //'Quiz ${widget.isoquizcategorymodel.title} - Question ${currentQuestionIndex + 1}',
          'Quiz ${widget.isoquizcategorymodel.title}',
        ),
      ),
      body: FutureBuilder<List<IsoQuizQuestionModel>>(
        future: _questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading questions: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Questions not available, please try again later'),
            );
          }

          final questions = snapshot.data!;
          final filteredQuestions = questions
              .where((q) => q.id_quizSubCategory == widget.id_quizsubCategory)
              .toList();

          if (filteredQuestions.isEmpty) {
            return const Center(
              child: Text('No questions available for this subcategory'),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              children: [
                Expanded(
                  child: QuisQuestionWidget(
                    isoquizquestionmodel: filteredQuestions[currentQuestionIndex],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentQuestionIndex > 0)
                      ElevatedButton(
                        onPressed: _goToPreviousQuestion,
                        child: const Text('Back'),
                      ),
                    if (currentQuestionIndex < filteredQuestions.length - 1)
                      ElevatedButton(
                        onPressed: _goToNextQuestion,
                        child: const Text('Next'),
                      ),
                    if (currentQuestionIndex == filteredQuestions.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(
                                isoquizcategorymodel: widget.isoquizcategorymodel,
                              ),
                            ),
                          );
                        },
                        child: const Text('Finish'),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
