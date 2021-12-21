import 'package:aoe2quiz/main_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/background_auth.png"),
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 500,
            left: 48,
            right: 48,
            child: GestureDetector(
              onTap: () async {
                await Future.delayed(Duration.zero, () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/mainPage', (Route<dynamic> route) => false);
                  Navigator.pushNamed(
                      context, '/regPage');
                });
              },
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/red_button.png',
                    ),
                  ),
                  Positioned(
                      top: 5,
                      left: 41,
                      right: 41,
                      child: Center(
                          child: Text("Register an account",
                              style: TextStyle(
                                  fontFamily: "Redressed",
                                  fontSize: 24,
                                  color: Color.fromRGBO(240, 210, 183, 1)),
                              textAlign: TextAlign.center))),
                ],
              ),
            ),
          ),
          Positioned(
            top: 577,
            left: 48,
            right: 48,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/mainPage', (Route<dynamic> route) => false);
              },
              child: Stack(
                children: [
                  Center(child: Image.asset('assets/green_button.png')),
                  Positioned(
                      top: 9,
                      left: 41,
                      right: 41,
                      child: Center(
                          child: Text("Start the game already",
                              style: TextStyle(
                                  fontFamily: "Redressed",
                                  fontSize: 24,
                                  color: Color.fromRGBO(240, 210, 183, 1)),
                              textAlign: TextAlign.center))),
                ],
              ),
            ),
          ),
          Positioned(
            top: 153,
            left: 48,
            right: 48,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Hello friend and welcome to AOE2 Quiz game. The game mechanics are simple, much more easier then actual game /1'
                  '\n\nAll you have to do - answer questions, more correct question - more gold, more gold - new ages available. As always (we hate Empires mode), you start with dark age'
                  '\n\nAll hale King and let Viper, Hera, MBL, Tatoh, Nili and rest i cant feet in this screen be with you (T90 and MembTV, if you play this - you have to cast).',
                  style: TextStyle(
                      fontFamily: "Redressed",
                      fontSize: 20,
                      color: Color.fromRGBO(52, 31, 0, 1)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
