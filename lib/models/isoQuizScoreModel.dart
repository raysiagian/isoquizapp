class IsoQuizScoreModel{
  final int id_scoreQuiz;
  final int id_User;
  final int id_quizCategory;
  final int score_Quiz;

  IsoQuizScoreModel({
    required this.id_scoreQuiz,
    required this.id_User,
    required this.id_quizCategory,
    required this.score_Quiz,
  });

  static final listIsoQuizScore=[
    IsoQuizScoreModel(
      id_scoreQuiz: 1,
      id_User: 1,  
      id_quizCategory: 1, 
      score_Quiz: 80
    ),
    IsoQuizScoreModel(
      id_scoreQuiz: 2,
      id_User: 1,   
      id_quizCategory: 2, 
      score_Quiz: 80
    ),
    IsoQuizScoreModel(
      id_scoreQuiz: 3, 
      id_User: 1,
      id_quizCategory: 3, 
      score_Quiz: 80
    ),
    IsoQuizScoreModel(
      id_scoreQuiz: 4,
      id_User: 1,
      id_quizCategory: 4, 
      score_Quiz: 80
    ),
    IsoQuizScoreModel(
      id_scoreQuiz: 5,
      id_User: 1,
      id_quizCategory: 5, 
      score_Quiz: 80
    ),
  ];

}