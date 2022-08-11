import 'dart:math';

import "package:flutter/material.dart";
import 'package:reading_reparo/FeedbackScreen.dart';
import 'main.dart';
import 'SecondScreen.dart';
import 'FeedbackScreen.dart';
import 'myColors.dart';
import 'myStyles.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import "data/bookData.dart";
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool isFinished = false;
  late String _text;
  late String _textConst;
  double _confidence = 1.0;
  String langId = SecondRoute.langID;
  static late String savedWords;
  static List<String> wrongWords = [];
  final Map<String, HighlightedWord> _highlights = {};
  String bookContent =
      SecondRoute.contentLimit.replaceAll(RegExp('[^A-Za-z0-9]'), ' ');

  late var spokenContent;
  late var readingContent;

  _SpeechScreenState() {
    this._textConst = "Pres button to start speaking";
  }

  @override
  void initState() {
    super.initState();
    this._text =
        SecondRoute.contentLimit.replaceAll(RegExp('[^A-Za-z0-9]'), ' ');

    _speech = stt.SpeechToText();

    /*
    for (int i = 0; i < savedWords.length; i++) {
      _highlights[savedWords[i]] = HighlightedWord(
          textStyle: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.w400, fontSize: 32));
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SecondRoute.contentLimit = "";

          return true;
        },
        child: Scaffold(
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AvatarGlow(
            animate: _isListening,
            glowColor: Colors.purple.shade900,
            endRadius: 75.0,
            duration: const Duration(microseconds: 2000),
            repeatPauseDuration: const Duration(microseconds: 100),
            child: FloatingActionButton(
                onPressed: _listen,
                child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
          ),
          body: Center(
              child: ListView(reverse: false, children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Container(
                      height: 150,
                      width: 150,
                      child: Image(
                        image: AssetImage(SecondRoute.coverPath),
                      )),
                  Text(
                    SecondRoute.bookTitle,
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jeju-Gothic',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    SecondRoute.bookDesc,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Jeju-Gothic",
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
              child: Text(bookContent,
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
            ),
            Container(
              // speaking container
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
              child: Text(_text),

              /* TextHighlight(
                text: _isListening == false ? "" : _text,
                words: _highlights,
                textStyle: const TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),*/
            ),
          ])),
        ));
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

      savedWords = _text;

      // find difference in strings
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => feedBackScreenRoute(
                  savedWords.toLowerCase().split(" "),
                  bookContent.toLowerCase().split(" "))));
    }
  }
}
