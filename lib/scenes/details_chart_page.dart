import 'dart:io';

import 'package:cannoli_app/comparison_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:cannoli_app/scenes/home_page.dart';

import 'package:cannoli_app/color_scheme.dart';

class DetailsChartPage extends StatefulWidget {
  DetailsChartPage({Key key}) : super(key: key);

  @override
  _DetailsChartPage createState() => _DetailsChartPage();
}

class _DetailsChartPage extends State<DetailsChartPage> {
  bool _isTransportOn = false;
  bool _isHomeEnergyOn = false;
  int _emissionMode = 0;

  // Code/Start: For Emission Details Card Widget
  //----------------------------------------------------------------------------
  // Emission Widget: Before user made emission category selection
  Widget emissionCategories(String title) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Card Title Text Box
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: CustomMaterialColor.bannerColor,
                  ),
                ),
              ),
              // Emission Category Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Transport Energy Icon
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: IconButton(
                      icon: Icon(Icons.drive_eta),
                      color: CustomMaterialColor.bannerColor,
                      highlightColor: CustomMaterialColor.bannerColor[10],
                      splashColor: CustomMaterialColor.bannerColor[50],
                      splashRadius: 25.0,
                      disabledColor: Colors.grey[300],
                      onPressed: () {
                        setState(() {
                          _isTransportOn = !_isTransportOn;
                        });
                      },
                    ),
                  ),
                  // Home Energy Icon
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: IconButton(
                      icon: Icon(Icons.home),
                      color: CustomMaterialColor.bannerColor,
                      highlightColor: CustomMaterialColor.bannerColor[10],
                      splashColor: CustomMaterialColor.bannerColor[50],
                      splashRadius: 25.0,
                      disabledColor: Colors.grey[300],
                      onPressed: () {
                        setState(() {
                          _isHomeEnergyOn = !_isHomeEnergyOn;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Emission Widget: After user made Transport Energy category selection
  Widget emissionCategoryTransport(String title) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Card Title Text Box
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: CustomMaterialColor.bannerColor,
                  ),
                ),
              ),
              // Emission Category Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Emission Widget: After user made Home Energy category selection
  Widget emissionCategoryHome(String title) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Card Title Text Box
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: CustomMaterialColor.bannerColor,
                  ),
                ),
              ),
              // Emission Category Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // List of Widget groups for all emission categories
  /*
  List<Widget> emissionWidgetGroup = <Widget>[
    emissionCategories("Detailed Statistics")

  ];
  */

  //----------------------------------------------------------------------------
  // Code/End: For Emission Details Card Widget

  Material mychart1Items(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: [
                        0.0,
                        1.0,
                        1.5,
                        2.0,
                        0.0,
                        0.0,
                        -0.5,
                        -1.0,
                        -0.5,
                        0.0,
                        0.0
                      ],
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Material comparisonCard(String title, String subTitle) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(6),
                  ),
                  Padding(
                      padding: EdgeInsets.all(1.0), child: ComparisonGraph()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(700.0, Color(0xff4285F4), rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Color(0xfff3af00), rankKey: 'Q2'),
        new CircularSegmentEntry(1800.0, Color(0xffec3337), rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Color(0xff40b24b), rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  Material myCircularItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: AnimatedCircularChart(
                      size: const Size(150.0, 150.0),
                      initialChartData: circularData,
                      chartType: CircularChartType.Pie,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xffE5E5E5),
      child: ListView(
        padding: EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: emissionCategories("Detailed Statisics"),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: myCircularItems("Today's Total Consumption", "250kg CO2"),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child:
                mychart1Items("Home energy Consumption", "Weekly", "300kg CO2"),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: comparisonCard("Comparison with ideal emission", "Weekly"),
          ),
        ],
      ),
    ));
  }
}
