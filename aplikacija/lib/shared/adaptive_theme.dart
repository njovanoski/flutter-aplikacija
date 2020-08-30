import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

final ThemeData _androidTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.lightGreen,
  accentColor: Colors.lightBlue,
  buttonColor: Colors.green[300],
);
final ThemeData _iOSTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.lightBlue,
  accentColor: Colors.deepPurple,
  buttonColor: Colors.deepPurple,
);

ThemeData getAdaptiveThemeData(context) {
  return Theme.of(context).platform == TargetPlatform.android
      ? _androidTheme
      : _iOSTheme;
}
