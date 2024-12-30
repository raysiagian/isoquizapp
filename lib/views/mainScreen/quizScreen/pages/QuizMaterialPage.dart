import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizMaterialModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizQuestionPage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizMaterialWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QuizMaterialPage extends StatefulWidget {
  final IsoQuizSubCategoryModel isoquizsubcategorymodel;
  final int id_quizsubCategory;
  final IsoQuizCategoryModel isoquizcategorymodel;

  const QuizMaterialPage({
    Key? key,
    required this.id_quizsubCategory,
    required this.isoquizsubcategorymodel,
    required this.isoquizcategorymodel,
  }) : super(key: key);

  @override
  State<QuizMaterialPage> createState() => _QuizMaterialPageState();
}

class _QuizMaterialPageState extends State<QuizMaterialPage> {
  late Future<List<IsoQuizMaterialModel>> _materialFuture;

  @override
  void initState() {
    super.initState();
    _materialFuture = fetchMaterial();
  }

  Future<List<IsoQuizMaterialModel>> fetchMaterial() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedMaterial');

    if (cachedData != null) {
      final jsonData = jsonDecode(cachedData) as List<dynamic>;
      final cachedMaterial =
          jsonData.map((e) => IsoQuizMaterialModel.fromJson(e)).toList();

      refreshMaterialDataInBackground();

      return cachedMaterial;
    } else {
      final materialList = await fetchMaterialFromApi();
      await cacheMaterialData(materialList);
      return materialList;
    }
  }

  Future<List<IsoQuizMaterialModel>> fetchMaterialFromApi() async {
    try {
      final response = await http.get(Uri.parse(apiUrl + 'api/getMaterial'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
        return jsonData.map((e) => IsoQuizMaterialModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load material from API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching material: $e');
    }
  }

  Future<void> cacheMaterialData(List<IsoQuizMaterialModel> materialList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = materialList.map((e) => e.toJson()).toList();
    prefs.setString('cachedMaterial', jsonEncode(jsonData));
  }

  Future<void> refreshMaterialDataInBackground() async {
    try {
      final materialList = await fetchMaterialFromApi();
      await cacheMaterialData(materialList);
    } catch (e) {
      print("Background refresh failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isoquizsubcategorymodel.title),
      ),
     body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: FutureBuilder<List<IsoQuizMaterialModel>>(
          future: _materialFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final materials = snapshot.data!;
              if (materials.isEmpty) {
                return const Center(
                  child: Text('No materials available for this subcategory'),
                );
              }

              // Filter materials based on subcategory ID
              final filteredMaterials = materials
                  .where((material) =>
                      material.id_quizsubCategory ==
                      widget.isoquizsubcategorymodel.id_quizsubCategory)
                  .toList();

              if (filteredMaterials.isEmpty) {
                return const Center(
                  child: Text('Tidak ada material untuk subkategori ini.'),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  QuizMaterialWidget(
                    isoquizmaterialmodel: filteredMaterials[0], // Show first filtered material
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizQuestionPage(
                                 isoquizsubcategorymodel: widget.isoquizsubcategorymodel,
                                id_quizsubCategory: widget.id_quizsubCategory,
                                isoquizcategorymodel: widget.isoquizcategorymodel,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Mulai Test',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LocalColorsStyle.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}