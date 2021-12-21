import 'package:aoe2quiz/app_state.dart';
import 'package:aoe2quiz/questions/answer_body.dart';
import 'package:aoe2quiz/questions/question.dart';
import 'package:aoe2quiz/questions/question_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

  void showLose(BuildContext context, Question question) {
    showDialog(context: context, builder: (context) {return Center(
        child: LoseWidget(question: question, context: context));}).then((value) {notifyChanger.add(0);
        visible.add(0);});
  }
  
  class LoseWidget extends StatefulWidget {
    LoseWidget({Key? key, required this.question, required this.context}) : super(key: key);
  
    Question question;
    BuildContext context;
  
    @override
    _LoseWidgetState createState() => _LoseWidgetState();
  }
  
  class _LoseWidgetState extends State<LoseWidget> {
    BannerAd? myBanner = null;
    bool isLoaded = false;
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      Future.delayed(Duration.zero, () async {
        final BannerAdListener listener = BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
      );
      final AdRequest request = AdRequest(
        keywords: <String>['foo', 'bar'],
        contentUrl: 'http://foo.com/bar.html',
        nonPersonalizedAds: true,
      );
      myBanner = BannerAd(
        adUnitId: 'ca-app-pub-7259546888190124/9446782087',
        size: AdSize.banner,
        request: request,
        listener: listener,
      );
      await myBanner!.load().onError((error, stackTrace) {
        myBanner!.dispose();
      }).then((value){
        setState(() {
          isLoaded = true;
        });
      });

    });
   }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Container(
          width: 343,
          height: 200 + 32 + 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/background_lose.png'), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Center(child: Text(AppQuizState.getMotivation(), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Redressed', fontWeight: FontWeight.w400, fontSize: 24)))),
                    ]
                ),
              ),
              Spacer(),
              isLoaded ? Container(
                  width: 300,
                  height: 100,
                  child: AdWidget(ad: myBanner!,)) : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {Navigator.pop(context);},
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/green_button.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                          child: Text('Continue',
                              style: TextStyle(
                                  fontFamily: 'Redressed',
                                  color: Color.fromRGBO(240, 210, 183, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24))),
                    ),
                  ),
                ],),
            ],
          )
      ),
    );
  }
}