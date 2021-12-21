import 'package:aoe2quiz/app_bar.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

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
        body: Stack(fit: StackFit.expand, children: [
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
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Column(
                          children: [
                            Image(image: AssetImage('assets/load.png'),),
                          ],
                        ),
                      ),
                    )
                  ]))
        ]));
  }
}
