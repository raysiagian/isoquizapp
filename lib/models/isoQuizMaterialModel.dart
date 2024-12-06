class IsoQuizMaterialModel {
  final int id_quizMaterial;
  final int id_quizsubCategory;
  final String title;
  final String data;

  IsoQuizMaterialModel({
    required this.id_quizMaterial,
    required this.id_quizsubCategory,
    required this.title,
    required this.data,
  });

  static final listIsoQuizMaterial = [
    IsoQuizMaterialModel(
      id_quizMaterial: 1, 
      id_quizsubCategory: 1, 
      title: 'Penetapan Peram dan Tanggung Jawab Keamanan Informasi dalam ISO 27001:2022', 
      data: 'Penetapan Peram dan Tanggung Jawab Keamanan Informasi dalam ISO 27001:2022',
    ),
     IsoQuizMaterialModel(
      id_quizMaterial: 2, 
      id_quizsubCategory: 2, 
      title: 'Penetapan Peram dan Tanggung Jawab Keamanan Informasi dalam ISO 27001:2022', 
      data: 'Penetapan Peram dan Tanggung Jawab Keamanan Informasi dalam ISO 27001:2022',
    ),
     IsoQuizMaterialModel(
      id_quizMaterial: 3, 
      id_quizsubCategory: 3, 
      title: 'Penetapan Peram dan Tanggung Jawab Keamanan Informasi dalam ISO 27001:2022', 
      data: 'Penetapan Peram dan Tanggung Jawab Keamanan Informasi dalam ISO 27001:2022',
    ),
  ];

}