class IsoAnexCategoryModel {
  final int id_AnexCategory;
  final String title;
  final String explanation;

  IsoAnexCategoryModel({
    required this.id_AnexCategory,
    required this.title,
    required this.explanation,
  });

  static final listIsoAnexCategory= [
    IsoAnexCategoryModel(
      id_AnexCategory: 1, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoAnexCategoryModel(
      id_AnexCategory: 2, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoAnexCategoryModel(
      id_AnexCategory: 3, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
  ];
}