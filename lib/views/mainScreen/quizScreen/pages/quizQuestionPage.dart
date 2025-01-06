import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizQuestionModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/models/isoUserModel.dart';
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
  int correctAnswers = 0; // Menyimpan jumlah jawaban benar
  late String _token; // Menyimpan token
  late User _loggedInUser; // Menyimpan data pengguna yang sedang login

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _loadTokenAndFetchUser(); // Memuat token dan data pengguna saat init
  }

  void _loadQuestions() {
    _questionFuture = fetchQuestions();
  }

  Future<List<IsoQuizQuestionModel>> fetchQuestions() async {
    // Logika untuk mengambil soal dari API atau cache
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedQuestion');

    if (cachedData != null) {
      final jsonData = jsonDecode(cachedData) as List<dynamic>;
      final cachedQuestions =
          jsonData.map((e) => IsoQuizQuestionModel.fromJson(e)).toList();
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
        throw Exception('Failed to load questions from API');
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

  // Menghitung nilai berdasarkan jumlah jawaban benar

  // Memuat token dan data pengguna saat aplikasi dijalankan
  _loadTokenAndFetchUser() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    if (token != null) {
      setState(() {
        _token = token;
      });

      try {
        final user = await fetchUser(token);
        setState(() {
          _loggedInUser = user;
        });

        await saveUserToCache(user);
      } catch (e) {
        final cachedUser = await loadUserFromCache();
        if (cachedUser != null) {
          setState(() {
            _loggedInUser = cachedUser;
          });
        }
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Mengambil data pengguna berdasarkan token
  Future<User> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse(apiUrl + 'api/user'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> saveUserToCache(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString('cachedUser', userData);
  }

  Future<User?> loadUserFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedUser');
    if (cachedData != null) {
      final jsonData = jsonDecode(cachedData);
      return User.fromJson(jsonData);
    }
    return null;
  }

  int calculateFinalScore(int totalQuestions) {
    if (totalQuestions == 0) return 0; // Hindari pembagian dengan nol
    return ((correctAnswers / totalQuestions) * 100).round();
  }

  /// Mengirim skor ke API
  Future<void> sendScore(
      int score, int idQuizCategory, int idQuizSubCategory) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl + 'api/sendScore/${widget.id_quizsubCategory}'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_User': _loggedInUser, // Gunakan ID user yang sedang login
          'id_quizCategory': idQuizCategory,
          'id_quizSubCategory': idQuizSubCategory,
          'score_Quiz': score,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Score successfully submitted.');
      } else {
        debugPrint('Failed to submit score. Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error while sending score: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz ${widget.isoquizcategorymodel.title}'),
      ),
      body: FutureBuilder<List<IsoQuizQuestionModel>>(
        future: _questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No questions available.'));
          }

          final questions = snapshot.data!;
          final filteredQuestions = questions
              .where((q) => q.id_quizSubCategory == widget.id_quizsubCategory)
              .toList();

          if (filteredQuestions.isEmpty) {
            return const Center(
                child: Text('No questions available for this subcategory.'));
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              children: [
                Expanded(
                  child: QuisQuestionWidget(
                    isoquizquestionmodel:
                        filteredQuestions[currentQuestionIndex],
                    onAnswerSelected: (isCorrect) {
                      if (isCorrect) {
                        setState(() {
                          correctAnswers++;
                        });
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentQuestionIndex > 0)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentQuestionIndex--;
                          });
                        },
                        child: const Text('Back'),
                      ),
                    if (currentQuestionIndex < filteredQuestions.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentQuestionIndex++;
                          });
                        },
                        child: const Text('Next'),
                      ),
                    if (currentQuestionIndex == filteredQuestions.length - 1)
                      ElevatedButton(
                        onPressed: () async {
                          final score = calculateFinalScore(
                              filteredQuestions.length);
                          await sendScore(score, widget.isoquizcategorymodel.id_quizCategory,
                              widget.id_quizsubCategory);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(
                                isoquizcategorymodel:widget.isoquizcategorymodel,
                                score: calculateFinalScore(filteredQuestions.length),
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