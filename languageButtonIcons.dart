import "package:flutter/material.dart";

class LanguageIcon extends StatelessWidget {
  late String path;

  LanguageIcon(String path) {
    this.path = path;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        //shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.fill),
      ),
    );
  }
}
