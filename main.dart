import 'dart:ui';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:reading_reparo/languageButtonIcons.dart' as languageIcon;
import 'package:reading_reparo/myColors.dart';
import "package:reading_reparo/myStyles.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  final Shader linearGradient = LinearGradient(colors: <Color>[
    Color.fromARGB(255, 42, 69, 225),
    Color.fromARGB(255, 119, 72, 212)
  ]
      //colors: <Color>[Color.fromARGB(255, 28, 52, 185), Color.fromARGB(255, 168, 148, 209)],
      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[100],
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        title: Text(
          'Reading Reparo',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: backgroundColor(),
      ),
      body: Wrap(
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(103, 280, 91, 472),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Reading Reparo",
                        textStyle: TextStyle(
                            fontSize: 36,
                            foreground: Paint()..shader = linearGradient,
                            fontFamily: "Jeju-Gothic",
                            fontWeight: FontWeight.bold),
                      ),
                      TyperAnimatedText("Let's Repair Our Reading",
                          textStyle: TextStyle(
                              fontSize: 36,
                              foreground: Paint()..shader = linearGradient,
                              fontFamily: "Jeju-Gothic",
                              fontWeight: FontWeight.bold)),
                    ],
                    repeatForever: true,
                  )),
            ],
          ),
        ],
      ),
      persistentFooterButtons: [
        Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondRoute()));
            },
            child: Text("Let's Start"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                fixedSize: MaterialStateProperty.all(const Size(244, 48))),
          ),
          padding: EdgeInsets.only(right: 66, bottom: 50),
        )
      ],
    );
  }
}

class SecondRoute extends StatelessWidget {
  static late String langID;

  SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        bottomNavigationBar: Stack(
          children: [
            Container(
              height: 50,
            ),
            Row(
              children: [],
            )
          ],
        ),
        appBar: AppBar(
          title: Text(
            "What would you like to read today?",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: ListView(
                    // Horizontal ListView
                    scrollDirection: Axis.horizontal,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            langID = 'en-IN';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SpeechScreen())));
                          },
                          child: Text(
                            "English",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              fontFamily: 'Jeju-Gothic',
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[800]),
                              shape: myRoundedBorder(20),
                              fixedSize:
                                  MaterialStateProperty.all(Size(240, 130)))),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            langID = 'hi-IN';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SpeechScreen())));
                          },
                          child: Text(
                            "Hindi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[800]),
                              shape: myRoundedBorder(20),
                              fixedSize:
                                  MaterialStateProperty.all(Size(240, 130)))),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            langID = 'ta-IN';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SpeechScreen())));
                          },
                          child: Text(
                            "Tamil",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[800]),
                              shape: myRoundedBorder(20),
                              fixedSize:
                                  MaterialStateProperty.all(Size(240, 130)))),
                    ],
                  ),
                ),
                SizedBox(
                  // seperator between two list view
                  height: 50,
                ),
                Container(
                    child: Column(
                  children: [
                    Container(
                      child: Text("Our Picks"),
                      padding: EdgeInsets.only(right: 300),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                                child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Level 1 "),
                              style: ButtonStyle(shape: myRoundedBorder(20)),
                            )),
                            SizedBox(width: 20),
                            Container(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Level 1 "),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20)))))),
                            SizedBox(width: 20),
                            Container(
                                child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Level 1 "),
                              style: ButtonStyle(shape: myRoundedBorder(20)),
                            )),
                            SizedBox(width: 20),
                            Container(
                                child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Level 1 "),
                              style: ButtonStyle(shape: myRoundedBorder(20)),
                            )),
                            SizedBox(width: 20)
                          ],
                        ))
                  ],
                )),
                Container(
                    child: Column(
                  children: [],
                ))
              ],
            ),
          ],
        ));
  }
}

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = "press the button to start speaking";
  late String _textConst;
  double _confidence = 1.0;
  String langId = SecondRoute.langID;
  late List<String> savedWords;
  final Map<String, HighlightedWord> _highlights = {};

  _SpeechScreenState() {
    this._textConst = _text;
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    savedWords = _text.split(" ");
    for (int i = 0; i < savedWords.length; i++) {
      _highlights[savedWords[i]] = HighlightedWord(
          textStyle: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.w400, fontSize: 32));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: AppBar(
          title: Text(
            'Confidence : ${(_confidence * 100).toStringAsFixed(1)}' +
                '    ' +
                SecondRoute.langID,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(microseconds: 2000),
          repeatPauseDuration: const Duration(microseconds: 100),
          child: FloatingActionButton(
              onPressed: _listen,
              child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
        ),
        body: ListView(reverse: false, children: [
          Container(
            child: Text(_textConst,
                style: const TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextHighlight(
              text: _isListening == false ? "" : _text,
              words: _highlights,
              textStyle: const TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ]));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val to ' + SecondRoute.langID),
        onError: (val) => print('onError : $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
          localeId: langId,
        );
      }
    } else {
      setState(() => _isListening = false);
      savedWords.add(_text);
      _speech.stop();
    }
  }
}
