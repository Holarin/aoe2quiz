import 'dart:typed_data';

import 'package:aoe2quiz/analytic_sender.dart';
import 'package:aoe2quiz/main_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);
  bool isLoad = false;
  late ui.Image img;
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {



  Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    image.Image? baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List());
    image.Image resizeImage = image.copyResize(baseSizeImage!, height: height, width: width);
    ui.Codec codec = await ui.instantiateImageCodec(image.encodePng(resizeImage) as Uint8List);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      widget.img = await getUiImage('assets/slider_shape.png', 20, 20);
      print('here');
      setState(() {
        widget.isLoad = true;
      });
    });
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
                onTap: () {
                  pageIndexController.add(0);
                },
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
      body: Center(
        child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand, children: [
          Image(
            image: AssetImage("assets/background_settings.png"),
            fit: BoxFit.fill,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Settings', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Redressed', fontWeight: FontWeight.w400, fontSize: 30),),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {
                            pageIndexController.add(3);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/red_button.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(child: Text('Account', style: TextStyle(fontFamily: 'Redressed', fontWeight: FontWeight.w400, fontSize: 24, color: Color.fromRGBO(240, 210, 183, 1))))
                          ),
                        ),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {
                            sendEvent('clicked_on_buymecoffee');
                            launch('https://www.buymeacoffee.com/refugeegames');
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 44,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/green_button.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.coffee, color: Color.fromRGBO(240, 210, 183, 1)),
                                  SizedBox(width: 8),
                                  Text('Buy me a coffee', style: TextStyle(fontFamily: 'Redressed', fontWeight: FontWeight.w400, fontSize: 24, color: Color.fromRGBO(240, 210, 183, 1))),
                                ],
                              ))
                          ),
                        ), SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              )
            ),
          )
        ]),
      ),
    );
  }
}

/*
*
       Text('Choose language', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Times New Roman', fontWeight: FontWeight.w700, fontSize: 24),),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/container_language.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('English', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Times New Roman', fontWeight: FontWeight.w400, fontSize: 26),),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Sound', style: TextStyle(fontFamily: 'Times New Roman', fontWeight: FontWeight.w700, fontSize: 24),),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          AppState.isOnSound = !AppState.isOnSound;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/checkbox.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Visibility(
                          visible: AppState.isOnSound,
                          child: Icon(Icons.close, color: Colors.red)),
                      ),
                    ),
                    ]),
                SizedBox(height: 28),
                SliderTheme(
                  data: SliderThemeData(
                    thumbShape: widget.isLoad ? CustomThumb(widget.img) : null,
                    activeTrackColor: Color.fromRGBO(175, 5, 18, 1),
                    inactiveTrackColor: Color.fromRGBO(240, 210, 183, 1),
                    trackHeight: 4,
                  ),
                    child: Container(
                      width: 200,
                      child: Slider(
                        min: 0,
                        max: 100,
                        value: AppState.soundValue, onChanged: (double value) { setState(() {
                        AppState.soundValue = value;
                        });  },
                      ),
                    ),
                ),

                SizedBox(height: 40),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Music', style: TextStyle(fontFamily: 'Times New Roman', fontWeight: FontWeight.w700, fontSize: 24),),
                      GestureDetector(
                        onTap: () {setState(() {
                          AppState.isOnMusic = !AppState.isOnMusic;
                        });},
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/checkbox.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Visibility(
                              visible: AppState.isOnMusic,
                              child: Icon(Icons.close, color: Colors.red)),
                        ),
                      ),
                    ]),
                SizedBox(height: 28),
                SliderTheme(
                  data: SliderThemeData(
                    thumbShape: widget.isLoad ? CustomThumb(widget.img) : null,
                    activeTrackColor: Color.fromRGBO(175, 5, 18, 1),
                    inactiveTrackColor: Color.fromRGBO(240, 210, 183, 1),
                    trackHeight: 4,
                  ),
                  child: Container(
                    width: 200,
                    child: Slider(
                      min: 0,
                      max: 100,
                      value: AppState.musicValue, onChanged: (double value) { setState(() {
                      AppState.musicValue = value;
                    });  },
                    ),
                  ),
                ),
                SizedBox(height: 53),

* */