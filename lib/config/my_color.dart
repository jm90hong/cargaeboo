
import 'package:flutter/material.dart';

class MyColor{


  static const mainCode = 0xff2343ed;
  static const darkCode = 0xff1f1f26;



  static Color mainColor = const Color(mainCode);
  static Color darkColor = const Color(darkCode);
  static MaterialColor mainMaterialColor = createMaterialColor(const Color(mainCode));
  static MaterialColor darkMaterialColor =  createMaterialColor(const Color(darkCode));
}


//todo material color 생성
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}