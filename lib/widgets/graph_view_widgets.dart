import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/comparison_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:cannoli_app/database.dart';
import 'package:fl_chart/fl_chart.dart';

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

  // List to record each type of comsumption
  List<double> _consumptions;
  List<String> sources = ['Transport', 'Home\n Energy'];
  List<Color> sourceColors = [
    CustomMaterialColor.buttonColorBlue[200],
    CustomMaterialColor.subColorGrass[200]
  ];

  int touchedIndex;

  void _loadEntries() async{
    double totalConsumption = 0;
    double transportConsumption = 0;
    double homeConsumption = 0;
    List<double> temp = [];

    DateTime today = DateTime.now();
    var allEntries = await entryFromDate(today);
    if (allEntries.length != 0) {
      for (int i = 0; i < allEntries.length; i++) {
        print(allEntries[i].source_id);
        if (allEntries[i].source_id == 1) {
          homeConsumption += allEntries[i].consumption;
        } else if (allEntries[i].source_id == 383) {
          transportConsumption += allEntries[i].consumption;
        }
        totalConsumption += allEntries[i].consumption;
      }
    }

    if (totalConsumption == 0) {
      temp.add(transportConsumption / 1);
      temp.add(homeConsumption / 1);
    } else {
      temp.add(transportConsumption / totalConsumption);
      temp.add(homeConsumption / totalConsumption);
    }

    print("Detail Now:");
    print(temp);

    setState(() {
      _consumptions = temp;
    });
  }

  // Function to switch between widget category groups Graph View
  Widget getWidgetGroup() {
    switch (_currentWidget) {
      case AllGraphWidgetList.graphUserEmissions:
        return getPieChart("Today's Total Consumption", "250kg CO2");
      case AllGraphWidgetList.graphIdealAustralian:
        return getLineChart("Home energy Consumption", "Weekly", "300kg CO2");
      case AllGraphWidgetList.graphCategoryEmissions:
        return getComparisonChart("Comparison with ideal emission", "Weekly");
    }
    return getPieChart("Today's Total Consumption", "250kg CO2");
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
  Widget getLineChart(String title, String priceVal, String subtitle) {
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
  Widget getComparisonChart(String title, String subTitle) {
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
  Widget getPieChart(String title, String subtitle) {
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
                /**Abhi's previous implementation**/
                // height: 312.0,
                // padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                // child: AnimatedCircularChart(
                //   size: const Size(260, 260),
                //   initialChartData: circularData,
                //   chartType: CircularChartType.Pie,
                // ),
                /**From here by Mendes**/
                child: Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex = pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                          startDegreeOffset: 180,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 12,
                          centerSpaceRadius: 0,
                          sections: showingSections()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> noSection() {
    return List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 34 : 30;
      //final double radius = isTouched ? 115 : 115;
      final double opacity = isTouched ? 1 : 0.6;
      switch (i) {
        case 0:
          return PieChartSectionData(
            titlePositionPercentageOffset: 0,
            color: CustomMaterialColor.buttonColorWhite,
            value: 1,
            title: "No emission",
            radius: 80,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: CustomMaterialColor.emphasisColor),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> oneSection(int index) {
    return List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 28 : 18;
      //final double radius = isTouched ? 115 : 95;
      final double opacity = isTouched ? 1 : 0.6;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: sourceColors[index],
            value: _consumptions[index],
            title: sources[index],
            radius: 80,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> allSections() {
    return List.generate(2, (i){
      final isTouched = i == touchedIndex;
      final double opacity = isTouched ? 1 : 0.6;

      switch (i){
        case 0:
          return PieChartSectionData(
            color: sourceColors[0].withOpacity(opacity),
            value: _consumptions[0],
            title: sources[0],
            radius: 80,
            titleStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff044d7c)),
            titlePositionPercentageOffset: 0.55,
          );
        case 1:
          return PieChartSectionData(
            color: sourceColors[0].withOpacity(opacity),
            value: _consumptions[0],
            title: sources[0],
            radius: 65,
            titleStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff90672d)),
            titlePositionPercentageOffset: 0.55,
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> showingSections() {
    if (_consumptions[0] != 0.0 &&
        _consumptions[1] != 0.0) {
      return allSections();
    }

    if (_consumptions[0] != 0.0){
      return oneSection(0);
    }else if(_consumptions[1] != 0.0){
      return oneSection(1);
    }else{
      return noSection();
    }


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
        return homeEnergyPieBreakdown(
            'Category Breakdown', 'Home Energy Categories');
      case GraphWidgetList.graphComparison:
        return homeEnergyBreakdownComparison(
            'Category Comparison', 'Home Energy Categories');
    }
    return homeEnergyPieBreakdown(
        'Category Breakdown', 'Home Energy Categories');
  }

  // TODO: implement live db data
  // TODO: Add graph widgets here
  // Widget: Breakdown of Home Energy, Pie chart (Category Comparison)
  Widget homeEnergyPieBreakdown(String title, String subtitle) {
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
                child: Text(
                  'HOME ENERGY Pie',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget: Breakdown of Transport, Breakdown Comparison with ideal target
  Widget homeEnergyBreakdownComparison(String title, String subtitle) {
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
                child: Text(
                  'HOME ENERGY Comparison',
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
        return transportPieBreakdown(
            'Category Breakdown', 'Transport Categories');
      case GraphWidgetList.graphComparison:
        return transportBreakdownComparison(
            'Category Comparison', 'Transport Categories');
    }
    return transportPieBreakdown('Category Breakdown', 'Transport Categories');
  }

  // TODO: implement live db data
  // TODO: Add graph widgets here
  // Widget: Breakdown of Transport, Pie chart (Category Comparison)
  Widget transportPieBreakdown(String title, String subtitle) {
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
                child: Text(
                  'TRANSPORT Breakdown Pie',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget: Breakdown of Transport, Breakdown Comparison with ideal target
  Widget transportBreakdownComparison(String title, String subtitle) {
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
                child: Text(
                  'TRANSPORT Comparison',
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
