import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reading_reparo/SpeechScreen.dart';
import 'package:reading_reparo/myColors.dart';
import 'package:pie_chart/pie_chart.dart';

class feedBackScreenRoute extends StatelessWidget {
  late List words;
  late List content;
  late List<String> wrong;
  late double correct;
  //const feedBackScreenRoute({Key key, @required this.words }) :super(key:key);

  feedBackScreenRoute(
      @required List<String> words, @required List<String> content) {
    this.words = words;
    this.content = content;

    this.wrong = (content.where((e) => !words.contains(e))).toList();
    this.wrong.removeWhere((element) => element == ' ');
    this.wrong.removeWhere((element) => element == '  ');
    this.wrong.removeWhere((element) => element == '');

    this.correct = this.content.length - this.wrong.length.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Assesement'),
              backgroundColor: Colors.black,
            ),
            body: ListView(children: [
              Container(
                height: 200,
                width: 200,
                child: PieChart(
                  dataMap: <String, double>{
                    'Correct': (correct / content.length) * 100
                  },
                  chartType: ChartType.ring,
                  baseChartColor: Colors.grey[50]!.withOpacity(0.75),
                  colorList: [Colors.red.shade400, Colors.green.shade400],
                  chartValuesOptions:
                      ChartValuesOptions(showChartValuesInPercentage: true),
                  totalValue: 100,
                ),
              ),
              Text(
                "Let's view what you got wrong",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: wrong.length,
                    itemBuilder: (((context, index) {
                      return Container(
                          child: TextButton(
                        onPressed: () {},
                        child: Text(
                          wrong[index],
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ));
                    })),
                  )),
            ])));
  }
}
