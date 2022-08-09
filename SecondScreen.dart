import 'package:flutter/material.dart';
import 'main.dart';
import 'SpeechScreen.dart';
import 'myColors.dart';
import 'myStyles.dart';

class SecondRoute extends StatelessWidget {
  static late String langID;

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
                                MaterialStateProperty.all(Size(240, 130))),
                      ),
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
                                height: 200,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Level 1 "),
                                  style:
                                      ButtonStyle(shape: myRoundedBorder(20)),
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
