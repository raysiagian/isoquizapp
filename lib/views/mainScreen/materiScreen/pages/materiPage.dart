import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoAnexCategoryModel.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/materiScreen/widget/isoAnexCategoryCardWidget.dart';

class MateriCategoryPage extends StatefulWidget {
  const MateriCategoryPage({super.key});

  @override
  State<MateriCategoryPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anex',
          style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          children: [
            Expanded(  // Tambahkan Expanded di sini
              child: ListView.builder(
                itemCount: IsoAnexCategoryModel.listIsoAnexCategory.length,
                itemBuilder: (context, index) {
                  final category = IsoAnexCategoryModel.listIsoAnexCategory[index];
                  return IsoAnexCategoryCardWidget(
                    isoanexcategorymodel: category,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
