import 'package:cannoli_app/comparison_graph.dart';
import 'package:cannoli_app/widgets/textboxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

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

Widget myCircularItems(String title, String subtitle) {
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
