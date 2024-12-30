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

   factory IsoQuizMaterialModel.fromJson(Map<String, dynamic> json) {
    return IsoQuizMaterialModel(
      id_quizMaterial: json["id_quizMaterial"] as int,
      id_quizsubCategory: json["id_quizsubCategory"] as int,
      title: json["title"] as String,
      data: json["data"] as String,
      // image: json["imageCard"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_quizMaterial': id_quizMaterial,
    'id_quizsubCategory': id_quizsubCategory,
    'title': title,
    'data': data,
    //'imageCard': imageCard,
  };

  @override
  String toString() {
    return 'IsoQuizCategoryModel{id_quizsubCategory: $id_quizsubCategory, id_quizMaterial: $id_quizMaterial, title: $title, data: $data}';
  }
}