// Color Scheme
import 'package:flutter/material.dart';

class CustomMaterialColor{
  static MaterialColor bannerColor;
  static MaterialColor emphasisColor;
  static MaterialColor buttonColorBlue;
  static MaterialColor buttonColorWhite;
  static MaterialColor subColorArmy;
  static MaterialColor subColorGrass;
  static MaterialColor subColorBlack;
  static MaterialColor subColorRed;
  static MaterialColor subColorDarkYelow;

  static void initializeCustomColor() {
    bannerColor = createCustomColor(0xFF04645A);
    emphasisColor = createCustomColor(0xFFE2B129);
    buttonColorBlue = createCustomColor(0xFF9DD4D1);
    buttonColorWhite = createCustomColor(0xFFF8F5F4);
    subColorArmy = createCustomColor(0xFF6F8B62);
    subColorGrass = createCustomColor(0xFF93AB4B);
    subColorBlack = createCustomColor(0xFF080808);
    subColorRed = createCustomColor(0xFFDA4B2F);
    subColorDarkYelow = createCustomColor(0xFFD59D33);
  }


  static MaterialColor createCustomColor(int primary) {
    int red = (0x00ff0000 & primary) >> 16;
    int green = (0x0000ff00 & primary) >> 8;
    int blue = (0x000000ff & primary);

    int redLighterShade = (255 - red) ~/ 10;
    int redDarkerShade = red ~/ 10;

    int greenLighterShade = (255 - green) ~/ 10;
    int greenDarkerShade = green ~/ 10;

    int blueLighterShade = (255 - blue) ~/ 10;
    int blueDarkerShade = red ~/ 10;

    Map<int, Color> colorMapping = new Map();

    /// entry shade 50, 100, 200, 300, 400
    /// i for entry index
    /// j for multiplier index
    for (int i = 0, j = 5; i <= 4; i++, j--) {
      int newRed = red + (j * redLighterShade);
      int newGreen = green + (j * greenLighterShade);
      int newBlue = blue + (j * blueLighterShade);
      Color c() => Color.fromARGB(0xFF, newRed, newGreen, newBlue);
      // Shade for 50
      if (i == 0) {
        colorMapping.putIfAbsent(50, c);
      } else {
        colorMapping.putIfAbsent(i*100, c);
      }
    }

    /// entry shade 500 600 700 800 900
    /// i for entry index
    /// j for multiplier index
    for (int i = 5, j = 0; i <= 9; i++, j++) {
      int newRed = red + (j * redDarkerShade);
      int newGreen = green + (j * greenDarkerShade);
      int newBlue = blue + (j * blueDarkerShade);
      Color c() => Color.fromARGB(0xFF, newRed, newGreen, newBlue);
      colorMapping.putIfAbsent(i*100, c);
    }

    return MaterialColor(primary, colorMapping);
  }
}