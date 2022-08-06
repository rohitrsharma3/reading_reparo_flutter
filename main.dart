import 'dart:ui';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:animated_text_kit/animated_text_kit.dart';

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

class _FirstScreenState extends State<FirstScreen> with TickerProviderStateMixin {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromARGB(255, 42, 69, 225), Color.fromARGB(255, 119, 72, 212)]
    //colors: <Color>[Color.fromARGB(255, 28, 52, 185), Color.fromARGB(255, 168, 148, 209)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)
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
          backgroundColor: Color.fromARGB(255, 13, 38, 165),
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
                      textStyle:
                          TextStyle(fontSize: 30, 
                          foreground: Paint()..shader = linearGradient, 
                          fontFamily: "Jeju-Gothic",
                          fontWeight: FontWeight.bold),
                    ),
                    TyperAnimatedText("Let's Repair Our Reading",
                        textStyle: TextStyle(
                            fontSize: 30, 
                            foreground: Paint()..shader = linearGradient, 
                            fontFamily: "Jeju-Gothic",
                        )
                            ),
                  ],
                  repeatForever: true,
                  )
                ),

              ],
            ),
            
          ],
        ),
        persistentFooterButtons: [
          Container(
            child:   ElevatedButton(
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) =>
                SecondRoute()));
              },
              child:  Text("Let's Start"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                fixedSize: MaterialStateProperty.all(
                    const Size(244, 48)
                )

              ),
              ),
              padding: EdgeInsets.only(right: 66, bottom: 50),
          )
        ],
      
        
        );
            
  }
}

class SecondRoute extends StatelessWidget {
   SecondRoute({Key? key}) : super(key: key);
  final List<String> langs = ["English", 'Hindi', 'Tamil', 'Telugu'];
  static late String languageSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("New screen"),
        backgroundColor: Colors.indigo.shade800,
      ),
      body: ListView(children: [
        Column( //Column of languages
            children: [ 
              ElevatedButton(onPressed: () {

                  languageSelected = 'en-US';
                   Navigator.push(  
                      context,  
                      MaterialPageRoute(builder: (context) => ThirdRoute()),  
                    );  
                }, 
                
                child: Row( // Row of language name and image
                    children: [
                      Container( // Text Container
                        child: Text('English',
                        style: 
                        TextStyle(
                          fontSize: 18,
                          color: Colors.white70
                        ),),
                    
                      ),
                      Container( // Image Container
                          child : Image.asset("assets/united-kingdom-flag-icon.png",
                          width: 35,
                          height: 26,),
                          padding: EdgeInsets.only(left:250),
                      )
                    ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

            ElevatedButton(onPressed: () {
                  languageSelected = 'hi-IN';

            }, child: Row( // Row of language name and image
              children: [
                Container( // Text Container
                  child: Text('Hindi',
                  style: 
                  TextStyle(
                    fontSize: 18,
                    color: Colors.white70
                  ),),
                  padding: EdgeInsets.only(left: 19),
                ),
                Container( // Image Container
                    child : Image.asset("assets/united-kingdom-flag-icon.png",
                    width: 35,
                    height: 26,),
                    padding: EdgeInsets.only(left:250),
                )
              ], // Elevated Button Children ends here
            ),
            )
            ,
            SizedBox(
                height: 10,
              ),

            ElevatedButton(onPressed: () {
                  languageSelected = 'ta-IN';

            }, child: Row( // Row of language name and image
              children: [
                Container( // Text Container
                  child: Text('Tamil',
                  style: 
                  TextStyle(
                    fontSize: 18,
                    color: Colors.white70
                  ),),
                  padding: EdgeInsets.only(left: 19),
                ),
                Container( // Image Container
                    child : Image.asset("assets/united-kingdom-flag-icon.png",
                    width: 35,
                    height: 26,),
                    padding: EdgeInsets.only(left:250),
                )
              ], // Elevated Button Children ends here
            ),
            ),
            SizedBox(
                height: 10,
              ),

            ElevatedButton(onPressed: () {
                  languageSelected = 'te-IN';

            }, child: Row( // Row of language name and image
              children: [
                Container( // Text Container
                  child: Text('Telugu',
                  style: 
                  TextStyle(
                    fontSize: 18,
                    color: Colors.white70
                  ),),
                  padding: EdgeInsets.only(left: 19),
                ),
                Container( // Image Container
                    child : Image.asset("assets/united-kingdom-flag-icon.png",
                    width: 35,
                    height: 26,),
                    padding: EdgeInsets.only(left:250),
                )
              ], // Elevated Button Children ends here
            ),
            )
            
          ], // Column children ends here
        )
      ], // List view children ends here
      )
        
    );
  }
}

class ThirdRoute extends StatefulWidget {
   ThirdRoute({Key? key}) : super(key: key);
  String language =  SecondRoute.languageSelected;
  @override
  State<ThirdRoute> createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SecondRoute.languageSelected),
      ),
    );
    
  }
}