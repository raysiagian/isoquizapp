import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoUserModel.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizSubCategoryGradeCardWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryGradeModel.dart';

class QuizSubCategoryGradePage extends StatefulWidget {

  final IsoQuizCategoryModel isoquizcategorymodel;
  final int id_quizCategory;

  const QuizSubCategoryGradePage({
 Key? key,
    required this.id_quizCategory,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  @override
  State<QuizSubCategoryGradePage> createState() => _QuizSubCategoryGradePageState();
}

class _QuizSubCategoryGradePageState extends State<QuizSubCategoryGradePage> {
  late String _token;
  User? _loggedInUser;
  bool _isLoading = true;
  List<IsoQuizSubCategoryGradeModel> _subCategoryGrades = [];

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    await _loadTokenAndFetchUser();
    if (_loggedInUser != null) {
      await _fetchSubCategoryGrades();
    }
  }

  Future<void> _loadTokenAndFetchUser() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');

    if (token != null) {
      _token = token;
      print("Token found: $token");

      try {
        final user = await fetchUser(token);
        setState(() {
          _loggedInUser = user;
        });
        await saveUserToCache(user);
        print("User data fetched and cached");
      } catch (e) {
        print("Error fetching user: $e");

        final cachedUser = await loadUserFromCache();
        if (cachedUser != null) {
          setState(() {
            _loggedInUser = cachedUser;
          });
          print("Loaded user from cache after error");
        } else {
          print("No cached user data available");
        }
      }
    } else {
      print("No token found, redirecting to login");
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  Future<User> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse(apiUrl + 'api/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user: ${response.reasonPhrase}');
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

  Future<void> _fetchSubCategoryGrades() async {
  final prefs = await SharedPreferences.getInstance();
  final cachedData = prefs.getString('cachedGrades');

  if (cachedData != null) {
    final jsonData = jsonDecode(cachedData) as List<dynamic>;
    final cachedGrades = jsonData
        .map((e) => IsoQuizSubCategoryGradeModel.fromJson(e))
        .toList();

    // Filter data berdasarkan id_quizCategory
    final filteredGrades = cachedGrades
        .where((subcategory) => subcategory.id_quizCategory == widget.id_quizCategory)
        .toList();

    setState(() {
      _subCategoryGrades = filteredGrades;
      _isLoading = false;
    });

    refreshGradesInBackground();
  } else {
    try {
      final gradesList = await fetchGradesFromApi();
      await cacheGradesData(gradesList);

      final filteredGrades = gradesList
          .where((subcategory) => subcategory.id_quizCategory == widget.id_quizCategory)
          .toList();

      setState(() {
        _subCategoryGrades = filteredGrades;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching grades: $e");
    }
  }
}


  // Future<void> _fetchSubCategoryGrades() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final cachedData = prefs.getString('cachedGrades');

  //   if (cachedData != null) {
  //     final jsonData = jsonDecode(cachedData) as List<dynamic>;
  //     final cachedGrades = jsonData
  //         .map((e) => IsoQuizSubCategoryGradeModel.fromJson(e))
  //         .toList();

  //     setState(() {
  //       _subCategoryGrades = cachedGrades;
  //       _isLoading = false;
  //     });

  //     refreshGradesInBackground();
  //   } else {
  //     try {
  //       final gradesList = await fetchGradesFromApi();
  //       await cacheGradesData(gradesList);

  //       setState(() {
  //         _subCategoryGrades = gradesList;
  //         _isLoading = false;
  //       });
  //     } catch (e) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print("Error fetching grades: $e");
  //     }
  //   }
  // }

  Future<List<IsoQuizSubCategoryGradeModel>> fetchGradesFromApi() async {
    final response = await http.get(
      Uri.parse(apiUrl + 'api/score/highest'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
      return jsonData
          .map((e) => IsoQuizSubCategoryGradeModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load grades from API: ${response.statusCode}');
    }
  }

  Future<void> cacheGradesData(List<IsoQuizSubCategoryGradeModel> gradesList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = gradesList.map((e) => e.toJson()).toList();
    prefs.setString('cachedGrades', jsonEncode(jsonData));
  }

  Future<void> refreshGradesInBackground() async {
    try {
      final gradesList = await fetchGradesFromApi();
      await cacheGradesData(gradesList);

      if (mounted) {
        setState(() {
          _subCategoryGrades = gradesList;
        });
      }
    } catch (e) {
      print("Background refresh failed: $e");
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _subCategoryGrades.isEmpty
              ? const Center(child: Text('No data available'))
              : FutureBuilder<List<IsoQuizSubCategoryGradeModel>>(
                  future: Future.delayed(
                    const Duration(milliseconds: 500),
                        () => _subCategoryGrades
                        .where((subcategory) =>
                            subcategory.id_quizCategory == widget.id_quizCategory)
                        .toList(),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/page not found.png',
                              height: 100,
                              width: 150,
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              'Konten tidak tersedia',
                              style: TextStyle(fontSize: 24, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Sepertinya belum ada konten saat ini, coba lagi nanti',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final filteredSubCategories = snapshot.data!
                      .where((subcategory) =>
                          subcategory.id_quizCategory == widget.id_quizCategory)
                      .toList();
                      print('Filtered SubCategories: $filteredSubCategories');

                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: filteredSubCategories.length,
                        itemBuilder: (context, index) {
                          final item = filteredSubCategories[index];
                          return IsoQuizSubCategoryGradeCardWidget(
                            subCategoryTitle: item.subCategoryTitle,
                            grade: item.highestScore,
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
    );
  }
}