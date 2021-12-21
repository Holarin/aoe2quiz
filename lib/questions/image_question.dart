import 'package:aoe2quiz/questions/answer_body.dart';
import 'package:aoe2quiz/questions/question.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageQuestion extends StatefulWidget {
  const ImageQuestion({Key? key, required this.question, required this.index, required this.size}) : super(key: key);

  final Question question;
  final int index;
  final int size;

  @override
  _ImageQuestionState createState() => _ImageQuestionState();
}

class _ImageQuestionState extends State<ImageQuestion> {
  bool isLoaded = false;
  late Image image;

  @override
  void initState() {
    super.initState();
    loadImage();
    print('here');
  }

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
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height: 400,
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
                  SizedBox(height: 20),
                  !isLoaded ? Container(width: 170, height: 170, child: CircularProgressIndicator()) : Image(image: image.image, width: 253, height: 170, fit: BoxFit.fill),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 39.0),
                    child: Center(
                        child: Text("${widget.question.text}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Redressed",
                                fontWeight: FontWeight.w400,
                                fontSize: 24))),
                  ),
                ]),
              ),
              SizedBox(height: 15),
              AnswerBody(question: widget.question),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadImage() async {
    try {
      final ref =
      FirebaseStorage.instance.ref("images/" + widget.question.metaData);
      await ref.getData().then((value) {
        setState(() {
          image = Image.memory(value!, width: 253, height: 170);
          isLoaded = true;
        });
      });
    } catch (e) {
      setState(() {
        image = Image(image: AssetImage("assets/e${widget.question.age}_bg.png"), width: 253, height: 170);
        isLoaded = true;
      });

    }
  }
}
