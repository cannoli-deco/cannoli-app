import 'package:flutter/material.dart';
import 'navigation_bar.dart';

void main() {
  runApp(MyApp());
}

const AppName = 'appName';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Manage colors here
    /// Use Theme.of(context).accentColor etc. to get color
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: CustomMaterialColor.customColor(0xFF04645A),
        accentColor: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: AppName),
    );
  }
}

/// Application entry point.
/// Anything common to all views can be done here.
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;


  // Add your views in navigation_bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)), body: NavigationBar());
  }
}


// Color Scheme
class CustomMaterialColor{
  static MaterialColor customColor(int primary) {
    int red = (0x00ff0000 & primary) >> 16;
    int green = (0x0000ff00 & primary) >> 16;
    int blue = (0x000000ff & primary) >> 16;

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
    print(colorMapping);
    return MaterialColor(primary, colorMapping);
  }
}