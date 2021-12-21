import 'dart:async';

import 'package:aoe2quiz/app_bar.dart';
import 'package:aoe2quiz/app_state.dart';
import 'package:aoe2quiz/loagind_screen.dart';
import 'package:aoe2quiz/main_page.dart';
import 'package:aoe2quiz/questions/answer_body.dart';
import 'package:aoe2quiz/questions/image_question.dart';
import 'package:aoe2quiz/questions/question.dart';
import 'package:aoe2quiz/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

StreamController<int> notifyChanger = StreamController<int>.broadcast();

class QuestionList extends StatefulWidget {
  QuestionList({Key? key, required this.age}) : super(key: key);

  List<Question> questions = [];
  String age;
  int index = 0;
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {

  @override
  void initState() {
    super.initState();
    widget.index = 0;
    Question.getQuestions(widget.age).then((value) {
      setState(() {
        widget.questions = value;
      });
    });
    notifyChanger.stream.listen((event) {
      if (mounted) {
        widget.index = widget.index + 1;
        UserQuiz.savePlayer();
        if (widget.index >= widget.questions.length) {
          widget.index = 0;
          pageIndexController.add(0);
        } else {
          setState(() {

          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.questions.isEmpty ? LoadingScreen() : QuestionView(question: widget.questions[widget.index], index: widget.index + 1, size: widget.questions.length);
  }
}


class QuestionView extends StatefulWidget {
  const QuestionView(
      {Key? key,
      required this.question,
      required this.index,
      required this.size})
      : super(key: key);

  final Question question;
  final int index;
  final int size;
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {

  Widget getWidget(String type) {
    switch (type) {
      case 'text':
       return TextQuestion(
            question: widget.question, index: widget.index, size: widget.size);
      case 'image':
        return ImageQuestion(question: widget.question, index: widget.index, size: widget.size, );
    }
    return Container();
  }

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
            ]),
      ),
      body: getWidget(widget.question.type),
    );
  }
}

class TextQuestion extends StatefulWidget {
  const TextQuestion(
      {Key? key,
      required this.question,
      required this.index,
      required this.size})
      : super(key: key);

  final Question question;
  final int index;
  final int size;

  @override
  _TextQuestionState createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: AssetImage("assets/background_wood.png"),
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: 343,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/question_body.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(children: [
                  SizedBox(height: 63),
                  Center(
                      child: Text("${widget.index} of ${widget.size} questions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Redressed",
                              fontWeight: FontWeight.w400,
                              fontSize: 20))),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Center(
                        child: Text("${widget.question.text}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Redressed",
                                fontWeight: FontWeight.w400,
                                fontSize: 24))),
                  ),
                  SizedBox(height: 55),
                ]),
              ),
              SizedBox(height: 45),
              AnswerBody(question: widget.question),
            ],
          ),
        ),
      ],
    );
  }
}

