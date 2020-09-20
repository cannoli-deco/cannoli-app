import 'package:flutter/material.dart';

enum CategoryWidgetList {
  graphBreakdown,
  graphComparison,
}

class HomeEnergyCharts extends StatefulWidget {
  @override
  _HomeEnergyChartsState createState() => _HomeEnergyChartsState();
}

class _HomeEnergyChartsState extends State<HomeEnergyCharts> {
  // List to switch between graph widgets. [Breakdown, Comparison]
  List<CategoryWidgetList> _widgetList = [
    CategoryWidgetList.graphBreakdown,
    CategoryWidgetList.graphComparison
  ];
  CategoryWidgetList _currentWidget = CategoryWidgetList.graphBreakdown;

  // Function to switch between widget category groups Graph View
  Widget getWidgetGroup() {
    switch (_currentWidget) {
      case CategoryWidgetList.graphBreakdown:
        return homeEnergyPieBreakdown();
      case CategoryWidgetList.graphComparison:
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

class TransportCharts extends StatefulWidget {
  @override
  _TransportChartsState createState() => _TransportChartsState();
}

class _TransportChartsState extends State<TransportCharts> {
  // List to switch between graph widgets. [Breakdown, Comparison]
  List<CategoryWidgetList> _widgetList = [
    CategoryWidgetList.graphBreakdown,
    CategoryWidgetList.graphComparison
  ];
  CategoryWidgetList _currentWidget = CategoryWidgetList.graphBreakdown;

  // Function to switch between widget category groups Graph View
  Widget getWidgetGroup() {
    switch (_currentWidget) {
      case CategoryWidgetList.graphBreakdown:
        return transportPieBreakdown();
      case CategoryWidgetList.graphComparison:
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
