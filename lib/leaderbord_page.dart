import 'package:aoe2quiz/app_state.dart';
import 'package:aoe2quiz/main_page.dart';
import 'package:aoe2quiz/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              GestureDetector(
                onTap: () {pageIndexController.add(0);},
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
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Image(
            image: AssetImage("assets/background_leaderboard.png"),
            fit: BoxFit.fill,
          ),

          StreamBuilder<QuerySnapshot>(
            stream: AppQuizState
                .users
                .orderBy('gold', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              var lastIndex = snapshot.data!.docs.map((e) => e['gold']);
              int counter = 0;
              for (int a in lastIndex.toList()) {
                counter++;
                if (a <= UserQuiz.money) {
                  break;
                }
              }
                return ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                     return index == 0 ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(
                            fontFamily: "Redressed",
                            color: Color.fromRGBO(52, 31, 0, 1),
                            fontSize: 30,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text(
                      'TOP 10 players',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "Redressed",
                          color: Color.fromRGBO(52, 31, 0, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 30,),

                  ],
                ) : index == 11 ?
                     Column(

                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(height: 35.5),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
                             child: Text('Your position', style: TextStyle(fontFamily: "Redressed", fontSize: 24, fontWeight: FontWeight.w400)),
                           ),
                           SizedBox(height: 32),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
                             child: LeaderPos(pos: counter.toString(), namepos: UserQuiz.name, goldCount: UserQuiz.money),
                           ),
                           Divider(thickness: 1, color: Color.fromRGBO(94, 57, 32, 0.7)),
                         ]
                     )
                         :
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: LeaderPos(pos: (index).toString(), namepos: snapshot.data!.docs[index- 1]['name'], goldCount: (snapshot.data!.docs[index - 1]['gold'])),
                    ),
                    Divider(thickness: 1, color: Color.fromRGBO(94, 57, 32, 0.7)),
                  ]
                );
              });
            }
          ),
        ],
      ),
    );
  }
}

class LeaderPos extends StatelessWidget {
  const LeaderPos({Key? key, required this.pos, required this.namepos, required this.goldCount}) : super(key: key);

  final pos;
  final namepos;
  final int goldCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text(pos, style: TextStyle(fontFamily: "Redressed", fontWeight: FontWeight.w400, fontSize: 20)),
          SizedBox(width: 27),
          Text(namepos, style: TextStyle(fontFamily: "Redressed", fontWeight: FontWeight.w400, fontSize: 22)),],),
      Container(
        width: 100,
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Image(image: AssetImage("assets/gold_lead.png")),
            SizedBox(width: 5),
          Text(goldCount.toString(), maxLines: 2, style: TextStyle(fontFamily: "Redressed", fontWeight: FontWeight.w400, fontSize: 18),),
        ],),
      )

    ],);
  }
}

/*
  Text('Your position', style: TextStyle(fontFamily: "Redressed", fontWeight: FontWeight.w400, fontSize: 24),),
                SizedBox(height: 32),
                LeaderPos(pos: '158', namepos: UserQuiz.name, goldCount: UserQuiz.money.toString()),
                Divider(thickness: 1, color: Color.fromRGBO(94, 57, 32, 0.7)),

* */
