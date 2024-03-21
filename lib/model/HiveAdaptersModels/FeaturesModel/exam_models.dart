class ExamModel {
  final String study;
  final String subject;
  final List<TrueFalseQuestionsModel> trueFalseQuestions;
  final List<ChoiceQuestionsModel> choiceQuestions;
  String examDegree;

  ExamModel(
      {required this.study,
      required this.subject,
      required this.trueFalseQuestions,
      required this.choiceQuestions,
      this.examDegree = "لم يتم حل الأختبار حتى الآن"});
}

class TrueFalseQuestionsModel {
  String question;
  bool? answer;

  TrueFalseQuestionsModel({this.question = "", this.answer});
}

class ChoiceQuestionsModel {
  String question;
  final List<String> choiceLetter = ["a:", "b:", "c:", "d:"];
  List<String> choices;
  int? correctIndex;

  ChoiceQuestionsModel(
      {this.question = "", required this.choices, this.correctIndex});
}
