import 'package:flutter/material.dart';

class LocalColorsStyle{

  static const int _primaryValue = 0xFF6060B8;

  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue, 
      <int, Color>{
      500: Color(LocalColorsStyle._primaryValue),
    },
  );

  static const int _lightGreenValue = 0xFF97EE9C;

  static const MaterialColor lightGreenColor = MaterialColor(
    _lightGreenValue, 
      <int, Color>{
      500: Color(LocalColorsStyle. _lightGreenValue),
    },
  );

}