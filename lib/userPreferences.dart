import 'package:shared_preferences/shared_preferences.dart';

class userPreferences {
  static var prefs;
  static var startInt;
  static var userScore;
  static var currentScore = 0;
  static Future init() async {
    final prefs = await SharedPreferences.getInstance();
  }

  static Future isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('startInt') == null) {
      await prefs.setInt('startInt', 1);
    } else {
      startInt = prefs.getInt('startInt');
      var currentInt = ++startInt;
      await prefs.setInt('startInt', currentInt);
    }

    if (prefs.getInt('userScore') == null) {
      await prefs.setInt('userScore', 0);
    }
    //await prefs.setInt('userScore', 0);
  }

  static Future setScore(int score) async {
    final prefs = await SharedPreferences.getInstance();

    currentScore = await getScore();
    currentScore = currentScore + score;
    await prefs.setInt("userScore", currentScore);

    var totalScore = await getScore();

    print('Your total score is ' + totalScore.toString());
  }

  static getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userScore');
  }
}
