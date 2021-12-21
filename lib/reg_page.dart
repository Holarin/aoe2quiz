import 'dart:async';

import 'package:aoe2quiz/analytic_sender.dart';
import 'package:aoe2quiz/app_state.dart';
import 'package:aoe2quiz/leaderbord_page.dart';
import 'package:aoe2quiz/questions/show_terms.dart';
import 'package:aoe2quiz/show_email.dart';
import 'package:aoe2quiz/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main_page.dart';

StreamController<int> regUpdater = StreamController<int>.broadcast();

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class RegPage extends StatefulWidget {
  RegPage({Key? key}) : super(key: key);
  TextEditingController _nickname = new TextEditingController();

  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    regUpdater.stream.listen((event) {
      setState(() {

      });
    });
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
        print(account);
        Future.delayed(Duration.zero, () async {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await _currentUser!.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          final UserCredential authResult = await UserQuiz.fAuth
              .signInWithCredential(credential);
          if (authResult.additionalUserInfo!.isNewUser) {
            UserQuiz.name = _currentUser!.displayName!;
            UserQuiz.savePlayer();
          } else {
            var user =
            await AppQuizState.users.doc(UserQuiz.fAuth.currentUser!.uid).get();

            UserQuiz.money = user['gold'];
            UserQuiz.name = user['name'];
          }
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                    pageIndexController.add(0);
                    return;
                  }
                  pageIndexController.add(2);
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                      fontFamily: "Redressed",
                      color: Color.fromRGBO(52, 31, 0, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                ),
              )
            ]),
      ),
      body: Stack(fit: StackFit.expand, children: [
        Image(
          image: AssetImage("assets/background_reg.png"),
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Visibility(

    visible: UserQuiz.fAuth.currentUser == null,
                child: Center(
                    child: Text('Sign in or Sign Up',
                        style: TextStyle(
                            fontFamily: "Redressed",
                            fontSize: 30,
                            fontWeight: FontWeight.w400))),
              ),
              Visibility(
                  visible: UserQuiz.fAuth.currentUser == null,
                  child: SizedBox(height: 10)),
              Visibility(
                visible: UserQuiz.fAuth.currentUser == null,
                child: Center(
                    child: Text(
                        'If you don’t register using your email, you may lose the progress you reach If you change your device.'
                        '\nOnce registered, you will be able to play on different devices using the same account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 16,
                            fontWeight: FontWeight.w400))),
              ),
              Visibility(
                  visible: UserQuiz.fAuth.currentUser == null,
                  child: SizedBox(height: 30)),
              Visibility(
                visible: UserQuiz.fAuth.currentUser == null,
                child: GestureDetector(
                  onTap: () {
                    showEmail(context);
                    print('Here ');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/red_button.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                        child: Text('E-mail',
                            style: TextStyle(
                                fontFamily: 'Redressed',
                                color: Color.fromRGBO(240, 210, 183, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 24))),
                  ),
                ),
              ),
              Visibility(
                  visible: UserQuiz.fAuth.currentUser == null,
                  child: SizedBox(height: 30)),
              Visibility(
                visible: UserQuiz.fAuth.currentUser == null,
                child: GestureDetector(
                  onTap: () {
                    Future.delayed(Duration.zero, () async {
                      try {
                        await _googleSignIn
                            .signIn()
                            .then((value) => print('HI!'));
                        print(_currentUser);
                      } catch (error) {
                        print(error);
                      }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/green_button.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                        child: Text('Google',
                            style: TextStyle(
                                fontFamily: 'Redressed',
                                color: Color.fromRGBO(240, 210, 183, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 24))),
                  ),
                ),
              ),
              Visibility(
                  visible: UserQuiz.fAuth.currentUser == null,
                  child: SizedBox(height: 30)),
              Visibility(
                visible: UserQuiz.fAuth.currentUser == null,
                child: Center(
                  child: GestureDetector(
                    onTap: () => showTerm(context),
                    child: RichText(
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        text: TextSpan(
                          text: "By continuing,",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontFamily: "Times New Roman"),
                          children: <TextSpan>[
                            TextSpan(
                                text: " you agree to the terms,",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text:
                                  " which are simple. The game is provided as is, and all we can do - try to provide you with a fun time. So, enjoy if you want or leave.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontFamily: "Times New Roman"),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              Visibility(
                  visible: UserQuiz.fAuth.currentUser == null,
                  child: SizedBox(height: 32)),
              Visibility(
                visible: UserQuiz.fAuth.currentUser == null,
                child: Center(
                    child: Text('Nah, I am not afraid to loose the progress',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 22,
                            fontWeight: FontWeight.w400))),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: UserQuiz.fAuth.currentUser != null,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(UserQuiz.name, style: TextStyle(fontFamily: "Redressed", fontWeight: FontWeight.w400, fontSize: 22)),
                      Container(


                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(image: AssetImage("assets/gold_lead.png")),
                            SizedBox(width: 5),
                            Text(
                              UserQuiz.money.toString(),
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: "Redressed",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              SizedBox(height: 16),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: Center(
                      child: Row(
                    children: [
                      Flexible(
                        child: Container(
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
                            controller: widget._nickname,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: UserQuiz.fAuth.currentUser == null
                                    ? 'Sign up anonymously'
                                    : 'Change your nickname',
                                hintStyle: TextStyle(
                                    fontFamily: "Times New Roman",
                                    color: Color.fromRGBO(52, 31, 0, 0.5))),
                          ),
                        ),
                      ),
                      SizedBox(width: 17),

                      GestureDetector(
                        onTap: () {
                          if (widget._nickname.text != '' &&
                              widget._nickname.text.length <= 14) {
                            if (UserQuiz.fAuth.currentUser == null) {
                              UserQuiz.fAuth.signInAnonymously().then((value) {
                                setState(() {

                                });
                              });
                              UserQuiz.name = widget._nickname.text;
                              sendEvent('created_anonymous_nickname');

                              UserQuiz.savePlayer();
                            } else {
                              if (widget._nickname.text.length <= 14) {
                                UserQuiz.name = widget._nickname.text;
                                UserQuiz.savePlayer();
                              } else {}
                            }
                          }
                          FocusScope.of(context).unfocus();
                          widget._nickname.text = '';
                        },
                        child: Container(
                          width: 74,
                          height: 47,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/ok_button.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Ok",
                            style: TextStyle(
                              fontFamily: "Redressed",
                              fontSize: 24,
                              color: Color.fromRGBO(240, 210, 183, 1),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      )
                    ],
                  ))),
              SizedBox(height: 32),

              Visibility(
                visible: UserQuiz.fAuth.currentUser != null,
                child: GestureDetector(
                  onTap: () {
                    UserQuiz.fAuth.signOut().then((value) async {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Success')));
                      await _googleSignIn.signOut();
                      _currentUser = null;
                      UserQuiz.money = 100;
                      UserQuiz.name = "User";
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/red_button.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                        child: Text('Sign out',
                            style: TextStyle(
                                fontFamily: 'Redressed',
                                color: Color.fromRGBO(240, 210, 183, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 24))),
                  ),
                ),
              ),

              SizedBox(height: 32),
            ],
          ),
        )
      ]),
    );
  }
}
