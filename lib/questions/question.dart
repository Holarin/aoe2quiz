import 'package:aoe2quiz/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String type;
  String text;
  String metaData;
  String firstAnswer;
  String secondAnswer;
  String thirdAnswer;
  String fourthAnswer;
  String rightAnswer;
  String age;

  Question({
    required this.type,
    required this.text,
    required this.metaData,
    required this.firstAnswer,
    required this.secondAnswer,
    required this.thirdAnswer,
    required this.fourthAnswer,
    required this.rightAnswer,
    required this.age,
  });

  String getRightAnswer() {
    switch(rightAnswer) {
      case '1':
        return firstAnswer;
      case '2':
        return secondAnswer;
      case '3':
        return thirdAnswer;
      case '4':
        return fourthAnswer;
      default:
        return '';
    }
  }

  static Future<List<Question>> getQuestions(String age) async {
    List<Question> que = [];
    List<String> qs = [];
    int count = 25;
    switch(age) {
      case '1':
        AppQuizState.firstAgeQuestions.shuffle();
        qs = AppQuizState.firstAgeQuestions;
        count = 25;
        break;
      case '2':
        AppQuizState.firstAgeQuestions.shuffle();
        qs = AppQuizState.secondAgeQuestions;
        count = 20;
        break;
      case '3':
        AppQuizState.firstAgeQuestions.shuffle();
        qs = AppQuizState.thirdAgeQuestions;
        count = 20;
        break;
      case '4':
        AppQuizState.firstAgeQuestions.shuffle();
        qs = AppQuizState.fourthAgeQuestions;
        count = 10;
    }
    for (String q in qs) {
      if (que.length >= count) {
        return que;
      } else {
        var ref;
        switch (age) {
          case '1':
            ref = await AppQuizState.firstAge.doc(q).get();
            break;
          case '2':
            ref = await AppQuizState.secondAge.doc(q).get();
            break;
          case '3':
            ref = await AppQuizState.thirdAge.doc(q).get();
            break;
          case '4':
            ref = await AppQuizState.fourthAge.doc(q).get();
            break;
          default:
            ref = await AppQuizState.firstAge.doc(q).get();
            break;
        }
        Question question;
        if (ref['type'] != 'text') {
          question = Question(type: ref['type'],
              text: ref['description'],
              metaData: ref['path'],
              firstAnswer: ref['firstAnswer'],
              secondAnswer: ref['secondAnswer'],
              thirdAnswer: ref['thirdAnswer'],
              fourthAnswer: ref['fourthAnswer'],
              rightAnswer: ref['rightAnswer'],
              age: age);
        } else {
          question = Question(type: 'text',
              text: ref['question'],
              metaData: 'null',
              firstAnswer: ref['firstAnswer'],
              secondAnswer: ref['secondAnswer'],
              thirdAnswer: ref['thirdAnswer'],
              fourthAnswer: ref['fourthAnswer'],
              rightAnswer: ref['rightAnswer'],
              age: age);
        }
        que.add(question);
      }
    }
    return que;
  }

}