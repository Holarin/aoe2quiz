import 'dart:async';

import 'package:aoe2quiz/analytic_sender.dart';
import 'package:aoe2quiz/app_state.dart';
import 'package:aoe2quiz/leaderbord_page.dart';
import 'package:aoe2quiz/push_service.dart';
import 'package:aoe2quiz/questions/question_view.dart';
import 'package:aoe2quiz/reg_page.dart';
import 'package:aoe2quiz/selector_page.dart';
import 'package:aoe2quiz/settings_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

StreamController<int> pageIndexController = StreamController<int>.broadcast();

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key) {age = '1';}
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String age = '1';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  int realIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageIndexController.stream.listen((index) {
      setState(() {
        realIndex = index;
      });
    });
  }

  final screens = [
    SelectorPage(),
    LeaderboardPage(),
    SettingsPage(),
    RegPage(),
    QuestionList(age: '1'),
    QuestionList(age: '2'),
    QuestionList(age: '3'),
    QuestionList(age: '4'),
  ];

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(MainPage._firebaseMessaging);
    pushNotificationService.initialise();
    return Scaffold(
      body: screens[realIndex],
      bottomNavigationBar: Container(
        height: 83,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/bottom_nav_bg.png'), fit: BoxFit.fill),
          ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Color.fromRGBO(240, 210, 183, 1),
          unselectedItemColor: Color.fromRGBO(240, 210, 183, 1),
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            if (index == 1) {
              sendEvent('checked_leaderboard');
            }
            currentIndex = index;
            realIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/b_nav_1.png"),
              label: "Game",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/b_nav_2.png"),
              label: "Leaderboard",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/b_nav_3.png"),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
