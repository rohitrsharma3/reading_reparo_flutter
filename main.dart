import 'dart:ui';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:reading_reparo/languageButtonIcons.dart' as languageIcon;

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Reading Reparo'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                            fontSize: 30,
                            foreground: Paint()..shader = linearGradient,
                            fontFamily: "Jeju-Gothic",
                            fontWeight: FontWeight.bold),
                      ),
                      TyperAnimatedText("Let's Repair Our Reading",
                          textStyle: TextStyle(
                            fontSize: 30,
                            foreground: Paint()..shader = linearGradient,
                            fontFamily: "Jeju-Gothic",
                          )),
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "What would you like to read today?",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 650),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ElevatedButton(
                    onPressed: () {
                      langID = 'en-US';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SpeechScreen())));
                    },
                    child: languageIcon.LanguageIcon('assets/english-icon.png'),
                    style: ElevatedButton.styleFrom(shape: CircleBorder())),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    langID = 'hi-IN';
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SpeechScreen())));
                  },
                  child: languageIcon.LanguageIcon('assets/hindi-icon.png'),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      langID = 'ta-IN';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SpeechScreen())));
                    },
                    child: languageIcon.LanguageIcon('assets/tamil-icon.png'),
                    style: ElevatedButton.styleFrom(shape: CircleBorder())),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    langID = 'te-IN';
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SpeechScreen())));
                  },
                  child:
                      languageIcon.LanguageIcon('assets/india-flag-icon.png'),
                  style: ElevatedButton.styleFrom(shape: CircleBorder()),
                ),
              ], // Column children ends here
              // List view children ends here
            )));
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
  String _text = "Press the button to start speaking";
  double _confidence = 1.0;
  String langId = SecondRoute.langID;
  List<String> savedWords = [];
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
        floatingActionButton: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: Text(
              _text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
    print(savedWords);
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
