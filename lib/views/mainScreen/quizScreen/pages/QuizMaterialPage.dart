import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/models/isoQuizMaterialModel.dart';
import 'package:quiz_iso_app/models/isoQuizSubCategoryModel.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizQuestionPage.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/widget/isoQuizMaterialWidget.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _materialFuture = fetchMaterial();
  }

  // Future<List<IsoQuizMaterialModel>> fetchMaterial() async {
  //   try {
  //     final url = Uri.parse(apiUrl + 'api/materialbyIdSubCategory?id_quizSubCategory=${widget.id_quizsubCategory}');
  //     print('Fetching materials from: $url');

  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
  //       return jsonData.map((e) => IsoQuizMaterialModel.fromJson(e)).toList();
  //     } else {
  //       throw Exception('Failed to load materials from API: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching materials: $e');
  //   }
  // }

    Future<List<IsoQuizMaterialModel>> fetchMaterial() async {
    try {
      final url = Uri.parse(apiUrl + 'api/materialbyIdSubCategory?id_quizSubCategory=${widget.id_quizsubCategory}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;

        // Kembalikan data yang berhasil diambil
        return jsonData.map((e) => IsoQuizMaterialModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load materials');
      }
    } catch (e) {
      print('Error fetching materials: $e');
      throw Exception('Error fetching materials');
    } finally {
      setState(() {
        _isLoading = false;  // Menandakan proses loading selesai
      });
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
            // Check for loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Loading materials... Please wait'),
                  ],
                ),
              );
            }

            // Check for errors in the fetching process
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            // Check if data is available
            if (snapshot.hasData) {
              final materials = snapshot.data!;
              if (materials.isEmpty) {
                return const Center(
                  child: Text('No materials available for this subcategory'),
                );
              }

              // Filter materials based on subcategory ID
              final filteredMaterials = materials
                  .where((material) =>
                      material.id_quizSubCategory == widget.isoquizsubcategorymodel.id_quizsubCategory)
                  .toList();

              if (filteredMaterials.isEmpty) {
                return const Center(
                  child: Text('No material found for this subcategory.'),
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
                          'Start Test',
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
            }

            // In case no data is found
            return const Center(
              child: Text('No data available'),
            );
          },
        ),
      ),
    );
  }
}
