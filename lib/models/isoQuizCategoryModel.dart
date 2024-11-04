class IsoQuizCategoryModel {
  final int id_QuizCategory;
  final String title;
  final String explanation;

  IsoQuizCategoryModel({
    required this.id_QuizCategory,
    required this.title,
    required this.explanation,
  });

   static final listIsoQuizCategory= [
    IsoQuizCategoryModel(
      id_QuizCategory: 1, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoQuizCategoryModel(
      id_QuizCategory: 2, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
    IsoQuizCategoryModel(
      id_QuizCategory: 3, 
      title: 'Computer Standarization', 
      explanation: 'ISO standarization on computer'
    ),
  ];
}