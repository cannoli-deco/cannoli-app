import 'package:flutter/material.dart';

enum WidgetList {
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
      'PIE CHART',
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

/*
AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: homeEnergyPieBreakdown(),
    )
*/
