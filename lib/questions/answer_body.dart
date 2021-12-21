import 'dart:async';

import 'package:aoe2quiz/app_bar.dart';
import 'package:aoe2quiz/app_state.dart';
import 'package:aoe2quiz/questions/question.dart';
import 'package:aoe2quiz/questions/question_view.dart';
import 'package:aoe2quiz/questions/show_lose.dart';
import 'package:flutter/material.dart';

StreamController<int> visible = StreamController<int>.broadcast();

class AnswerBody extends StatefulWidget {
  const AnswerBody({Key? key, required this.question}) : super(key: key);
  final Question question;
  @override
  _AnswerBodyState createState() => _AnswerBodyState();
}

class _AnswerBodyState extends State<AnswerBody> {
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;
  bool isPressed4 = false;
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    visible.stream.listen((event) {
      if (mounted) {
        isPressed1 = false;
        isPressed2 = false;
        isPressed3 = false;
        isPressed4 = false;
        isActive = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isActive) {
                    return;
                  }
                  if (widget.question.rightAnswer == '1') {
                    if (!isActive) {
                      isActive = true;
                      AppQuizState.appendBalance(widget.question.age, context);
                      Future.delayed(Duration(seconds: 1), () {
                        notifyChanger.add(0);
                        visible.add(0);
                      });
                    }
                  } else {
                    AppQuizState.loseBalance(widget.question.age);
                    switch (widget.question.rightAnswer) {
                      case '1':
                        isPressed1 = true;
                        break;
                      case '2':
                        isPressed2 = true;
                        break;
                      case '3':
                        isPressed3 = true;
                        break;
                      case '4':
                        isPressed4 = true;
                        break;
                    }
                    setState(() {
                      isPressed1 = true;
                      isActive = true;
                    });
                    showLose(context, widget.question);
                    changerListener.add(0);
                    return;
                  }
                  setState(() {
                    isActive = true;
                    isPressed1 = true;
                  });
                  changerListener.add(0);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(isPressed1
                          ? ('1' == widget.question.rightAnswer
                              ? "assets/background_answer_right.png"
                              : "assets/background_answer_wrong.png")
                          : "assets/background_answer.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                      child: Text('${widget.question.firstAnswer}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isActive) {
                    return;
                  }
                  if (widget.question.rightAnswer == '2') {
                    if (!isPressed2 && !isActive) {
                      AppQuizState.appendBalance(widget.question.age, context);
                      Future.delayed(Duration(seconds: 1), () {
                        notifyChanger.add(0);
                        isPressed1 = false;
                        isPressed2 = false;
                        isPressed3 = false;
                        isPressed4 = false;
                        isActive = false;
                      });
                    }
                  } else {
                    AppQuizState.loseBalance(widget.question.age);
                    switch (widget.question.rightAnswer) {
                      case '1':
                        isPressed1 = true;
                        break;
                      case '2':
                        isPressed2 = true;
                        break;
                      case '3':
                        isPressed3 = true;
                        break;
                      case '4':
                        isPressed4 = true;
                        break;
                    }
                    setState(() {
                      isPressed2 = true;
                      isActive = true;
                    });
                    showLose(context, widget.question);
                    changerListener.add(0);
                    return;
                  }
                  setState(() {
                    isPressed2 = true;
                    isActive = true;
                  });
                  changerListener.add(0);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(isPressed2
                          ? ('2' == widget.question.rightAnswer
                              ? "assets/background_answer_right.png"
                              : "assets/background_answer_wrong.png")
                          : "assets/background_answer.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                      child: Text('${widget.question.secondAnswer}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ),
            ),
          ]),
          SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isActive) {
                    return;
                  }
                  if (widget.question.rightAnswer == '3') {
                    if (!isPressed3 && !isActive) {
                      AppQuizState.appendBalance(widget.question.age, context);
                      Future.delayed(Duration(seconds: 1), () {
                        notifyChanger.add(0);
                        isPressed1 = false;
                        isPressed2 = false;
                        isPressed3 = false;
                        isPressed4 = false;
                        isActive = false;
                      });
                    }
                  } else {
                    AppQuizState.loseBalance(widget.question.age);
                    switch (widget.question.rightAnswer) {
                      case '1':
                        isPressed1 = true;
                        break;
                      case '2':
                        isPressed2 = true;
                        break;
                      case '3':
                        isPressed3 = true;
                        break;
                      case '4':
                        isPressed4 = true;
                        break;
                    }
                    setState(() {
                      isPressed3 = true;
                      isActive = true;
                    });
                    showLose(context, widget.question);
                    changerListener.add(0);
                    return;
                  }
                  setState(() {
                    isActive = true;
                    isPressed3 = true;
                  });

                  changerListener.add(0);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(isPressed3
                          ? ('3' == widget.question.rightAnswer
                              ? "assets/background_answer_right.png"
                              : "assets/background_answer_wrong.png")
                          : "assets/background_answer.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                      child: Text('${widget.question.thirdAnswer}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isActive) {
                    return;
                  }
                  if (widget.question.rightAnswer == '4') {
                    if (!isPressed4 && !isActive) {
                      AppQuizState.appendBalance(widget.question.age, context);
                      Future.delayed(Duration(seconds: 1), () {
                        notifyChanger.add(0);
                        isPressed1 = false;
                        isPressed2 = false;
                        isPressed3 = false;
                        isPressed4 = false;
                        isActive = false;
                      });
                    }
                  } else {
                    AppQuizState.loseBalance(widget.question.age);
                    switch (widget.question.rightAnswer) {
                      case '1':
                        isPressed1 = true;
                        break;
                      case '2':
                        isPressed2 = true;
                        break;
                      case '3':
                        isPressed3 = true;
                        break;
                      case '4':
                        isPressed4 = true;
                        break;
                    }
                    setState(() {
                      isPressed4 = true;
                      isActive = true;
                    });
                    showLose(context, widget.question);
                    changerListener.add(0);
                    return;
                  }
                  setState(() {
                    isActive = true;
                    isPressed4 = true;
                  });
                  changerListener.add(0);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(isPressed4
                          ? ('4' == widget.question.rightAnswer
                              ? "assets/background_answer_right.png"
                              : "assets/background_answer_wrong.png")
                          : "assets/background_answer.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                      child: Text('${widget.question.fourthAnswer}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
