class IsoQuizSubCategoryModel {
  final int id_quizsubCategory;
  final String title;
  final String image;
  final int id_quizCategory;
  // final String explanation;

  IsoQuizSubCategoryModel({
    required this.id_quizsubCategory,
    required this.title,
    required this.image,
    required this.id_quizCategory,
    // required this.explanation,
  });

   static final listIsoQuizCategory = [
    IsoQuizSubCategoryModel(
      id_quizsubCategory: 1, 
      title: 'Computer Standarization 1',
      image:'1',
      id_quizCategory: 1, 
      // explanation: 'ISO standarization on computer'
    ),
    IsoQuizSubCategoryModel(
      id_quizsubCategory: 1, 
      title: 'Computer Standarization 2',
      image:'2',
      id_quizCategory: 1, 
      // explanation: 'ISO standarization on computer'
    ),
    IsoQuizSubCategoryModel(
      id_quizsubCategory: 1, 
      title: 'Computer Standarization 3',
      image:'3',
      id_quizCategory: 1, 
      // explanation: 'ISO standarization on computer'
    ),
  ];
}