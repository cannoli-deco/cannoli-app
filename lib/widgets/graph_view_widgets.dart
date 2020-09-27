import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/comparison_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

final Color subTextColor = Colors.grey[600];
// enum: For every graph widget in All/General Category
enum AllGraphWidgetList {
  graphUserEmissions,
  graphIdealAustralian,
  graphCategoryEmissions,
}

class AllCharts extends StatefulWidget {
  @override
  _AllChartsState createState() => _AllChartsState();
}

class _AllChartsState extends State<AllCharts> {
  // List to switch between graph widgets. [Breakdown, Comparison]
  List<AllGraphWidgetList> _widgetList = [
    AllGraphWidgetList.graphUserEmissions,
    AllGraphWidgetList.graphIdealAustralian,
    AllGraphWidgetList.graphCategoryEmissions
  ];
  AllGraphWidgetList _currentWidget = AllGraphWidgetList.graphUserEmissions;

  // Function to switch between widget category groups Graph View
  Widget getWidgetGroup() {
    switch (_currentWidget) {
      case AllGraphWidgetList.graphUserEmissions:
        return myCircularItems("Today's Total Consumption", "250kg CO2");
      case AllGraphWidgetList.graphIdealAustralian:
        return mychart1Items("Home energy Consumption", "Weekly", "300kg CO2");
      case AllGraphWidgetList.graphCategoryEmissions:
        return comparisonCard("Comparison with ideal emission", "Weekly");
    }
    return myCircularItems("Today's Total Consumption", "250kg CO2");
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

  // Widget: Generates line chart to depict user emissions
  Widget mychart1Items(String title, String priceVal, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: CustomMaterialColor.bannerColor,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16.0,
                  color: subTextColor,
                ),
              ),
              Container(
                height: 312.0,
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                child: Sparkline(
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
          ),
        ),
      ],
    );
  }

  // Widget: Compares user to ideal australian
  Widget comparisonCard(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: CustomMaterialColor.bannerColor,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                '',
                style: TextStyle(
                  fontSize: 16.0,
                  color: subTextColor,
                ),
              ),
              Container(
                height: 312.0,
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: ComparisonGraph(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget: Pie chart to show daily total user emissions, classified by categories
  Widget myCircularItems(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: CustomMaterialColor.bannerColor,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16.0,
                  color: subTextColor,
                ),
              ),
              Container(
                height: 312.0,
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: AnimatedCircularChart(
                  size: const Size(300, 300),
                  initialChartData: circularData,
                  chartType: CircularChartType.Pie,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              setState(() {
                for (int index = _widgetList.length - 1; index > -1; index--) {
                  if (index == 0) {
                    _currentWidget = _widgetList[_widgetList.length - 1];
                    break;
                  } else if (_currentWidget == _widgetList[index]) {
                    index = index - 1;
                    _currentWidget = _widgetList[index];
                    break;
                  }
                }
              });
            },
          ),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Container(
              color: subTextColor,
              width: 320.0,
              child: getWidgetGroup(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: () {
              setState(() {
                for (int index = 0; index < _widgetList.length; index++) {
                  if (index == _widgetList.length - 1) {
                    _currentWidget = _widgetList[0];
                  } else if (_currentWidget == _widgetList[index]) {
                    index = index + 1;
                    _currentWidget = _widgetList[index];
                    break;
                  }
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

// enum: For every graph widget for each individual emission categories
enum GraphWidgetList {
  graphBreakdown,
  graphComparison,
}

// Class to handle Widgets (Graph view) for Home Energy Emission Category
class HomeEnergyCharts extends StatefulWidget {
  @override
  _HomeEnergyChartsState createState() => _HomeEnergyChartsState();
}

class _HomeEnergyChartsState extends State<HomeEnergyCharts> {
  // List to switch between graph widgets. [Breakdown, Comparison]
  List<GraphWidgetList> _widgetList = [
    GraphWidgetList.graphBreakdown,
    GraphWidgetList.graphComparison
  ];
  GraphWidgetList _currentWidget = GraphWidgetList.graphBreakdown;

  // Function to switch between widget category groups Graph View
  Widget getWidgetGroup() {
    switch (_currentWidget) {
      case GraphWidgetList.graphBreakdown:
        return homeEnergyPieBreakdown();
      case GraphWidgetList.graphComparison:
        return homeEnergyBreakdownComparison();
    }
    return homeEnergyPieBreakdown();
  }

  // TODO: implement live db data
  // TODO: Add graph widgets here
  // Widget: Breakdown of Home Energy, Pie chart (Category Comparison)
  Widget homeEnergyPieBreakdown() {
    return Text(
      'HOME ENERGY BREAKDOWN PIE',
    );
  }

  // Widget: Breakdown of Transport, Breakdown Comparison with ideal target
  Widget homeEnergyBreakdownComparison() {
    return Text(
      'TRANSPORT Comparison',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  setState(() {
                    for (int index = _widgetList.length - 1;
                        index > -1;
                        index--) {
                      if (index == 0) {
                        _currentWidget = _widgetList[_widgetList.length - 1];
                        break;
                      } else if (_currentWidget == _widgetList[index]) {
                        index = index - 1;
                        _currentWidget = _widgetList[index];
                        break;
                      }
                    }
                  });
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: getWidgetGroup(),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  setState(() {
                    for (int index = 0; index < _widgetList.length; index++) {
                      if (index == _widgetList.length - 1) {
                        _currentWidget = _widgetList[0];
                      } else if (_currentWidget == _widgetList[index]) {
                        index = index + 1;
                        _currentWidget = _widgetList[index];
                        break;
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Class to handle Widgets (Graph/Log view) for Transport Emission Category
class TransportCharts extends StatefulWidget {
  @override
  _TransportChartsState createState() => _TransportChartsState();
}

class _TransportChartsState extends State<TransportCharts> {
  // List to switch between graph widgets. [Breakdown, Comparison]
  List<GraphWidgetList> _widgetList = [
    GraphWidgetList.graphBreakdown,
    GraphWidgetList.graphComparison
  ];
  GraphWidgetList _currentWidget = GraphWidgetList.graphBreakdown;

  // Function to switch between widget category groups Graph View
  Widget getWidgetGroup() {
    switch (_currentWidget) {
      case GraphWidgetList.graphBreakdown:
        return transportPieBreakdown();
      case GraphWidgetList.graphComparison:
        return transportBreakdownComparison();
    }
    return transportPieBreakdown();
  }

  // TODO: implement live db data
  // TODO: Add graph widgets here
  // Widget: Breakdown of Transport, Pie chart (Category Comparison)
  Widget transportPieBreakdown() {
    return Text(
      'TRANSPORT BREAKDOWN PIE',
    );
  }

  // Widget: Breakdown of Transport, Breakdown Comparison with ideal target
  Widget transportBreakdownComparison() {
    return Text(
      'TRANSPORT Comparison',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  setState(() {
                    for (int index = _widgetList.length - 1;
                        index > -1;
                        index--) {
                      if (index == 0) {
                        _currentWidget = _widgetList[_widgetList.length - 1];
                        break;
                      } else if (_currentWidget == _widgetList[index]) {
                        index = index - 1;
                        _currentWidget = _widgetList[index];
                        break;
                      }
                    }
                  });
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: getWidgetGroup(),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  setState(() {
                    for (int index = 0; index < _widgetList.length; index++) {
                      if (index == _widgetList.length - 1) {
                        _currentWidget = _widgetList[0];
                      } else if (_currentWidget == _widgetList[index]) {
                        index = index + 1;
                        _currentWidget = _widgetList[index];
                        break;
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
