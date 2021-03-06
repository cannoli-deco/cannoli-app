import 'package:cannoli_app/widgets/log_view_widgets.dart';
import 'package:cannoli_app/widgets/textboxes.dart';
import 'package:flutter/material.dart';

import 'graph_view_widgets.dart';

// TODO: [START]Details Page: Graph View Widgets
// Add new Graph Widgets in graph_view_widgets.dart
// -------------------------------------------------------------------------------------------
// Widget: Details Page, Generates List of Transport Emission widgets needed for graph view
Widget getTransportGraphWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Transport Emissions', 18.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: TransportCharts(),
        ),
      ],
    ),
  );
}

// Widget: Details Page, Generates List of Home Energy Emission widgets needed for graph view
Widget getHomeGraphWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Home Energy Emissions', 18.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: HomeEnergyCharts(),
        ),
      ],
    ),
  );
}

// Widget: Details Page, Generates List of Important General Emission widgets needed for graph view
Widget getAllGraphWidgets() {
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
        AllCharts(),
      ],
    ),
  );
}
// -------------------------------------------------------------------------------------------
// [END]Details Page: Graph View Widgets

// TODO: [START]Details Page: Log View Widgets
// Add new Log Widgets in log_view_widgets.dart
// -------------------------------------------------------------------------------------------
// Widget: Details Page, Generates List of Transport Emission widgets needed for Log view
Widget getTransportLogWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Transport Emissions Log', 18.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Log widget',
          ),
        ),
        // Add Widgets Here
      ],
    ),
  );
}

// Widget: Details Page, Generates List of Home Energy Emission widgets needed for Log view
Widget getHomeLogWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Home Energy Emissions Log', 18.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Log widget',
          ),
        ),
        // Add Widgets Here
      ],
    ),
  );
}

// Widget: Details Page, Generates List of Important General Emission widgets needed for Log view
Widget getAllLogWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('All Emissions Log', 18.0),
          ],
        ),

        // Add Widgets Here
      ],
    ),
  );
}
// -------------------------------------------------------------------------------------------
// [END]Details Page: Log View Widgets
