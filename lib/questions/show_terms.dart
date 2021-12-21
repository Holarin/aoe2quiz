import 'package:aoe2quiz/app_state.dart';
import 'package:flutter/material.dart';

void showTerm(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Center(child: term(context));
      });
}

Widget term(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Center(
          child: Container(
        width: 343,
        height: 367,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background_lose.png'),
              fit: BoxFit.fill),
        ),
            child: Center(
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

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24.0),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Text(AppQuizState.term,   textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      )));
}
