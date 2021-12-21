import 'package:aoe2quiz/app_bar.dart';
import 'package:aoe2quiz/main_page.dart';
import 'package:aoe2quiz/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectorPage extends StatefulWidget {
  const SelectorPage({Key? key}) : super(key: key);

  @override
  _SelectorPageState createState() => _SelectorPageState();
}

class _SelectorPageState extends State<SelectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoneyWidget(),
              Spacer(),
              Visibility(
                visible: UserQuiz.fAuth.currentUser == null,
                child: Container(
                  width: 159,
                  height: 33,
                  child: GestureDetector(
                    onTap: () {
                      pageIndexController.add(3);
                    },
                    child: Visibility(
                      visible: UserQuiz.fAuth.currentUser == null,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/red_button.png',
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                  child: Text("Registration",
                                      style: TextStyle(
                                          fontFamily: "Redressed",
                                          fontSize: 24,
                                          color:
                                              Color.fromRGBO(240, 210, 183, 1)),
                                      textAlign: TextAlign.center))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/selector_bg.png"),
            fit: BoxFit.fill,
          ),
          ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    pageIndexController.add(4);
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Center(
                            child: Image(
                                image: AssetImage("assets/e_bg.png"),
                                width: 200,
                                height: 131,
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                            child:
                                Image(image: AssetImage("assets/e1_bg.png"))),
                      ),
                      Positioned.fill(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 11.0),
                                child: Text(
                                  "Dark age",
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ))),
                    ],
                  ),
                ),
                SizedBox(height: 26),
                GestureDetector(
                  onTap: () {
                    if (UserQuiz.money >= 300) {
                      pageIndexController.add(5);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please mine at least 300 gold')));
                    }
                  },
                  child: Stack(
                    children: [
                      Center(
                          child: Image(
                              image: AssetImage("assets/e_bg.png"),
                              width: 200,
                              height: 131,
                              fit: BoxFit.fill)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                            child:
                                Image(image: AssetImage("assets/e2_bg.png"))),
                      ),
                      Positioned.fill(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 11.0),
                                child: Text(
                                  "Feudal Age",
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ))),
                    ],
                  ),
                ),
                SizedBox(height: 26),
                GestureDetector(
                  onTap: () {
                    if (UserQuiz.money >= 500) {
                      pageIndexController.add(6);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please mine at least 500 gold')));
                    }
                  },
                  child: Stack(
                    children: [
                      Center(
                          child: Image(
                              image: AssetImage("assets/e_bg.png"),
                              width: 200,
                              height: 131,
                              fit: BoxFit.fill)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                            child:
                                Image(image: AssetImage("assets/e3_bg.png"))),
                      ),
                      Positioned.fill(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 11.0),
                                child: Text(
                                  "Castle Age",
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ))),
                    ],
                  ),
                ),
                SizedBox(height: 26),
                GestureDetector(
                  onTap: () {
                    if (UserQuiz.money >= 800) {
                      pageIndexController.add(7);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please mine at least 800 gold')));
                    }
                  },
                  child: Stack(
                    children: [
                      Center(
                          child: Image(
                              image: AssetImage("assets/e_bg.png"),
                              width: 200,
                              height: 131,
                              fit: BoxFit.fill)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                            child:
                                Image(image: AssetImage("assets/e4_bg.png"))),
                      ),
                      Positioned.fill(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 11.0),
                                child: Text(
                                  "Imperial Age",
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ))),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ]),
        ],
      ),
    );
  }
}
