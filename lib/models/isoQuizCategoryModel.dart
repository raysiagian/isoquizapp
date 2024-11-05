class IsoQuizCategoryModel {
  final int id_quizCategory;
  final String title;
  final String explanation;

  IsoQuizCategoryModel({
    required this.id_quizCategory,
    required this.title,
    required this.explanation,
  });

   static final listIsoQuizCategory = [
    IsoQuizCategoryModel(
      id_quizCategory: 1, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoQuizCategoryModel(
      id_quizCategory: 2, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoQuizCategoryModel(
      id_quizCategory: 3, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
  ];
}