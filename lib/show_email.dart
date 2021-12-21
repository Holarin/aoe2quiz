
import 'package:aoe2quiz/analytic_sender.dart';
import 'package:aoe2quiz/app_bar.dart';
import 'package:aoe2quiz/reg_page.dart';
import 'package:aoe2quiz/user.dart';
import 'package:flutter/material.dart';

void showEmail(BuildContext context) {
  showDialog(context: context, builder: (context) {return Center(
      child: email(context));}).then((value) => {
  });
}

Widget email(BuildContext context) {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nickname = TextEditingController();
  return Scaffold(
    backgroundColor: Colors.transparent,
    appBar: null,
    body: Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Container(
            width: 343,
            height: 367,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/background_lose.png'), fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {Navigator.pop(context);},
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/close_button.png'), fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [   Center(
                            child: Text('Sign in / Sign Up',
                                style: TextStyle(
                                    fontFamily: "Redressed",
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400))),
                          SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/container_language.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: TextField(
                              controller: email,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(
                                      fontFamily: "Times New Roman",
                                      color: Color.fromRGBO(52, 31, 0, 0.5))),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/container_language.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: TextField(
                              controller: password,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontFamily: "Times New Roman",
                                      color: Color.fromRGBO(52, 31, 0, 0.5))),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/container_language.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: TextField(
                              controller: nickname,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Nickname (only for sign up)',
                                  hintStyle: TextStyle(
                                      fontFamily: "Times New Roman",
                                      color: Color.fromRGBO(52, 31, 0, 0.5))),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    if (password.text != '' && email.text != '') {
                                      if (UserQuiz.fAuth.currentUser == null) {
                                        UserQuiz.fAuth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
                                          UserQuiz.name = nickname.text;
                                          Future.delayed(Duration.zero, () async {
                                            await UserQuiz.loadPlayer();
                                            regUpdater.add(0);
                                            changerListener.add(0);
                                          });
                                        }).onError((error, stackTrace) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error ${error.toString()}')));
                                        });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fields cannot be empty')));
                                    }
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/red_button.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.home, color: Color.fromRGBO(240, 210, 183, 1)),
                                          SizedBox(width: 8),
                                          Text('Sign in', style: TextStyle(fontFamily: 'Redressed', fontWeight: FontWeight.w400, fontSize: 24, color: Color.fromRGBO(240, 210, 183, 1))),
                                        ],
                                      ))
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    if (nickname.text != "" && password.text != '' && email.text != '') {
                                      if (UserQuiz.fAuth.currentUser == null) {
                                        UserQuiz.fAuth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
                                          UserQuiz.name = nickname.text;
                                          sendEvent('registered_over_email');
                                          UserQuiz.savePlayer();
                                          regUpdater.add(0);
                                        }).onError((error, stackTrace) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error ${error.toString()}')));
                                        });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fields cannot be empty')));
                                    }
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/green_button.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.email, color: Color.fromRGBO(240, 210, 183, 1)),
                                          SizedBox(width: 8),
                                          Text('Sign up', style: TextStyle(fontFamily: 'Redressed', fontWeight: FontWeight.w400, fontSize: 24, color: Color.fromRGBO(240, 210, 183, 1))),
                                        ],
                                      ))
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    ),
  );
}