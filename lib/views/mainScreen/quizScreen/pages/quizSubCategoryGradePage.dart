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
      print("User data fetched: $jsonData"); // Added debug print
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user: ${response.reasonPhrase}');
    }
  }

  Future<void> saveUserToCache(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString('cachedUser', userData);
    print("User data cached: $userData"); // Added debug print
  }

  Future<User?> loadUserFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedUser');
    if (cachedData != null) {
      final jsonData = jsonDecode(cachedData);
      print("Loaded cached user: $jsonData"); // Added debug print
      return User.fromJson(jsonData);
    }
    return null;
  }

  Future<void> getScore() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl + 'api/score/highest'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Score data fetched: $jsonData"); // Added debug print

        // Ubah data JSON menjadi list dari model IsoQuizSubCategoryGradeModel
        setState(() {
          _subCategoryGrades = List<IsoQuizSubCategoryGradeModel>.from(
            jsonData['data'].map((item) => IsoQuizSubCategoryGradeModel.fromJson(item))
          );
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _subCategoryGrades.isEmpty
              ? const Center(child: Text('No subcategories available'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _subCategoryGrades.length,
                  itemBuilder: (context, index) {
                    final item = _subCategoryGrades[index];
                    print("Displaying subcategory grade: ${item.score_Quiz}"); // Added debug print
                    return IsoQuizSubCategoryGradeCardWidget(
                      // Kirimkan data ke widget untuk ditampilkan
                      score: item.score_Quiz,
                      quizCategoryId: item.id_quizCategory,
                      subCategoryId: item.id_quizSubCategory,
                    );
                  },
                ),
    );
  }
}