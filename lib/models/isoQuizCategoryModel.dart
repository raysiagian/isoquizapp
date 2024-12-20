class IsoQuizCategoryModel {
  final int id_quizCategory;
  final String title;
  final String image;
  // final String explanation;

  IsoQuizCategoryModel({
    required this.id_quizCategory,
    required this.title,
    required this.image,
    // required this.explanation,
  });


   static final listIsoQuizCategory = [
    IsoQuizCategoryModel(
      id_quizCategory: 1, 
      title: 'Bahasa',
      image:'1',
      // explanation: 'ISO standarization on computer'
    ),
    IsoQuizCategoryModel(
      id_quizCategory: 2, 
      title: 'Matematika',
      image:'2',
      // explanation: 'ISO standarization on computer'
    ),
    IsoQuizCategoryModel(
      id_quizCategory: 3, 
      title: 'Ips',
      image:'3',
      // explanation: 'ISO standarization on computer'
    ),
  ];
}