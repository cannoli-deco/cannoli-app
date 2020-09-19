import 'package:flutter/material.dart';

enum HomeEnergyWidgetList {
  graphBreakdown,
  graphConsumption,
}

class HomeEnergyCharts extends StatefulWidget {
  @override
  _HomeEnergyChartsState createState() => _HomeEnergyChartsState();
}

class _HomeEnergyChartsState extends State<HomeEnergyCharts> {
  // TODO: implement live db data
  // TODO: Add graph widgets here
  // Widget: Breakdown of Home Energy, Pie chart (Category Comparison)
  Widget homeEnergyPieBreakdown() {
    return Text(
      'HOME ENERGY BREAKDOWN PIE',
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
                onPressed: null,
              ),
              homeEnergyPieBreakdown(),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum TransportWidgetList {
  graphBreakdown,
  graphConsumption,
}

class TransportCharts extends StatefulWidget {
  @override
  _TransportChartsState createState() => _TransportChartsState();
}

class _TransportChartsState extends State<TransportCharts> {
  // TODO: implement live db data
  // TODO: Add graph widgets here
  // Widget: Breakdown of Home Energy, Pie chart (Category Comparison)
  Widget transportPieBreakdown() {
    return Text(
      'TRANSPORT BREAKDOWN PIE',
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
                onPressed: null,
              ),
              transportPieBreakdown(),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum LogWidgetList {
  generalLog,
}

class HomeEnergyLogs extends StatefulWidget {
  @override
  _HomeEnergyLogsState createState() => _HomeEnergyLogsState();
}

class _HomeEnergyLogsState extends State<HomeEnergyLogs> {
  // TODO: implement live db data
  // TODO: Add log widgets here
  // Widget: Breakdown of Home Energy, Log widget
  Widget homeEnergyGeneralLog() {
    return Text(
      'General Log',
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
                onPressed: null,
              ),
              homeEnergyGeneralLog(),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: homeEnergyPieBreakdown(),
    )
*/

/*
AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: homeEnergyPieBreakdown(),
    )
*/
