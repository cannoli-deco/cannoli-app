import 'dart:io';

import 'package:cannoli_app/comparison_graph.dart';
import 'package:cannoli_app/widgets/details_graph_view.dart';
import 'package:cannoli_app/widgets/emission_chart.dart';
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
        return getAllGraphWidgets();
      case WidgetList.transportGraph:
        return getTransportGraphWidgets();
      case WidgetList.homeGraph:
        return getHomeGraphWidgets();
    }
    return getAllGraphWidgets();
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

/*
Widget getAllGraphWidgets() {
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
