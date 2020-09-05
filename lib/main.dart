import 'package:cannoli_app/routes.dart';
import 'package:flutter/material.dart';
import 'navigation_bar.dart';
import 'color_scheme.dart';

void main() {
  runApp(MyApp());
}

const AppName = 'Carbon Tracker';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Manage colors here
    /// Use Theme.of(context).accentColor etc. to get color
    CustomMaterialColor.initializeCustomColor();
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
        primaryColor: CustomMaterialColor.bannerColor,
        accentColor: CustomMaterialColor.buttonColorBlue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: AppName),
      routes: routes,
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