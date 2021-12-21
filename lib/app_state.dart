import 'package:aoe2quiz/analytic_sender.dart';
import 'package:aoe2quiz/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AppQuizState {
  static double soundValue = 50;
  static double musicValue = 50;
  static bool isOnSound = false;
  static bool isOnMusic = true;

  static List<String> firstAgeQuestions = [];
  static List<String> secondAgeQuestions = [];
  static List<String> thirdAgeQuestions = [];
  static List<String> fourthAgeQuestions = [];
  static List<String> motivations = [];
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static String term = "";

  static void appendBalance(String age, BuildContext context) {

    int old = UserQuiz.money;
    switch(age) {
      case '1':
        UserQuiz.money += 10;
        break;
      case '2':
        UserQuiz.money += 20;
        break;
      case '3':
        UserQuiz.money += 25;
        break;
      case '4':
        UserQuiz.money += 30;
        break;
    }
    int current = UserQuiz.money;

    if (old < 300 && current >= 300) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You have reached the Feudal Age.')));
      sendEvent('reach_feudal_age');
    }

    if (old < 500 && current >= 500) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You have reached the Castle Age.')));
      sendEvent('reach_castle_age');
    }

    if (old < 800 && current >= 800) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You have reached the Imperial Age.')));
      sendEvent('reach_imperial_age');
    }
  }

  static String getMotivation() {
    motivations.shuffle();
    if (motivations.isNotEmpty) {
      return motivations[0];
    } else {
      return 'You have been defeated. This time only. Better luck next time.';
    }
  }

  static void loseBalance(String age) {
    switch(age) {
      case '1':
        UserQuiz.money -= 50;
        break;
      case '2':
        UserQuiz.money -= 100;
        break;
      case '3':
        UserQuiz.money -= 200;
        break;
      case '4':
        UserQuiz.money -= 250;
        break;
    }
    if (UserQuiz.money < 0) {
      UserQuiz.money = 0;
    }

  }

  static Future<void> load() async {
    var data = await info.doc('firstAge').get();
    firstAgeQuestions = List.from(data['body']);

    var data2 = await info.doc('secondAge').get();
    secondAgeQuestions = List.from(data2['body']);

    var data3 = await info.doc('thirdAge').get();
    thirdAgeQuestions = List.from(data3['body']);

    var data4 = await info.doc('fourthAge').get();
    fourthAgeQuestions = List.from(data4['body']);

    var dataMot = await appState.doc('appState').get();
    motivations = List.from(dataMot['motivations']);

    term = dataMot['terms'];
    term = term.replaceAll("ne_line", "\n");
    if (UserQuiz.fAuth.currentUser != null) {
      var user = await users.doc(UserQuiz.fAuth.currentUser!.uid).get();
      UserQuiz.money = user['gold'];
      UserQuiz.name = user['name'];
    }

  }


  static final CollectionReference firstAge =
  FirebaseFirestore.instance.collection('firstAge');

  static final CollectionReference secondAge =
  FirebaseFirestore.instance.collection('secondAge');

  static final CollectionReference thirdAge =
  FirebaseFirestore.instance.collection('thirdAge');

  static final CollectionReference fourthAge =
  FirebaseFirestore.instance.collection('fourthAge');

  static final CollectionReference info =
  FirebaseFirestore.instance.collection('info');

  static final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  static final CollectionReference appState =
  FirebaseFirestore.instance.collection('settings');
}