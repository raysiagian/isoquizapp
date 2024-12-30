import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizSubCategoryCardWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QuizSubCategoryTestPage extends StatefulWidget {
  final IsoQuizCategoryModel isoquizcategorymodel;
  final int id_quizCategory;

  const QuizSubCategoryTestPage({
    Key? key,
    required this.id_quizCategory,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  @override
  _QuizSubCategoryTestPageState createState() => _QuizSubCategoryTestPageState();
}

class _QuizSubCategoryTestPageState extends State<QuizSubCategoryTestPage> {
  late Future<List<IsoQuizSubCategoryModel>> _subCategoriesFuture;

  @override
  void initState() {
    super.initState();
    _subCategoriesFuture = fetchSubCategory();
  }

  Future<List<IsoQuizSubCategoryModel>> fetchSubCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedSubCategories');

    if (cachedData != null) {
      // Parse data dari cache
      final jsonData = jsonDecode(cachedData) as List<dynamic>;
      final cachedSubCategories =
          jsonData.map((e) => IsoQuizSubCategoryModel.fromJson(e)).toList();

      // Lakukan refresh cache di latar belakang
      refreshSubCategoryDataInBackground();

      // Kembalikan data cache
      return cachedSubCategories;
    } else {
      // Jika tidak ada cache, fetch dari API
      final subcategoryList = await fetchSubCategoryFromApi();
      await cacheSubCategoryData(subcategoryList);
      return subcategoryList;
    }
  }

  Future<List<IsoQuizSubCategoryModel>> fetchSubCategoryFromApi() async {
    try {
      final response = await http.get(Uri.parse(apiUrl + 'api/getSubCategory'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
        return jsonData.map((e) => IsoQuizSubCategoryModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load subcategory from API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching subcategory: $e');
    }
  }

  Future<void> cacheSubCategoryData(
      List<IsoQuizSubCategoryModel> subcategoryList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = subcategoryList.map((e) => e.toJson()).toList();
    prefs.setString('cachedSubCategories', jsonEncode(jsonData));
  }

  Future<void> refreshSubCategoryDataInBackground() async {
    try {
      final subcategoryList = await fetchSubCategoryFromApi();
      await cacheSubCategoryData(subcategoryList);
    } catch (e) {
      print("Background refresh failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<List<IsoQuizSubCategoryModel>>(
        future: _subCategoriesFuture,
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
          } else {
            final filteredSubCategories = snapshot.data!
                .where((subcategory) =>
                    subcategory.id_quizCategory == widget.id_quizCategory)
                .toList();

            return Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: screenWidth * 0.08,
                right: screenWidth * 0.08,
              ),
              child: ListView.builder(
                itemCount: filteredSubCategories.length,
                itemBuilder: (context, index) {
                  final subcategory = filteredSubCategories[index];
                  return IsoQuizSubCategoryCardWidget(
                    isoquizcategorymodel: widget.isoquizcategorymodel,
                    isoquizsubcategorymodel: subcategory,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
