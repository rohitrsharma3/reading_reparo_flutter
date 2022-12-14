import 'package:flutter/material.dart';
import 'FirstScreen.dart';
import "SecondScreen.dart";
import 'SpeechScreen.dart';
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
