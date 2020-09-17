import 'dart:io';

import 'package:cannoli_app/comparison_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:cannoli_app/scenes/home_page.dart';
import 'package:cannoli_app/widgets/textboxes.dart';

import 'package:cannoli_app/color_scheme.dart';

enum WidgetList { generalGraph, transportGraph, homeGraph }

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // Color _chipNotSelected = Colors.grey[600];
  // Color _chipSelected = CustomMaterialColor.bannerColor;
  int widgetIndex = 0;
  List<bool> isCategorySelected = [true, false, false];
  List<bool> isViewSelected = [true, false];
  WidgetList widgetSelection = WidgetList.generalGraph;

  Material emissionsGeneral() {
    return Material(
      color: Color(0xffE5E5E5),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Row for Page Title Text Box
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Page Layout Title Text Box
                pageLayoutTextBoxWidget('Emission Categories', 20.0),
              ],
            ),
            // Row for Toggle Button controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Emission Category Selection Button Group
                // All emissions
                FlatButton(
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isCategorySelected[0]
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                  color: isCategorySelected[0]
                      ? CustomMaterialColor.bannerColor
                      : Color(0xffE5E5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: isCategorySelected[0]
                          ? CustomMaterialColor.bannerColor
                          : Colors.grey[500],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widgetSelection = WidgetList.generalGraph;
                      for (int index = 0;
                          index < isCategorySelected.length;
                          index++) {
                        if (index == 0) {
                          isCategorySelected[index] = true;
                        } else {
                          isCategorySelected[index] = false;
                        }
                      }
                    });
                  },
                ),
                // Transport emissions
                FlatButton(
                  child: Text(
                    'Transport',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isCategorySelected[1]
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                  color: isCategorySelected[1]
                      ? CustomMaterialColor.bannerColor
                      : Color(0xffE5E5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: isCategorySelected[1]
                          ? CustomMaterialColor.bannerColor
                          : Colors.grey[500],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widgetSelection = WidgetList.transportGraph;
                      for (int index = 0;
                          index < isCategorySelected.length;
                          index++) {
                        if (index == 1) {
                          isCategorySelected[index] = true;
                        } else {
                          isCategorySelected[index] = false;
                        }
                      }
                    });
                  },
                ),
                // Home emissions
                FlatButton(
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isCategorySelected[2]
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                  color: isCategorySelected[2]
                      ? CustomMaterialColor.bannerColor
                      : Color(0xffE5E5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: isCategorySelected[2]
                          ? CustomMaterialColor.bannerColor
                          : Colors.grey[500],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widgetSelection = WidgetList.homeGraph;
                      for (int index = 0;
                          index < isCategorySelected.length;
                          index++) {
                        if (index == 2) {
                          isCategorySelected[index] = true;
                        } else {
                          isCategorySelected[index] = false;
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  Widget getWidgetGroup() {
    switch (widgetSelection) {
      case WidgetList.generalGraph:
        return getGeneralWidgetGroup();
      case WidgetList.transportGraph:
        return getTransportWidgetGroup();
      case WidgetList.homeGraph:
        return getHomeWidgetGroup();
    }
    return getGeneralWidgetGroup();
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
            child: emissionsGeneral(),
          ),
          getWidgetGroup(),
        ],
      ),
    ));
  }
}

Widget mychart1Items(String title, String priceVal, String subtitle) {
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

Widget comparisonCard(String title, String subTitle) {
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
                Padding(padding: EdgeInsets.all(1.0), child: ComparisonGraph()),
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

Widget getTransportWidgetGroup() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Page Layout Title Text Box
        pageLayoutTextBoxWidget('Transport: Overview', 18.0),
      ],
    ),
  );
}

Widget getHomeWidgetGroup() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Page Layout Title Text Box
        pageLayoutTextBoxWidget('Home: Overview', 18.0),
      ],
    ),
  );
}

Widget getGeneralWidgetGroup() {
  return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Page Layout Title Text Box
              pageLayoutTextBoxWidget('All Emissions: Overview', 18.0),
            ],
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
      ));
}

/*
Widget getGeneralWidgetGroup() {
  return ListView(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('General: Overview', 18.0),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 8.0),
        child: myCircularItems("Today's Total Consumption", "250kg CO2"),
      ),
      Container(
        padding: EdgeInsets.only(top: 8.0),
        child: mychart1Items("Home energy Consumption", "Weekly", "300kg CO2"),
      ),
      Container(
        padding: EdgeInsets.only(top: 8.0),
        child: comparisonCard("Comparison with ideal emission", "Weekly"),
      ),
    ],
  );
}
*/
