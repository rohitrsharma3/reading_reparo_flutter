import 'dart:math';

import "package:flutter/material.dart";
import 'package:reading_reparo/FeedbackScreen.dart';
import 'package:reading_reparo/LibraryScreen.dart';
import 'main.dart';
import 'SecondScreen.dart';
import 'FeedbackScreen.dart';
import 'myColors.dart';
import 'myStyles.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import "data/bookData.dart";
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SpeechScreen extends StatefulWidget {
  late String langId;
  late String bookTitle;
  static late String bookCover;
  late String bookContent;
  late String contentLimit;

  SpeechScreen(@required String recievedLangId, bookTitle, bookCover,
      bookContent, contentLimit) {
    this.langId = recievedLangId;
    this.bookTitle = bookTitle;
    SpeechScreen.bookCover = bookCover;
    this.bookContent = bookContent;
    this.contentLimit = contentLimit;
  }

  @override
  State<SpeechScreen> createState() => _SpeechScreenState(
      this.langId,
      this.bookTitle,
      SpeechScreen.bookCover,
      this.bookContent,
      this.contentLimit);
}

class _SpeechScreenState extends State<SpeechScreen> {
  late String langId;
  late String bookTitle;
  late String bookCover;
  late String bookContent;
  late String contentLimit;
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool isFinished = false;
  late String _text;
  late String _textConst;
  double _confidence = 1.0;
  late String savedWords = '';
  static List<String> wrongWords = [];

  late var spokenContent;
  late var readingContent;

  _SpeechScreenState(@required String recievedLangId, bookTitle, bookCover,
      bookContent, contentLimit) {
    this.langId = recievedLangId;
    this.bookTitle = bookTitle;
    this.bookCover = bookCover;
    this.bookContent = bookContent;
    this.contentLimit = contentLimit;
    this._textConst = "Pres button to start speaking";
  }

  @override
  void initState() {
    super.initState();

    this._text = 'Press the mic to start speaking';

    if (langId == 'en-IN') {
      contentLimit = contentLimit.replaceAll(RegExp('[^A-Za-z0-9]'), ' ');
    } else {
      contentLimit = contentLimit.replaceAll(';', "");
      contentLimit = contentLimit.replaceAll(',', "");
      contentLimit = contentLimit.replaceAll('.', "");
      contentLimit = contentLimit.replaceAll(")", "");
      contentLimit = contentLimit.replaceAll("(", "");
    }
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // flushing the screen content on back press
          contentLimit = "";
          SecondRoute.contentLimit = '';
          LibraryRoute.contentLimit = '';
          langId = '';

          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Confidence : ${(_confidence * 100).toStringAsFixed(1)}' +
                  '    ' +
                  langId,
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
            glowColor: Colors.green,
            endRadius: 75.0,
            duration: const Duration(microseconds: 2000),
            repeatPauseDuration: const Duration(microseconds: 100),
            child: FloatingActionButton(
                onPressed: _listen,
                child: isFinished == true
                    ? Icon(Icons.arrow_forward_sharp)
                    : Icon(_isListening ? Icons.mic : Icons.mic_none)),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(reverse: false, children: [
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                          height: 150,
                          width: 150,
                          child: bookCover == ''
                              ? Icon(Icons.book_online_outlined)
                              : Image(
                                  image: AssetImage(bookCover),
                                )),
                      Text(
                        bookTitle,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Jeju-Gothic',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
                        child: Text(
                          contentLimit,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          // speaking container
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.fromLTRB(
                              30.0, 30.0, 30.0, 150.0),
                          child: Text(_text,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))),
                    ],
                  ),
                ),
              ])),
        ));
  }

  void _listen() async {
    isFinished = false;
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val to ' + langId),
        onError: (val) => print('onError : $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onDevice: false,
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
      setState(() => {_isListening = false, isFinished = true});

      savedWords = _text;

      _speech.stop();

      // find difference in strings
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => feedBackScreenRoute(
                  savedWords.toLowerCase().split(" "),
                  contentLimit.toLowerCase().split(" "),
                  langId)));
    }
  }
}
