import 'dart:async';

import 'package:aoe2quiz/user.dart';
import 'package:flutter/material.dart';

StreamController<int> changerListener = StreamController<int>.broadcast();

class MoneyWidget extends StatefulWidget {
  const MoneyWidget({Key? key}) : super(key: key);

  @override
  _MoneyWidgetState createState() => _MoneyWidgetState();
}

class _MoneyWidgetState extends State<MoneyWidget> {

  @override
  void initState() {
    super.initState();
    changerListener.stream.listen((event) {
      if (mounted) {
        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          height: 33,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(image: AssetImage("assets/money_bg.png"), fit: BoxFit.fill,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 2.0, bottom: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Image(image: AssetImage("assets/money.png")),
                    Text(UserQuiz.money.toString(), style: TextStyle(fontFamily: "Redressed", fontSize: 20),),
                  ],),
                ),
              ),
            ]
          ),
        ),
      ],
    );
  }
}
