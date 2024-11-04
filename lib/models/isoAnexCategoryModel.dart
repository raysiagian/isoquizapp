class IsoAnexCategoryModel {
  final int id_category;
  final String title;
  final String explanation;

  IsoAnexCategoryModel({
    required this.id_category,
    required this.title,
    required this.explanation,
  });

  static final listIsoAnexCategory= [
    IsoAnexCategoryModel(
      id_category: 1, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoAnexCategoryModel(
      id_category: 2, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoAnexCategoryModel(
      id_category: 3, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
  ];
}