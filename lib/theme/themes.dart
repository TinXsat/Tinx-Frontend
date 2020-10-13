import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: Change default text style
TextTheme textTheme(TextTheme baseTheme) {
  final headline = baseTheme.headline5.copyWith();
  final bodyText = baseTheme.bodyText1.copyWith(fontWeight: FontWeight.normal);
  return TextTheme(
    headline1: headline.copyWith(fontSize: 60),
    headline2: headline.copyWith(fontSize: 50),
    headline3: headline.copyWith(fontSize: 40),
    headline4: headline.copyWith(fontSize: 30),
    headline5: headline.copyWith(fontSize: 20),
    headline6: headline.copyWith(fontSize: 10),
    bodyText1: bodyText.copyWith(fontSize: 18),
    bodyText2: bodyText.copyWith(fontSize: 14),
  );
}

ThemeData lightTheme() {
  var base = ThemeData.light();
  return base.copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      brightness: Brightness.light,
    ).copyWith(onBackground: Color.fromARGB(255, 60, 60, 60)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    textTheme: textTheme(base.textTheme),
  );
}

ThemeData darkTheme() {
  var base = ThemeData.dark();
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      backgroundColor: Color.fromARGB(255, 60, 60, 60),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    textTheme: textTheme(base.textTheme),
  );
}
