import 'package:flutter/material.dart';

enum HomeWidgetList {
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
      'Home General Log',
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

enum TransportWidgetList {
  generalLog,
}

class TransportLogs extends StatefulWidget {
  @override
  _TransportLogsState createState() => _TransportLogsState();
}

class _TransportLogsState extends State<TransportLogs> {
  // TODO: implement live db data
  // TODO: Add log widgets here
  // Widget: Breakdown of Home Energy, Log widget
  Widget transportGeneralLog() {
    return Text(
      'Transport General Log',
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
              transportGeneralLog(),
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
