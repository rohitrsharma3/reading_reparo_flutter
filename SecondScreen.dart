import 'package:flutter/material.dart';
import 'package:reading_reparo/FirstScreen.dart';
import 'main.dart';
import 'SpeechScreen.dart';
import 'myColors.dart';
import 'myStyles.dart';
import "data/languages.dart";
import "data/ourPicks.dart";
import "data/readingPlans.dart";
import 'data/bookData.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SecondRoute extends StatelessWidget {
  static late String langID;
  static late String bookTitle;
  static late String coverPath;
  static late String bookDesc;
  static late String bookTextPath;
  static var bookContent;
  static String contentLimit = "";

  SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "What language do you wantt to learn in?",
                style: TextStyle(
                    fontFamily: 'Jeju-Gothic',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: languages.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            langID = languages.values.elementAt(index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SpeechScreen())));
                          },
                          child: Text(
                            languages.keys.elementAt(index),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'Jeju-Gothic',
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[800]),
                              shape: myRoundedBorder(20),
                              fixedSize:
                                  MaterialStateProperty.all(Size(240, 130))),
                        ));
                  }),
                )),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("Our Picks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    fontFamily: 'Jeju-Gothic',
                  )),
            ),
            Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ourPicks.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        child: IconButton(
                          onPressed: () async {
                            langID = bookData.values.elementAt(index)[1];
                            bookTitle = bookData.keys.elementAt(index);
                            coverPath = bookData.values.elementAt(index)[2];
                            bookDesc = bookData.values.elementAt(index)[3];
                            bookTextPath = bookData.values.elementAt(index)[4];
                            bookContent =
                                await rootBundle.loadString(bookTextPath);

                            for (int i = 0; i < 30; i++) {
                              contentLimit = contentLimit +
                                  " " +
                                  bookContent.split(" ")[i];
                            }
                            langID = bookData.values.elementAt(index)[0];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SpeechScreen())));
                          },
                          icon: Image(
                              image: AssetImage(
                                  bookData.values.elementAt(index)[2])),
                          iconSize:
                              200 /*Text(
                            bookData.keys.elementAt(index),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'Jeju-Gothic',
                            ),
                          ),*/
                          ,
                          /*style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[800]),
                              shape: myRoundedBorder(20),
                              fixedSize:
                                  MaterialStateProperty.all(Size(240, 130))),*/
                        ));
                  }),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Reading Plans",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    fontFamily: 'Jeju-Gothic'),
              ),
            ),
            Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: readingPlans.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            langID = 'en-US';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    // TODO Update navigation route to Reading Plan Screen
                                    builder: ((context) => SpeechScreen())));
                          },
                          child: Text(
                            readingPlans[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'Jeju-Gothic',
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[800]),
                              shape: myRoundedBorder(20),
                              fixedSize:
                                  MaterialStateProperty.all(Size(240, 130))),
                        ));
                  }),
                ))
          ],
        ));
  }
}
