import "package:flutter/material.dart";
import 'main.dart';
import 'SecondScreen.dart';
import 'myColors.dart';
import 'myStyles.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = "press the button to start";
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
              Icon(
                Icons.book_rounded,
                size: 200,
              ),
              Text("Book Title")
            ],
          ),
        ),
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
                fontSize: 32, color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
      ])),
    );
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
